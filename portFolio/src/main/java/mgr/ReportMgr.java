package mgr;

import java.io.File;
import java.sql.*;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.ReportBean;

public class ReportMgr {
	
	private DBConnectionMgr pool;
	 String SAVEFOLDER = "/home/hosting_users/busanit4033/tomcat/webapps/ROOT/resources/img";
	 String ENCTYPE = "UTF-8";
	 int MAXSIZE = 10*1024*1024;
	
	public ReportMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public int checkId(String userId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int userNum = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT userNum FROM tbluser WHERE userid=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if(rs.next()) userNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userNum;
	}
	
	public int checkTNickname(String nickName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int userNum = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT userNum FROM tblteacher WHERE tNickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) userNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}		
		return userNum;
	}
	
	public int checkSNickname(String nickName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int userNum = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT userNum FROM tblstudent WHERE sNickname=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, nickName);
			rs = pstmt.executeQuery();
			if(rs.next()) userNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userNum;
	}
	
	public int checkUsernum(String num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int userNum = 0;
		try {
			con = pool.getConnection();
			sql = "SELECT userNum FROM tbluser WHERE userNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) userNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return userNum;
	}
	
	public boolean insertReport(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			String option = multi.getParameter("option");
			String a = multi.getParameter("toNum");
			System.out.println(option +" "+ a);
			int usernum =0;
		 	if(option.equals("id")) usernum = checkId(a); 
		 	else if(option.equals("TnickName")) usernum = checkTNickname(a);
		 	else if(option.equals("SnickName")) usernum = checkSNickname(a);
		 	else if(option.equals("UserNum")) if(checkUsernum(a)!=0) usernum = Integer.parseInt(a);
			con = pool.getConnection();
			sql = "insert tblreport (fromNum, toNum, reportContent, reportDate, reportImage,reportCheck) values(?,?,?,now(),?,1)";
			pstmt = con.prepareStatement(sql);
			if(usernum==0) 
				return false;
			pstmt.setString(1, multi.getParameter("fromNum"));
			pstmt.setInt(2, usernum);
			pstmt.setString(3, multi.getParameter("reportContent"));				
			if(multi.getFilesystemName("filename")!=null) { //사용자가 파일 업로드 한 경우
				pstmt.setString(4, multi.getFilesystemName("filename"));
			}
			else pstmt.setString(4, null);
			
			System.out.println(pstmt.toString());
			if(pstmt.executeUpdate()==1) flag = true;
			System.out.println(flag);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public ReportBean getReport(int ReportNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ReportBean bean = new ReportBean();
		try {
			con = pool.getConnection();
			sql = "select toNum, reportContent, reportImage from tblreport where reportNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ReportNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setToNum(rs.getInt(1));
				bean.setReportContent(rs.getString(2));
				bean.setReportImage(rs.getString(3));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return bean;
	}

}
