pipeline {
    agent any

    tools {
        maven "M3"
    }

    stages {
        stage('Build Maven') {
            steps {
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ArcenGTR/DevopsDummy']])
                sh 'mvn clean install'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t arcengtr/devops-dummy-image:latest .'
                }
            }
        }
        stage ('Push Image to DockerHub') {
            steps {
                withCredentials([string(credentialsId: 'DockerHubPwd', variable: 'DOCKERHUB_PWD')]) {
                    sh 'docker login -u arcengtr -p ${DOCKERHUB_PWD}'
                    sh 'docker push arcengtr/devops-dummy-image:latest'
                }
            }
        }
    }
}