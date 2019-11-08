package com.sensoric.configuration.security;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import java.util.Arrays;
import java.util.List;

@Data
@ConfigurationProperties(prefix = "sensoric.security")
class SecurityProperties {
	private UserProperties user, manager;

	List<UserProperties> getUsers() {
		return Arrays.asList(user, manager);
	}

	@Data
	static final class UserProperties {
		private String name, password;
		private String[] roles;
	}
}
