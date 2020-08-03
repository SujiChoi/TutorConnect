package bean;

public class ReviewBean {
	private int num; //번호
	private int fromNum; //보낸사람
	private int toNum; //받는사람
	private int reviewAvailable; //삭제여부
	private String reviewContent; //리뷰 내용
	private int reviewRate; //리뷰 평점
	private String ip; //ip수집
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getFromNum() {
		return fromNum;
	}
	public void setFromNum(int fromNum) {
		this.fromNum = fromNum;
	}
	public int getToNum() {
		return toNum;
	}
	public void setToNum(int toNum) {
		this.toNum = toNum;
	}
	public int getReviewAvailable() {
		return reviewAvailable;
	}
	public void setReviewAvailable(int reviewAvailable) {
		this.reviewAvailable = reviewAvailable;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public int getReviewRate() {
		return reviewRate;
	}
	public void setReviewRate(int reviewRate) {
		this.reviewRate = reviewRate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	

}
