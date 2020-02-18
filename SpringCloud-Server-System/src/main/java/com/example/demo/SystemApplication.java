package com.example.demo;

import com.kaleldo.annotation.EnableKaleldoAuthExceptionHandler;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.netflix.eureka.EnableEurekaClient;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;

@EnableEurekaClient
@SpringBootApplication
@EnableGlobalMethodSecurity(prePostEnabled = true)
@EnableKaleldoAuthExceptionHandler
public class SystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(SystemApplication.class, args);
    }

}
