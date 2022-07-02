package com.cicd.springboot;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RequiredArgsConstructor
@RestController
public class TestApiController {

    @Value("${module.version}")
    private String version;

    @GetMapping("/version")
    public String version() {
        return String.format("Project Version: %s", version);
    }

    @GetMapping("/heartbeat")
    public Long heartbeat() {
        return System.currentTimeMillis();
    }
}
