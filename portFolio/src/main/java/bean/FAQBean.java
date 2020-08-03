package bean;

public class FAQBean {
	private String faqcategory; //카테고리
	private int infoNum; //글번호
	private String infoTitle; //Q
	private String infoContent; //A
	public String getFaqcategory() {
		return faqcategory;
	}
	public void setFaqcategory(String faqcategory) {
		this.faqcategory = faqcategory;
	}
	public int getInfoNum() {
		return infoNum;
	}
	public void setInfoNum(int infoNum) {
		this.infoNum = infoNum;
	}
	public String getInfoTitle() {
		return infoTitle;
	}
	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}
	public String getInfoContent() {
		return infoContent;
	}
	public void setInfoContent(String infoContent) {
		this.infoContent = infoContent;
	}
	
	

}
