package com.navi.weather;

public class WeatherDTO {
	
	private String fcstTime;
	private String value;
	private String category;
	
	private long nx;
	private long ny;
	
	public long getNx() {
		return nx;
	}
	public void setNx(long nx) {
		this.nx = nx;
	}
	public long getNy() {
		return ny;
	}
	public void setNy(long ny) {
		this.ny = ny;
	}
	public String getFcstTime() {
		return fcstTime;
	}
	public void setFcstTime(String fcstTime) {
		this.fcstTime = fcstTime;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	@Override
	public String toString() {
		return "WeatherDTO [fcstTime=" + fcstTime + ", value=" + value + ", category=" + category + ", nx=" + nx
				+ ", ny=" + ny + "]";
	}


}
