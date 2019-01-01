package com.sensoric.configuration.security;

import org.springframework.boot.actuate.autoconfigure.security.servlet.EndpointRequest;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;

@EnableConfigurationProperties(value = SecurityProperties.class)
@Configuration
class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	private static final String ROLE_USER = "USER";
	private static final String ROLE_ACTUATOR = "ACTUATOR";

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf()
				.disable()
				.authorizeRequests()
				.requestMatchers(EndpointRequest.toAnyEndpoint())
				.hasRole(ROLE_ACTUATOR)
				.anyRequest()
				.hasRole(ROLE_USER)
				.and()
				.httpBasic();
	}

	@Bean
	public UserDetailsService userDetailsService(SecurityProperties properties) {
		InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager();
		properties.getUsers()
				.stream()
				.map(this::build)
				.forEach(manager::createUser);

		return manager;
	}

	private UserDetails build(SecurityProperties.UserProperties properties) {
		return User.withUsername(properties.getName())
				.password(properties.getPassword())
				.roles(properties.getRoles())
				.build();
	}
}
