package bean;

public class MessageBean {
	private int num; //번호 자동증가
	private int fromNum; //보낸사람
	private int toNum; //받는사람
	private String message; //메세지
	private String sendTime; //보낸시간
	private String ip; //ip
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
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getSendTime() {
		return sendTime;
	}
	public void setSendTime(String sendTime) {
		this.sendTime = sendTime;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
	
	
}
