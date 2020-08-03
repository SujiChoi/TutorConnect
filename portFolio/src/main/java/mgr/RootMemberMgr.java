package mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import bean.StudentBean;
import bean.TeacherBean;
import bean.UserBean;

public class RootMemberMgr {
	
	private DBConnectionMgr pool;
	
	public RootMemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//학생정보 가져오기
	public StudentBean getStudent(int userNum) {
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
			if(rs.next()) {
				bean.setUserNum(rs.getInt("userNum"));
				bean.setsRecord(rs.getInt("sRecord"));
				bean.setsYear(rs.getInt("sYear"));
				bean.setsSubject1(rs.getString("sSubject1"));
				bean.setsArea1(rs.getString("sArea1"));
				bean.setsDay(rs.getString("sDay"));
				bean.setsTime(rs.getString("sTime"));
				bean.setsFee(rs.getInt("sFee"));
				bean.setsDate(rs.getString("sDate"));
				bean.setsNickname(rs.getString("sNickname"));
				bean.setsGrade(rs.getInt("sGrade"));
				bean.setsOpen(rs.getInt("sOpen"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//선생정보 가져오기
	public TeacherBean getTeacher(int userNum) {
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
			if(rs.next()) {
				bean.setUserNum(rs.getInt("userNum"));
				//bean.setsRecord(rs.getInt("sRecord"));
				//bean.setsYear(rs.getInt("sYear"));
				//bean.setsSubject(rs.getString("sSubject"));
				//bean.setsArea(rs.getString("sArea"));
				//bean.setsDay(rs.getString("sDay"));
				//bean.setsTime(rs.getString("sTime"));
				//bean.setsFee(rs.getInt("sFee"));
				//bean.setsDate(rs.getString("sDate"));
				//bean.setsNickname(rs.getString("sNickname"));
				//bean.setsGrade(rs.getInt("sGrade"));
				//bean.setsOpen(rs.getInt("sOpen"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//학생정보 수정
	
	//선생정보 수정
	
	//회원 정보 리스트
	//keyWord : 검색어
	//start : 시작번호, cnt : 한 페이지당 가져올 게시물 개수 
	public Vector<UserBean> getUserList(String keyWord,int start, int cnt) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<UserBean> vlist = new Vector<>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				//검색이 아닌경우
				sql = "select * from tbluser limit ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, cnt);
			}else {
			sql = "select * from tbluser where userId like ? limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+keyWord+"%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, cnt);
			}
			rs = pstmt.executeQuery();
			while (rs.next()) {
				UserBean bean = new UserBean();
				bean.setUserNum(rs.getInt("userNum"));
				bean.setUserId(rs.getString("userId"));
				bean.setUserPwd(rs.getString("userPwd"));
				bean.setUserName(rs.getString("userName"));
				bean.setUserAddress(rs.getString("userAddress"));
				bean.setUserPhone(rs.getString("userPhone"));
				bean.setUserEmail(rs.getString("userEmail"));
				bean.setUserBirth(rs.getString("userBirth"));
				bean.setUserGender(rs.getString("userGender"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//상세정보 유무 확인
	 public boolean studentCheck(int userNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag = false;
			
			try {
				con = pool.getConnection();
				sql = "select * from tblstudent where userNum= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, userNum);
				rs = pstmt.executeQuery();
				
				if(rs.next())
					flag = true;
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return flag;
		}
	 public boolean teacherCheck(int userNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag = false;
			
			try {
				con = pool.getConnection();
				sql = "select * from tblteacher where userNum= ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, userNum);
				rs = pstmt.executeQuery();
				
				if(rs.next())
					flag = true;
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return flag;
		}
	 
	//회원 Total Count : 총 회원수
		public int getTotalCount(String keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if(keyWord.trim().equals("")||keyWord==null) {
					//검색이 아닌경우
					sql = "select count(*) from tbluser";
					pstmt = con.prepareStatement(sql);
				}else {
					//검색인 경우
					sql = "select count(*) from tbluser where " 
					+ "userId like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, "%"+keyWord+"%");
				}
				rs = pstmt.executeQuery();
				if(rs.next()) totalCount = rs.getInt(1);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return totalCount;
		}
	//관리자 로그인
	public boolean rootCheck(String rootid, String rootpwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select rootid, rootpwd from tblroot where rootid = ? and rootpwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rootid);
			pstmt.setString(2, rootpwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return flag;
	}
	
}
