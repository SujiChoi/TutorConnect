package mgr;

import java.sql.*;
import java.util.Vector;

import bean.ReviewBean;

public class ReviewMgr {
	private DBConnectionMgr pool;
	public ReviewMgr() {
		pool=DBConnectionMgr.getInstance();
	}
	public int getTotalRecord(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalRecord=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from tblreview where fromNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalRecord=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalRecord;
	}
	public Vector<ReviewBean> getReviewList(int userNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			sql = "select num, fromnum, tonum,"
					+ " reviewcontent, ip, reviewavailable, reviewrate"
					+ " from tblreview where fromNum=? order by num desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean=new ReviewBean();
				bean.setNum(rs.getInt(1));
				bean.setFromNum(rs.getInt(2));
				bean.setToNum(rs.getInt(3));
				bean.setReviewContent(rs.getString(4));
				bean.setIp(rs.getString(5));
				bean.setReviewAvailable(rs.getInt(6));
				bean.setReviewRate(rs.getInt(7));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;

	}
	public Vector<ReviewBean> getReviewList2(int start, int cnt, int userNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			sql = "select num, fromnum, tonum,"
					+ " reviewcontent, ip, reviewavailable, reviewrate"
					+ " from tblreview where toNum=? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, cnt);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean=new ReviewBean();
				bean.setNum(rs.getInt(1));
				bean.setFromNum(rs.getInt(2));
				bean.setToNum(rs.getInt(3));
				bean.setReviewContent(rs.getString(4));
				bean.setIp(rs.getString(5));
				bean.setReviewAvailable(rs.getInt(6));
				bean.setReviewRate(rs.getInt(7));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;

	}
	public int getReviewCnt(int userNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int cnt=0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from tblreview where toNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return cnt;
	}
	public ReviewBean getReview(int fromNum, int toNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ReviewBean bean=new ReviewBean();
		try {
			con = pool.getConnection();
			sql = "select reviewContent, reviewRate from tblreview where fromNum=? and toNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fromNum);
			pstmt.setInt(2, toNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setReviewContent(rs.getString(1));
				bean.setReviewRate(rs.getInt(2));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	public boolean updateReview(ReviewBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update tblreview set reviewContent=?, reviewRate=?, ip=?, reviewAvailable=0 where fromNum=? and toNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getReviewContent());
			pstmt.setInt(2, bean.getReviewRate());
			pstmt.setString(3, bean.getIp());
			pstmt.setInt(4, bean.getFromNum());
			pstmt.setInt(5, bean.getToNum());
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
	public boolean insertReview(ReviewBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "insert into tblreview(reviewContent, reviewRate, ip, fromNum, toNum) values(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getReviewContent());
			pstmt.setInt(2, bean.getReviewRate());
			pstmt.setString(3, bean.getIp());
			pstmt.setInt(4, bean.getFromNum());
			pstmt.setInt(5, bean.getToNum());
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
	public void deleteReview(int fromNum, int toNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "delete from tblreview where fromNum=? and toNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fromNum);
			pstmt.setInt(2, toNum);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
	}
	public boolean hasReview(int fromNum, int toNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "select * from tblReview where fromNum=? and toNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fromNum);
			pstmt.setInt(2, toNum);
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
