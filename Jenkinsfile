pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'arcengtr/devops-dummy-image'
        JAR_FILE_NAME = 'target/DevOpsDummy.jar'
    }

    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning Git repository...'
                checkout scm
            }
        }

        stage('Build Spring Boot Application') {
            steps {
                echo 'Building Spring Boot application with Maven...'
                sh 'mvn clean install -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: ${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}"
                script {
                    app = docker.build("${DOCKER_IMAGE_NAME}:${env.BUILD_NUMBER}", ".")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker image to Docker Hub..."
                script {
                    docker.withRegistry("https://registry.hub.docker.com", 'dockerhub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }

        stage('Trigger Manifest Update Job') {
            steps {
                echo "Triggering 'UpdateManifest' job with DOCKERTAG: ${env.BUILD_NUMBER}"
                build job: 'UpdateManifest', parameters: [string(name: 'DOCKERTAG', value: env.BUILD_NUMBER)]
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
            cleanWs() // Agent workspace cleaning
        }
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}