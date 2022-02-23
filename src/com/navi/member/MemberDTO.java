package com.navi.member;

import java.sql.Date;

public class MemberDTO {
	
	private String id;
	private String pass;
	private String name;
	private String email;
	private Date reg_date;
	private int zonecode;
	private String roadAddress;
	private String jibunAddress;
	private String detailAddress;
	private String extraAddress;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public int getZonecode() {
		return zonecode;
	}
	public void setZonecode(int zonecode) {
		this.zonecode = zonecode;
	}
	public String getRoadAddress() {
		return roadAddress;
	}
	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}
	public String getJibunAddress() {
		return jibunAddress;
	}
	public void setJibunAddress(String jibunAddress) {
		this.jibunAddress = jibunAddress;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public String getExtraAddress() {
		return extraAddress;
	}
	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}
	
	@Override
	public String toString() {
		return "memberDTO [id=" + id + ", pass=" + pass + ", name=" + name + ", email=" + email + ", reg_date="
				+ reg_date + ", zonecode=" + zonecode + ", roadAddress=" + roadAddress + ", jibunAddress="
				+ jibunAddress + ", detailAddress=" + detailAddress + ", extraAddress=" + extraAddress + "]";
	}
	
	
	
	
}