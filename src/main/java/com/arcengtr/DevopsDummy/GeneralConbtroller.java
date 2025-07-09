package com.arcengtr.DevopsDummy;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class GeneralConbtroller {

    @GetMapping
    public String hello() {
        return "Hello World of DevOps";
    }

}
