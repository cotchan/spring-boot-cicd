package com.cicd.springboot;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Arrays;
import java.util.List;


@RequiredArgsConstructor
@RestController
public class TestApiController {

    @Value("${module.version}")
    private String version;

    private final Environment env;

    @GetMapping("/")
    public String getEnvironment() {
        List<String> profiles = Arrays.asList(env.getActiveProfiles());
        List<String> realProfiles = Arrays.asList("prod1", "prod2");
        String defaultProfile = profiles.isEmpty() ? "default" : profiles.get(0);

        return profiles.stream()
                .filter(realProfiles::contains)
                .findAny()
                .orElse(defaultProfile);
    }

    @GetMapping("/version")
    public String version() {
        return String.format("Project Version: %s", version);
    }

    @GetMapping("/heartbeat")
    public Long heartbeat() {
        return System.currentTimeMillis();
    }
}
