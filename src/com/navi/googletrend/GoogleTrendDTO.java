package com.navi.googletrend;

public class GoogleTrendDTO {
	
	private String keyWord;
	private String newsTitle;
	private String snippet;
	private String newsLink;
	private String mediaName;
	
	public String getKeyWord() {
		return keyWord;
	}
	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}
	public String getNewsTitle() {
		return newsTitle;
	}
	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}
	public String getSnippet() {
		return snippet;
	}
	public void setSnippet(String snippet) {
		this.snippet = snippet;
	}
	public String getNewsLink() {
		return newsLink;
	}
	public void setNewsLink(String newsLink) {
		this.newsLink = newsLink;
	}
	public String getMediaName() {
		return mediaName;
	}
	public void setMediaName(String mediaName) {
		this.mediaName = mediaName;
	}
	
	@Override
	public String toString() {
		return "GoogleTrendDTO [keyWord=" + keyWord + ", newsTitle=" + newsTitle + ", snippet=" + snippet
				+ ", newsLink=" + newsLink + ", mediaName=" + mediaName + "]";
	}
	
}
