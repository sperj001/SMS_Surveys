package com.revature.feign;

public class FeignException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1765337484494392212L;
	
	private int status;
	private String reason;

	public FeignException(int status, String reason) {
		super();
		this.status = status;
		this.reason = reason;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Override
	public String toString() {
		return "StashClientException [status=" + status + ", reason=" + reason + "]";
	}

}
