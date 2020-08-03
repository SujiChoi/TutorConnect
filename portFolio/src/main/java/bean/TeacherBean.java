package bean;

public class TeacherBean {
	private int userNum; //회원 고유번호
	private String tRecord; //최종 학력
	private int tRange; //교습 대상
	private String tSubject1;//교습과목 (중복가능) 배열
	private String tSubject2;//교습과목 (중복가능) 배열
	private String tSubject3;//교습과목 (중복가능) 배열
	private String tArea1; //희망지역 (중복가능)
	private String tArea2; //희망지역 (중복가능)
	private String tArea3; //희망지역 (중복가능)
	private String tDay; //희망요일(중복가능) 
	private String tTime; //희망 과외 시간
	private int tFee; //희망 과외비 
	private String tNickname; //닉네임
	private String tPR; //자기소개
	private int tGrade; //선생님등급(추후 사용)
	private String tDate; //등록시간
	private String tImage; //선생님 사진
	private String tFile; //선생님 과외영상
	private int tOpen; //정보공개여부
	public int getUserNum() {
		return userNum;
	}
	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}
	public String gettRecord() {
		return tRecord;
	}
	public void settRecord(String tRecord) {
		this.tRecord = tRecord;
	}
	public int gettRange() {
		return tRange;
	}
	public void settRange(int tRange) {
		this.tRange = tRange;
	}
	public String gettSubject1() {
		return tSubject1;
	}
	public void settSubject1(String tSubject1) {
		this.tSubject1 = tSubject1;
	}
	public String gettSubject2() {
		return tSubject2;
	}
	public void settSubject2(String tSubject2) {
		this.tSubject2 = tSubject2;
	}
	public String gettSubject3() {
		return tSubject3;
	}
	public void settSubject3(String tSubject3) {
		this.tSubject3 = tSubject3;
	}
	public String gettArea1() {
		return tArea1;
	}
	public void settArea1(String tArea1) {
		this.tArea1 = tArea1;
	}
	public String gettArea2() {
		return tArea2;
	}
	public void settArea2(String tArea2) {
		this.tArea2 = tArea2;
	}
	public String gettArea3() {
		return tArea3;
	}
	public void settArea3(String tArea3) {
		this.tArea3 = tArea3;
	}
	public String gettDay() {
		return tDay;
	}
	public void settDay(String tDay) {
		this.tDay = tDay;
	}
	public String gettTime() {
		return tTime;
	}
	public void settTime(String tTime) {
		this.tTime = tTime;
	}
	public int gettFee() {
		return tFee;
	}
	public void settFee(int tFee) {
		this.tFee = tFee;
	}
	public String gettNickname() {
		return tNickname;
	}
	public void settNickname(String tNickname) {
		this.tNickname = tNickname;
	}
	public String gettPR() {
		return tPR;
	}
	public void settPR(String tPR) {
		this.tPR = tPR;
	}
	public int gettGrade() {
		return tGrade;
	}
	public void settGrade(int tGrade) {
		this.tGrade = tGrade;
	}
	public String gettDate() {
		return tDate;
	}
	public void settDate(String tDate) {
		this.tDate = tDate;
	}
	public String gettImage() {
		return tImage;
	}
	public void settImage(String tImage) {
		this.tImage = tImage;
	}
	public String gettFile() {
		return tFile;
	}
	public void settFile(String tFile) {
		this.tFile = tFile;
	}
	public int gettOpen() {
		return tOpen;
	}
	public void settOpen(int tOpen) {
		this.tOpen = tOpen;
	}
	
}
