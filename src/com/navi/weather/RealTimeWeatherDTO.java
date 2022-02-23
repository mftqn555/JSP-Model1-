package com.navi.weather;

public class RealTimeWeatherDTO {
	// TMP(기온), REH(습도), VEC(풍향), WSD(풍속), SKY(하늘상태), POP(강수확률)
	
	private String tmp;
	private String reh;
	private String vec;
	private String wsd;
	private String sky;
	private String pop;
	private String pty;
	
	public String getPty() {
		return pty;
	}
	public void setPty(String pty) {
		this.pty = pty;
	}
	public String getTmp() {
		return tmp;
	}
	public void setTmp(String tmp) {
		this.tmp = tmp;
	}
	public String getReh() {
		return reh;
	}
	public void setReh(String reh) {
		this.reh = reh;
	}
	public String getVec() {
		return vec;
	}
	public void setVec(String vec) {
		this.vec = vec;
	}
	public String getWsd() {
		return wsd;
	}
	public void setWsd(String wsd) {
		this.wsd = wsd;
	}
	public String getSky() {
		return sky;
	}
	public void setSky(String sky) {
		this.sky = sky;
	}
	public String getPop() {
		return pop;
	}
	public void setPop(String pop) {
		this.pop = pop;
	}
	
	@Override
	public String toString() {
		return "RealTimeWeatherDTO [tmp=" + tmp + ", reh=" + reh + ", vec=" + vec + ", wsd=" + wsd + ", sky=" + sky
				+ ", pop=" + pop + ", pty=" + pty + "]";
	}

}
