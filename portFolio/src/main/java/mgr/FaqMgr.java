package mgr;

import java.sql.*;
import java.util.Vector;

import bean.FAQBean;

public class FaqMgr {
	private DBConnectionMgr pool;
	
	public FaqMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	public Vector<FAQBean> getFaqList(String category, int start){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<FAQBean> vlist = new Vector<FAQBean>();
		try {
			con = pool.getConnection();
			sql = "select infoNum, infoTitle, infoContent from tblfaq where faqcategory='"+category+"'order by infoNum desc LIMIT ?,10";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, start);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				FAQBean bean = new FAQBean();
				bean.setInfoNum(rs.getInt(1));
				bean.setInfoTitle(rs.getString(2));
				bean.setInfoContent(rs.getString(3));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	public int getTotalCount(String category) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from tblfaq where faqcategory=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			if(rs.next()) totalCount = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}

	public boolean faqinsert(String faqtitle,String faqcon,String cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "insert into tblfaq(faqcategory,infoTitle,infoContent) VALUES (?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,cart);
			pstmt.setString(2,faqtitle);
			pstmt.setString(3,faqcon);
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
	public boolean faqupdate(int infonum,String faqtitle,String faqcon,String cart) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update tblfaq set faqcategory=? , infoTitle=? , infoContent=? where infoNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,cart);
			pstmt.setString(2,faqtitle);
			pstmt.setString(3,faqcon);
			pstmt.setInt(4, infonum);
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
	public boolean faqdelete(int infonum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "delete from tblfaq where infoNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,infonum);
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
