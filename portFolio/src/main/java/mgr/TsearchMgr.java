package mgr;

import java.sql.*;
import java.util.*;

import bean.AreaBean;
import bean.SubjectBean;
import bean.TeacherBean;
import bean.UserBean;

public class TsearchMgr {
	private DBConnectionMgr pool;
	
	public TsearchMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//지역 리스트 불러오기(구)
	public Vector<AreaBean> TsearchArea(String area) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<AreaBean> vlist = new Vector<AreaBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * from tblarea where city = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, area);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				AreaBean bean = new AreaBean();
				bean.setCity(rs.getString(1));
				bean.setStreet(rs.getString(2));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}

	
	//과목 데이터 불러오기
	public Vector<SubjectBean> Tsearchsub(String sub) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<SubjectBean> vlist = new Vector<SubjectBean>();
		try {
			con = pool.getConnection();
			sql = "SELECT * from tblsubject where major = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, sub);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SubjectBean bean = new SubjectBean();
				bean.setMajor(rs.getString(1));
				bean.setMinor(rs.getString(2));
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public Vector<TeacherBean> TphotoList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TeacherBean> vlist = new Vector<TeacherBean>();
		try {
			
			con = pool.getConnection();
			sql = "select * from tblteacher order by rand() limit 6";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TeacherBean bean = new TeacherBean();
				
				bean.setUserNum(rs.getInt(1)); //유저아이디
				bean.settRecord(rs.getString(2)); //학교 학과
				bean.settRange(rs.getInt(3)); //교습대상
				bean.settSubject1(rs.getString(4));//희망과목1
				bean.settSubject2(rs.getString(5));//희망과목2
				bean.settSubject3(rs.getString(6));//희망과목3
				bean.settArea1(rs.getString(7));//희망지역1
				bean.settArea2(rs.getString(8));//희망지역2
				bean.settArea3(rs.getString(9));//희망지역3
				bean.settNickname(rs.getString("tNickname"));
				bean.settImage(rs.getString("tImage"));
								
				vlist.add(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public TeacherBean Tpage(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		TeacherBean bean = new TeacherBean();
		try {
			con = pool.getConnection();
			sql = "select * from tblteacher where userNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				bean.setUserNum(rs.getInt("userNum")); //유저아이디
				bean.settRecord(rs.getString("tRecord")); //학교 학과
				bean.settRange(rs.getInt("tRange")); //교습대상
				bean.settSubject1(rs.getString("tSubject1"));//희망과목1
				bean.settSubject2(rs.getString("tSubject2"));//희망과목2
				bean.settSubject3(rs.getString("tSubject3"));//희망과목3
				bean.settArea1(rs.getString("tArea1"));//희망지역1
				bean.settArea2(rs.getString("tArea2"));//희망지역2
				bean.settArea3(rs.getString("tArea3"));//희망지역3
				bean.settDay(rs.getString("tDay"));//희망횟수
				bean.settTime(rs.getString("tTime")); //희망 과외 시간
				bean.settFee(rs.getInt("tFee"));
				bean.settNickname(rs.getString("tNickname"));
				bean.settPR(rs.getString("tPR")); //자기소개
				bean.settGrade(rs.getInt("tGrade")); //선생님등급(추후 사용)
				bean.settFile(rs.getString("tFile"));
				bean.settImage(rs.getString("tImage")); //선생님 사진
				bean.settOpen(rs.getInt("tOpen")); //정보공개여부
				bean.settImage(rs.getString("tImage"));//선생님 과외영상
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public UserBean Tinfopage(int userNum) {
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
	//매칭(접속자, 매칭자)
	public void following(int userNum, int teacherNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "insert into tblmatch(follower, followed) values(?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			pstmt.setInt(2, teacherNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	//매치관계 검사
	public boolean isfollowed(int userNum, int teacherNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from tblmatch where follower=? and followed=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			pstmt.setInt(2, teacherNum);
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
	
	public String getImage(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String tImage=null;
		try {
			con = pool.getConnection();
			sql = "select timage from tblteacher where userNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				tImage=rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return tImage;
	}
	//관리자////////////////
	//선생수정
	public boolean updateTeacher(int tGrade, int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update tblteacher set tGrade=? where userNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, tGrade);
			pstmt.setInt(2, userNum);
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Teacher Delete
	public boolean deleteTeacher(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from tblteacher where userNum=?";
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

}
