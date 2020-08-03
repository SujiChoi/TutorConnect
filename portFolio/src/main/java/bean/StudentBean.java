package bean;

public class StudentBean {
	
	private int userNum; //회원고유번호
	private int sRecord; //학력(1-초등학생 2-중학생 3-고등학생 4-대학생 5-대학원(석,박사))
	private int sYear; //학년(0-졸업생)
	private String sSubject1; //희망 과목 (중복가능)
	private String sSubject2; //희망 과목 (중복가능)
	private String sSubject3; //희망 과목 (중복가능)
	private String sArea1; //희망 지역(중복가능)
	private String sArea2; //희망 지역(중복가능)
	private String sArea3; //희망 지역(중복가능)
	private String sDay; //주당 희망 일수
	private String sTime; //희망 과외 시간
	private int sFee; //희망 과외비 
	private String sDate; //등록시간
	private String sNickname; //닉네임
	private int sGrade; //학생등급 등급제에 사용
	private int sOpen; //정보공개여부 0-공개 1-비공개
	
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public int getsRecord() {
		return sRecord;
	}
	public void setsRecord(int sRecord) {
		this.sRecord = sRecord;
	}
	public int getsYear() {
		return sYear;
	}
	public void setsYear(int sYear) {
		this.sYear = sYear;
	}
	public String getsSubject1() {
		return sSubject1;
	}
	public void setsSubject1(String sSubject1) {
		this.sSubject1 = sSubject1;
	}
	public String getsSubject2() {
		return sSubject2;
	}
	public void setsSubject2(String sSubject2) {
		this.sSubject2 = sSubject2;
	}
	public String getsSubject3() {
		return sSubject3;
	}
	public void setsSubject3(String sSubject3) {
		this.sSubject3 = sSubject3;
	}
	public String getsArea1() {
		return sArea1;
	}
	public void setsArea1(String sArea1) {
		this.sArea1 = sArea1;
	}
	public String getsArea2() {
		return sArea2;
	}
	public void setsArea2(String sArea2) {
		this.sArea2 = sArea2;
	}
	public String getsArea3() {
		return sArea3;
	}
	public void setsArea3(String sArea3) {
		this.sArea3 = sArea3;
	}
	public String getsDay() {
		return sDay;
	}
	public void setsDay(String sDay) {
		this.sDay = sDay;
	}
	public String getsTime() {
		return sTime;
	}
	public void setsTime(String sTime) {
		this.sTime = sTime;
	}
	public int getsFee() {
		return sFee;
	}
	public void setsFee(int sFee) {
		this.sFee = sFee;
	}
	public String getsDate() {
		return sDate;
	}
	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	public String getsNickname() {
		return sNickname;
	}
	public void setsNickname(String sNickname) {
		this.sNickname = sNickname;
	}
	public int getsGrade() {
		return sGrade;
	}
	public void setsGrade(int sGrade) {
		this.sGrade = sGrade;
	}
	public int getsOpen() {
		return sOpen;
	}
	public void setsOpen(int sOpen) {
		this.sOpen = sOpen;
	}
	
	
}
