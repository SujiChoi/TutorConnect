package mgr;

import java.sql.*;
import java.util.Vector;

import bean.ReviewBean;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import bean.AreaBean;
import bean.StudentBean;
import bean.SubjectBean;
import bean.TeacherBean;
import bean.UserBean;

public class StudentMgr {
	private DBConnectionMgr pool;
	
	public StudentMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<StudentBean> getStudentList(HttpServletRequest req,String keyWord,int start, int cnt){

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<StudentBean> slist = new Vector<StudentBean>();
		
		try {
			con = pool.getConnection();
			
			boolean flag=true;

			if(req.getParameterValues("area")==null) {
				flag = false;
			}
			

			if(flag==true) {
			//request 요구조건
				String[] area = req.getParameterValues("area");
				String area1 = "";
				
				String checkall = area[0].substring(2);
				String checkarea = area[0].substring(0,2);
				if(checkall.equals("전체")) {
					for(int i =0; i<area.length;i++){
						area1 += "sArea1 like '%" + checkarea+"%' or sArea2 like '%"+checkarea + "%' or sArea3 like '%" + checkarea+"%'"+" or ";
					}
				}else {
				
					for(int i =0; i<area.length;i++){
						area1 += "sArea1 like '%" + area[i]+"%' or sArea2 like '%"+area[i] + "%' or sArea3 like '%" + area[i]+"%'"+" or ";
					}
				}
				area1 = area1.substring(0, area1.length()-4);
				
				//tArea1=서울용산구 or tArea2=서울용산구 or tArea3=서울용산구 or tArea1=서울마포구 or tArea2=서울마포구 or tArea3=서울마포구
				
				//희망과목
				String[] subject = req.getParameterValues("subject");
				String subject1 ="";
									
				for(int i =0; i<subject.length;i++){
					subject1 += "sSubject1 like '%"+subject[i]+"%' or sSubject2 like '%"+subject[i]+"%' or sSubject3 like '%"+subject[i]+"%' or " ;}
				
				subject1 = subject1.substring(0, subject1.length()-4);

				//과외비 불러오기
				
				String fbtn = req.getParameter("fbtn").substring(0, 2);
				String sfee = "";
				if(!fbtn.equals("협의")) sfee =" and s2.sFee<="+fbtn;
				
				//and t2.tFee<=30
				
				//성별 불러오기
				String gbtn = req.getParameter("gbtn");
				if(gbtn.equals("남자")) gbtn=" and s1.userGender=1";
				else if(gbtn.equals("여자")) gbtn=" and s1.userGender=2";
				else if(gbtn.equals("전체")) gbtn="";

				
				//and t1.userGender=1			
				
				//희망횟수
				
				String dbtn = req.getParameter("dbtn");
				String dcount ="";
				if(!dbtn.equals("협의")) dcount = " and s2.sDay='"+dbtn+"'"; 
				// s2.sDay='주2회'
				
				
				sql = "SELECT s1.userNum,s2.sYear, s2.sNickname, userGender, s2.sRecord, s2.sSubject1, s2.sSubject2, s2.sSubject3, s2.sDay, s2.sTime, s2.sArea1, s2.sArea2, s2.sArea3"
						+ " from tbluser s1 ,(select * from tblstudent where "+ area1+") s2,"
						+ " (select * from tblstudent where "+ subject1+") s3 "
						+ " WHERE s1.userNum=s2.userNum AND s1.userNum=s3.userNum "
						+sfee+ gbtn+dcount;
						
				pstmt = con.prepareStatement(sql);
			
			//검색하기
			}//if
			else if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "SELECT * from tblstudent,tbluser where tblstudent.userNum = tbluser.userNum ORDER by tblstudent.userNum desc LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
				}
			
			else {
					//검색인 경우
					sql = "select * from tblstudent,tbluser where tblstudent.userNum = tbluser.userNum and sNickname like ? limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
				}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				StudentBean sbean = new StudentBean();
				sbean.setUserNum(rs.getInt("userNum"));;
				sbean.setsRecord(rs.getInt("sRecord"));//최종 학력
				sbean.setsDay(rs.getString("sDay"));//희망 요일
				sbean.setsSubject1(rs.getString("sSubject1")); //교습 과목1
				sbean.setsArea1(rs.getString("sArea1"));//희망 지역1
				sbean.setsTime(rs.getString("sTime"));//희망 시간
				sbean.setsNickname(rs.getString("sNickname"));//닉네임
				sbean.setsYear(rs.getInt("sYear"));
				
				slist.addElement(sbean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return slist;
		
	}
	
	//회원 Total Count : 총 회원수
	public int getTotalCount(HttpServletRequest req,String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		
		try {
			con = pool.getConnection();
			
			boolean flag=true;

			if(req.getParameterValues("area")==null) {
				flag = false;
			}
			
			if(flag==true) {
			//request 요구조건
				
				String[] area = req.getParameterValues("area");
				String area1 = "where ";
				String checkall = area[0].substring(2);
				String checkarea = area[0].substring(0,2);
				if(checkall.equals("전체")) {
					for(int i =0; i<area.length;i++){
						area1 += "sArea1 like '%" + checkarea+"%' or sArea2 like '%"+checkarea + "%' or sArea3 like '%" + checkarea+"%'"+" or ";

					}
				}else {
				
					for(int i =0; i<area.length;i++){
						area1 += "sArea1 like '%" + area[i]+"%' or sArea2 like '%"+area[i] + "%' or sArea3 like '%" + area[i]+"%'"+" or ";
					}
				}
				
				area1 = area1.substring(0, area1.length()-4);

										
				//희망과목
				String[] subject = req.getParameterValues("subject");
				String subject1 ="";
									
				for(int i =0; i<subject.length;i++){
					subject1 += "sSubject1 like '%"+subject[i]+"%' or sSubject2 like '%"+subject[i]+"%' or sSubject3 like '%"+subject[i]+"%' or " ;}
					//subject1 += "sSubject1 like %"+subject[i]+"% or sSubject2 like %"+subject[i]+"% or sSubject3 like %"+subject[i]+"% or " ;}

				subject1 = subject1.substring(0, subject1.length()-4);

				//과외비 불러오기
				
				String fbtn = req.getParameter("fbtn").substring(0, 2);
				String sfee = "";
				if(!fbtn.equals("협의")) sfee =" and s2.sFee<="+fbtn;
				
				//and t2.tFee<=30
				
				//성별 불러오기
				String gbtn = req.getParameter("gbtn");
				if(gbtn.equals("남자")) gbtn=" and s1.userGender=1";
				else if(gbtn.equals("여자")) gbtn=" and s1.userGender=2";
				else if(gbtn.equals("전체")) gbtn="";

				//and t1.userGender=1			
				
				//희망횟수
				
				String dbtn = req.getParameter("dbtn");
				String dcount ="";
				if(!dbtn.equals("협의")) dcount = " and s2.sDay='"+dbtn+"'"; 
				// s2.sDay='주2회'
				
				
				sql = "SELECT count(*)"
						+ " from tbluser s1 ,"
						+ "(select * from tblstudent "+ area1+" ) s2"
						+ ", (select * from tblstudent where "+ subject1+") s3 "
						+ " WHERE s1.userNum=s2.userNum "
						+ "AND s1.userNum=s3.userNum "
						+sfee+ gbtn+dcount;
						
				pstmt = con.prepareStatement(sql);
			
			//검색하기
			}//if
			else if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "SELECT count(*) from tblstudent,tbluser where tblstudent.userNum = tbluser.userNum ORDER by tblstudent.userNum desc";
				pstmt = con.prepareStatement(sql);

				}
			
			else {
					//검색인 경우
					sql = "select count(*) from tblstudent,tbluser where tblstudent.userNum = tbluser.userNum and sNickname like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
				}
			System.out.println(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
	
	
	public Vector<UserBean> getUserList(HttpServletRequest req,String keyWord,int start, int cnt){

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserBean> ulist = new Vector<UserBean>();
		
		try {
			con = pool.getConnection();
			
			boolean flag=true;

			if(req.getParameterValues("area")==null) {
				flag = false;
			}
			


			if(flag==true) {
			//request 요구조건
				String[] area = req.getParameterValues("area");
				String area1 = "";
				
				String checkall = area[0].substring(2);
				String checkarea = area[0].substring(0,2);
				if(checkall.equals("전체")) {
					for(int i =0; i<area.length;i++){
						area1 += "sArea1 like '%" + checkarea+"%' or sArea2 like '%"+checkarea + "%' or sArea3 like '%" + checkarea+"%'"+" or ";
					}
				}else {
				
					for(int i =0; i<area.length;i++){
						area1 += "sArea1 like '%" + area[i]+"%' or sArea2 like '%"+area[i] + "%' or sArea3 like '%" + area[i]+"%'"+" or ";
					}
				}
				
				area1 = area1.substring(0, area1.length()-4);
				
				//tArea1=서울용산구 or tArea2=서울용산구 or tArea3=서울용산구 or tArea1=서울마포구 or tArea2=서울마포구 or tArea3=서울마포구
				
				//희망과목
				String[] subject = req.getParameterValues("subject");
				String subject1 ="";
									
				for(int i =0; i<subject.length;i++){
					subject1 += "sSubject1 like '%"+subject[i]+"%' or sSubject2 like '%"+subject[i]+"%' or sSubject3 like '%"+subject[i]+"%' or " ;}
				
				subject1 = subject1.substring(0, subject1.length()-4);

				//과외비 불러오기
				
				String fbtn = req.getParameter("fbtn").substring(0, 2);
				String sfee = "";
				if(!fbtn.equals("협의")) sfee =" and s2.sFee<="+fbtn;
				
				//and t2.tFee<=30
				
				//성별 불러오기
				String gbtn = req.getParameter("gbtn");
				if(gbtn.equals("남자")) gbtn=" and s1.userGender=1";
				else if(gbtn.equals("여자")) gbtn=" and s1.userGender=2";
				else if(gbtn.equals("전체")) gbtn="";

				
				//and t1.userGender=1			
				
				//희망횟수
				
				String dbtn = req.getParameter("dbtn");
				String dcount ="";
				if(!dbtn.equals("협의")) dcount = " and s2.sDay='"+dbtn+"'"; 
				// s2.sDay='주2회'
				
				
				sql = "SELECT s1.userNum,s2.sYear, s2.sNickname, userGender, s2.sRecord, s2.sSubject1, s2.sSubject2, s2.sSubject3, s2.sDay, s2.sTime, s2.sArea1, s2.sArea2, s2.sArea3"
						+ " from tbluser s1 ,(select * from tblstudent where "+ area1+") s2,"
						+ " (select * from tblstudent where "+ subject1+") s3 "
						+ " WHERE s1.userNum=s2.userNum AND s1.userNum=s3.userNum "
						+sfee+ gbtn+dcount;
						
				pstmt = con.prepareStatement(sql);
			
			//검색하기
			}//if
			else if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "SELECT * from tblstudent,tbluser where tblstudent.userNum = tbluser.userNum ORDER by tblstudent.userNum desc LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
				}
			
			else {
					//검색인 경우
					sql = "select * from tblstudent,tbluser where tblstudent.userNum = tbluser.userNum and sNickname LIKE ? limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
					pstmt.setInt(2, start);
					pstmt.setInt(3, cnt);
				}
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				UserBean ubean = new UserBean();
				
				ubean.setUserNum(rs.getInt("userNum"));
				ubean.setUserGender(rs.getString("userGender"));
				
				ulist.addElement(ubean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ulist;
		
	}
	
	

	public StudentBean Spage(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		StudentBean bean = new StudentBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblstudent where userNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				bean.setUserNum(rs.getInt("userNum")); //유저아이디
				bean.setsRecord(rs.getInt("sRecord")); 
				bean.setsSubject1(rs.getString("sSubject1"));//희망과목1
				bean.setsSubject2(rs.getString("sSubject2"));//희망과목2
				bean.setsSubject3(rs.getString("sSubject3"));//희망과목3
				bean.setsArea1(rs.getString("sArea1"));//희망지역1
				bean.setsArea2(rs.getString("sArea2"));//희망지역2
				bean.setsArea3(rs.getString("sArea3"));//희망지역3
				bean.setsDay(rs.getString("sDay"));//희망횟수
				bean.setsTime(rs.getString("sTime")); //희망 과외 시간
				bean.setsFee(rs.getInt("sFee"));
				bean.setsNickname(rs.getString("sNickname"));
				bean.setsGrade(rs.getInt("sGrade")); //학생등급(추후 사용)
				bean.setsOpen(rs.getInt("sOpen")); //정보공개여부
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public UserBean Sinfopage(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		UserBean bean = new UserBean();
		try {
			con = pool.getConnection();
			sql = "select * from tbluser where userNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				bean.setUserNum(rs.getInt("userNum")); 
				bean.setUserId(rs.getString("userId")); 
				bean.setUserName(rs.getString("userName")); 
				bean.setUserBirth(rs.getString("userBirth"));
				bean.setUserGender(rs.getString("userGender"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public StudentBean getStudentInfo(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		StudentBean bean = new StudentBean();
		try {
			con = pool.getConnection();
			sql = "select sNickName, sRecord, sYear, sSubject1, sSubject2, sSubject3,"
					+ " sArea1, sArea2, sArea3, sDay, sTime, sFee, sOpen from tblstudent where userNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setsNickname(rs.getString(1));
				bean.setsRecord(rs.getInt(2));
				bean.setsYear(rs.getInt(3));
				bean.setsSubject1(rs.getString(4));
				bean.setsSubject2(rs.getString(5));
				bean.setsSubject3(rs.getString(6));
				bean.setsArea1(rs.getString(7));
				bean.setsArea2(rs.getString(8));
				bean.setsArea3(rs.getString(9));
				bean.setsDay(rs.getString(10));
				bean.setsTime(rs.getString(11));
				bean.setsFee(rs.getInt(12));
				bean.setsOpen(rs.getInt(13));
				
				System.out.println(rs.getString(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;

	}
	
	public boolean isStudent(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select userNum from tblstudent where userNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	public void deleteStudent(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblstudent where userNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	
	public boolean deleteStudent1(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblstudent where userNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public boolean updateStudent(StudentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		String subject2=null, subject3=null, area2=null, area3=null;
		if(bean.getsSubject2()!=null&&!bean.getsSubject2().equals("0")) {
			subject2=bean.getsSubject2();
		}
		if(bean.getsSubject3()!=null&&!bean.getsSubject3().equals("0")) {
			subject3=bean.getsSubject3();
		}
		if(bean.getsArea2()!=null&&!bean.getsArea2().equals("Á¦°Å0")) {
			area2=bean.getsArea2();
		}
		if(bean.getsArea3()!=null&&!bean.getsArea3().equals("Á¦°Å0")) {
			area3=bean.getsArea3();
		}
		try {
			con = pool.getConnection();
			sql = "update tblstudent set sNickname=?, sRecord=?, sYear=?, sSubject1=?, sSubject2=?, sSubject3=?,"
					+ " sArea1=?, sArea2=?, sArea3=?, sDay=?, sTime=?, sFee=?, sOpen=? where userNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getsNickname());
			pstmt.setInt(2, bean.getsRecord());
			pstmt.setInt(3, bean.getsYear());
			pstmt.setString(4, bean.getsSubject1());
			pstmt.setString(5, subject2);
			pstmt.setString(6, subject3);
			pstmt.setString(7, bean.getsArea1());
			pstmt.setString(8, area2);
			pstmt.setString(9, area3);
			pstmt.setString(10, bean.getsDay());
			pstmt.setString(11, bean.getsTime());
			pstmt.setInt(12, bean.getsFee());
			pstmt.setInt(13, bean.getsOpen());
			pstmt.setInt(14, bean.getUserNum());
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	public boolean registerStudent(String sql) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			if(pstmt.executeUpdate()==1) flag=true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	public boolean isExists(String sNickName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select usernum from tblstudent where sNickName=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sNickName);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
}