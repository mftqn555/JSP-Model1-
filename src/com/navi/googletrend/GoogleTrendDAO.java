package com.navi.googletrend;

import java.util.ArrayList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.navi.googletrend.GoogleTrendDTO;

public class GoogleTrendDAO {

	private static String getTagValue(String tag, Element eElement) {
	    NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
	    Node nValue = (Node) nlList.item(0);
	    if(nValue == null) 
	        return null;
	    return nValue.getNodeValue();
	}

	public ArrayList<Object> getGoogleTrend() {
		
		ArrayList<Object> gTrendList = new ArrayList<Object>();
	
		try{
				String url = "https://trends.google.com/trends/trendingsearches/daily/rss?geo=KR";
				
				DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
				Document doc = dBuilder.parse(url);
				
				doc.getDocumentElement().normalize();
				
				NodeList nList = doc.getElementsByTagName("item");
				
				for(int temp = 0; temp < nList.getLength(); temp++){
					Node nNode = nList.item(temp);
					if(nNode.getNodeType() == Node.ELEMENT_NODE){
						
						Element eElement = (Element) nNode;	
						
						GoogleTrendDTO gTrend = new GoogleTrendDTO();
						
						gTrend.setKeyWord(getTagValue("title", eElement));
						gTrend.setNewsTitle(getTagValue("ht:news_item_title", eElement));
						gTrend.setSnippet(getTagValue("ht:news_item_snippet", eElement));
						gTrend.setNewsLink(getTagValue("ht:news_item_url", eElement));
						gTrend.setMediaName(getTagValue("ht:news_item_source", eElement));
						
						gTrendList.add(gTrend);
					}	
				}	
		} catch (Exception e){	
			e.printStackTrace();
		}	
		return gTrendList;
		
	}	
}	


