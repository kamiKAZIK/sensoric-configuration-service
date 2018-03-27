package com.sensoric.configuration.config;

import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.Arrays;
import java.util.List;

@Getter
@Setter
@ConfigurationProperties(prefix = "sensoric.security")
public class SecurityProperties {
    private UserProperties user, manager;

    public List<UserProperties> getUsers() {
        return Arrays.asList(user, manager);
    }

    @Getter
    @Setter
    public static final class UserProperties {
        private String name, password;
        private String[] roles;
    }
}
