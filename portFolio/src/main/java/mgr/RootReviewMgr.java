package mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import bean.ReviewBean;

public class RootReviewMgr {
private DBConnectionMgr pool;
	
	public RootReviewMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//리뷰 리스트
		//keyWord : 검색어
		//start : 시작번호, cnt : 한 페이지당 가져올 게시물 개수 
	public Vector<ReviewBean> getReviewList2(int start, int cnt, int userNum, String keyWord){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ReviewBean> vlist = new Vector<ReviewBean>();
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				sql = "SELECT * FROM tblreview, tblstudent WHERE tblreview.fromNum = tblstudent.userNum AND reviewavailable=0 and toNum=? order by num desc LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, userNum);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
				
				
			}else {
				sql = "SELECT * FROM tblreview, tblstudent WHERE tblreview.fromNum = tblstudent.userNum AND reviewavailable=0 and toNum=? AND sNickname LIKE ?  order by num desc LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, userNum);
				pstmt.setString(2, "%"+keyWord+"%");
				pstmt.setInt(3, start);
				pstmt.setInt(4, cnt);
			
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ReviewBean bean=new ReviewBean();
				bean.setNum(rs.getInt("num"));
				bean.setFromNum(rs.getInt("fromNum"));
				bean.setToNum(rs.getInt("toNum"));
				bean.setReviewContent(rs.getString("reviewContent"));
				bean.setIp(rs.getString("ip"));
				bean.setReviewAvailable(rs.getInt("reviewAvailable"));
				bean.setReviewRate(rs.getInt("reviewRate"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;

	}
	public boolean updateReview(int fromNum, int toNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update tblreview set reviewAvailable=1 where fromNum=? and toNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fromNum);
			pstmt.setInt(2, toNum);
			System.out.println(fromNum+toNum);
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
	public int getTotalRecord(int userNum,String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalRecord=0;
		try {
			con = pool.getConnection();
			if(keyWord.trim().equals("")||keyWord==null) {
				sql = "select count(*) from tblreview where reviewavailable=0 and toNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, userNum);
			}else {
				sql = "SELECT COUNT(*) FROM tblreview, tblstudent WHERE tblreview.fromNum = tblstudent.userNum AND sNickname LIKE ? and toNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+keyWord+"%");
				pstmt.setInt(2, userNum);
			}
			
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

}
