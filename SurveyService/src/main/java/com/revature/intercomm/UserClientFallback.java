package com.revature.intercomm;

public class UserClientFallback implements UserClient {

	@Override
	public String findAll() {
		// TODO Auto-generated method stub
		return "Unable to locate user service at this moment!";
	}

}
