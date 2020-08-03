package mgr;

import java.io.File;
import java.sql.*;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.QNABean;


public class QnaMgr {
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "/home/hosting_users/busanit4033/tomcat/webapps/ROOT/resources/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 10*1024*1024;
	
	public QnaMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public boolean insertQnA(MultipartRequest multi) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		String A = "1";
		if(multi.getParameter("secret")==null) {
			A ="0";
		}
		try {
			String filename = null;
			if(multi.getFilesystemName("filename")!=null) { 
				filename = multi.getFilesystemName("filename");
			}	
			int ref = getMaxNum() + 1;
			con = pool.getConnection();
			sql = "insert tblqna (fromNum, inqTitle, inqContent, inqDate, pos, ref, depth, filename, secret) values(?,?,?,now(),0,?,0,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, multi.getParameter("fromNum"));
			pstmt.setString(2, multi.getParameter("inqTitle"));
			pstmt.setString(3, multi.getParameter("inqContent"));
			pstmt.setInt(4, ref);
			pstmt.setString(5, filename);
			pstmt.setString(6, A);
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public int getMaxNum() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int MaxNum = 0;
		try {
			con = pool.getConnection();
			sql = "select max(inqNum) from tblqna";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) MaxNum = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return MaxNum;
	}
	
	public QNABean getQna(int inqNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		QNABean bean = new QNABean();
		try {
			con = pool.getConnection();
			sql = "select * from tblqna where inqNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, inqNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setInqNum(rs.getInt("inqNum"));
				bean.setFromNum(rs.getInt("fromNum"));
				bean.setInqTitle(rs.getString("InqTitle"));
				bean.setInqContent(rs.getString("InqContent"));
				bean.setInqDate(rs.getString("InqDate"));
				bean.setPos(rs.getInt("Pos"));
				bean.setRef(rs.getInt("Ref"));
				bean.setDepth(rs.getInt("Depth"));
				bean.setFilename(rs.getString("Filename"));
				bean.setSecret(rs.getInt("Secret"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from tblqna";
			if(keyWord.trim().equals("")||keyWord==null) { 
				sql = "select count(*) from tblqna";
				pstmt = con.prepareStatement(sql);
			}else {
				sql = "select count(*) from tblqna where "+keyField+" like ?";
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

	public Vector<QNABean> getQnaList(String keyField, String keyWord, int start){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<QNABean> vlist = new Vector<QNABean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) { 
				sql = "select inqNum ,inqDate, inqTitle, fromNum, secret, depth from tblqna order BY ref DESC, depth asc, inqDate DESC LIMIT ?,10 ";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
			}else if(keyWord!=null&keyField.equals("userName")) { 
				sql = "select inqNum ,inqDate, inqTitle, fromNum, secret, depth from tblqna, tbluser where userName like ? and userNum=fromNum order BY ref DESC, depth asc, inqDate DESC limit ?,10";
				pstmt = con.prepareStatement(sql); 
				pstmt.setString(1, "%"+keyWord+"%"); 
				pstmt.setInt(2, start);
			}else if(keyWord!=null&keyField.equals("inqTitle")) { 
				sql = "select inqNum ,inqDate, inqTitle, fromNum, secret, depth from tblqna where "+keyField+" like ? order order BY ref DESC, depth asc, inqDate DESC limit ?,10";
				pstmt = con.prepareStatement(sql); 
				pstmt.setString(1, "%"+keyWord+"%"); 
				pstmt.setInt(2, start);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				QNABean bean = new QNABean();
				bean.setInqNum(rs.getInt(1));
				bean.setInqDate(rs.getString(2));
				bean.setInqTitle(rs.getString(3));
				bean.setFromNum(rs.getInt(4));
				bean.setSecret(rs.getInt(5));
				bean.setDepth(rs.getInt(6));
				vlist.addElement(bean);
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}	
	
	public boolean updateQna(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			MultipartRequest multi = new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());
			String A = "1";
			if(multi.getParameter("secret")==null) {
				A ="0";
			}
			con = pool.getConnection();
			if(multi.getFilesystemName("filename")!=null) { //占쏙옙占쏙옙微占� 占쏙옙占쏙옙 占쏙옙占싸듸옙 占쏙옙 占쏙옙占�
				sql = "update tblqna set inqTitle=?, inqContent=?, filename=?, secret=? where inqNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("inqTitle"));
				pstmt.setString(2, multi.getParameter("inqContent"));
				pstmt.setString(3, multi.getFilesystemName("filename"));
				pstmt.setString(4, A);
				pstmt.setString(5, multi.getParameter("inqNum"));
			}else {
				sql = "update tblqna set inqTitle=?, inqContent=?, secret=? where inqNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, multi.getParameter("inqTitle"));
				pstmt.setString(2, multi.getParameter("inqContent"));
				pstmt.setString(3, A);
				pstmt.setString(4, multi.getParameter("inqNum"));
			}	
			if(pstmt.executeUpdate()==1) flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	public String getFile(int inqNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String filename = null;
		try {
			con = pool.getConnection();
			sql = "select filename from tblqna where inqnum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, inqNum);
			rs = pstmt.executeQuery();
			if(rs.next()) filename = rs.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return filename;
	}
	
	public boolean deleteQna(int inqNum, int ref) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		int a=0;
		System.out.println(inqNum+"    "+ ref);
		try {
			String filename = getFile(inqNum);
			if(filename!=null) {
				File f = new File(SAVEFOLDER+"/"+filename);
				if(f.exists()) {
					File file = new File(SAVEFOLDER+"/"+filename);
					if (file.isFile()) {
						file.delete();
					}
				}
			}
			con = pool.getConnection();
			sql = "delete from tblqna where inqNum = ? or ref=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, inqNum);
			pstmt.setInt(2, ref);
			a=pstmt.executeUpdate();
			if(a!=0) {
				flag=true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	//Reply: �떟蹂�湲� ���옣
	public boolean insertQna(int inqNum, String inqTitle, String inqContent,String ref) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblqna (fromNum, inqTitle, inqContent, inqDate, pos, ref, depth) values(0,?,?,now(),0,?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, inqTitle);
			pstmt.setString(2, inqContent);
			pstmt.setInt(3, inqNum);
			if(pstmt.executeUpdate()==1) {
				flag = true;				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	public boolean deleteQna1(int inqNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		int a=0;
		System.out.println(inqNum+"    "+ inqNum);
		try {
			String filename = getFile(inqNum);
			if(filename!=null) {
				File f = new File(SAVEFOLDER+"/"+filename);
				if(f.exists()) {
					File file = new File(SAVEFOLDER+"/"+filename);
					if (file.isFile()) {
						file.delete();
					}
				}
			}
			con = pool.getConnection();
			sql = "delete from tblqna where inqNum = ? or ref=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, inqNum);
			pstmt.setInt(2, inqNum);
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
}
