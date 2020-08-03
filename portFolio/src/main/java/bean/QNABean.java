package bean;

public class QNABean {
	private int inqNum; //문의 번호
	private int fromNum; //문의자(회원고유번호)
	private String inqTitle; //문의제목
	private String inqContent; //문의내용
	private String inqDate; //문의일자
	private int pos; //답글이 몇번째인지
	private int ref; //답글을 단 글
	private int depth;//답글의 답글
	private int secret; // 비밀글0,1
	private String filename; //첨부파일 이름
	
	
	
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public String getInqContent() {
		return inqContent;
	}
	public void setInqContent(String inqContent) {
		this.inqContent = inqContent;
	}
	public int getInqNum() {
		return inqNum;
	}
	public void setInqNum(int inqNum) {
		this.inqNum = inqNum;
	}
	public int getFromNum() {
		return fromNum;
	}
	public void setFromNum(int fromNum) {
		this.fromNum = fromNum;
	}
	public String getInqTitle() {
		return inqTitle;
	}
	public void setInqTitle(String inqTitle) {
		this.inqTitle = inqTitle;
	}
	public String getInqDate() {
		return inqDate;
	}
	public void setInqDate(String inqDate) {
		this.inqDate = inqDate;
	}
	public int getPos() {
		return pos;
	}
	public void setPos(int pos) {
		this.pos = pos;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getSecret() {
		return secret;
	}
	public void setSecret(int secret) {
		this.secret = secret;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	
}
