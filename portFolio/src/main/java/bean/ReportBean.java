package bean;

public class ReportBean {
	private int reportNum; //신고번호
	private int fromNum; //신고자
	private int toNum; //신고대상
	private String reportContent; //신고내용
	private String reportDate; //신고시간
	private String reportImage; //이미지파일이름
	private int reportCheck;//대기, 완료
	private String fromId;
	private String toId;
	public String getFromId() {
		return fromId;
	}
	public void setFromId(String fromId) {
		this.fromId = fromId;
	}
	public String getToId() {
		return toId;
	}
	public void setToId(String toId) {
		this.toId = toId;
	}
	public int getReportNum() {
		return reportNum;
	}
	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
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
	public String getReportContent() {
		return reportContent;
	}
	public void setReportContent(String reportContent) {
		this.reportContent = reportContent;
	}
	public String getReportDate() {
		return reportDate;
	}
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}
	public String getReportImage() {
		return reportImage;
	}
	public void setReportImage(String reportImage) {
		this.reportImage = reportImage;
	}
	public int getReportCheck() {
		return reportCheck;
	}
	public void setReportCheck(int reportCheck) {
		this.reportCheck =reportCheck;
	}
	
	

}
