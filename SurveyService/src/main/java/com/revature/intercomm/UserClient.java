package com.revature.intercomm;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "user-service", fallback=UserClientFallback.class)
public interface UserClient {
	@GetMapping("/users")
	String findAll();
}
