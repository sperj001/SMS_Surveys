package com.revature.feign;

import org.springframework.stereotype.Component;

import feign.Response;
import feign.codec.ErrorDecoder;

@Component
public class FeignErrorDecoder implements ErrorDecoder {
	
	private ErrorDecoder delegate = new ErrorDecoder.Default();

	@Override
	public Exception decode(String methodKey, Response response) {
		if (response.status() >= 400 && response.status()  <= 599) {
			return new FeignException(response.status(), response.reason());
		}
		return delegate.decode(methodKey, response);
	}
}