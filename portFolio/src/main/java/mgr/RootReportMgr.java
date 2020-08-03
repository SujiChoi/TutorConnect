package mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import bean.ReportBean;

public class RootReportMgr {
	
	private DBConnectionMgr pool;
	public static final String SAVEFOLDER = "/home/hosting_users/busanit4033/tomcat/webapps/ROOT/resources/img";
	public static final String ENCTYPE = "UTF-8";
	public static int MAXSIZE = 10*1024*1024;
	
	public RootReportMgr() {
		// TODO Auto-generated constructor stub
	
		pool = DBConnectionMgr.getInstance();
	}
	//신고정보 가져오기
		public ReportBean getReport(int reportNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			ReportBean bean = new ReportBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblReport where FromNum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reportNum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setReportNum(rs.getInt("reportNum"));
					bean.setFromNum(rs.getInt("fromNum"));
					bean.setToNum(rs.getInt("toNum"));
					bean.setReportContent(rs.getString("reportContent"));
					bean.setReportDate(rs.getString("reportDate"));
					bean.setReportImage(rs.getString("reportImage"));
					bean.setReportCheck(rs.getInt("reportCheck"));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		//신고 리스트
		//keyWord : 대기, 완료
		//start : 시작번호, cnt : 한 페이지당 가져올 게시물 개수 
		public Vector<ReportBean> getReportList(int keyWord,int start, int cnt) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ReportBean> vlist = new Vector<>();
			try {
				con = pool.getConnection();
				if(keyWord==0) {
					//검색이 아닌경우
					sql = "select reportNum, b.userId fromNum,c.userId toNum,a.reportContent,a.reportDate,a.reportImage,a.reportCheck from tblreport a ,tbluser b, tbluser c WHERE a.fromNum = b.userNum AND a.toNum=c.userNum order by reportNum desc LIMIT ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);
				}else {
				sql = "select reportNum, b.userId fromNum,c.userId toNum,a.reportContent,a.reportDate,a.reportImage,a.reportCheck from tblreport a ,tbluser b, tbluser c WHERE a.fromNum = b.userNum AND a.toNum=c.userNum and reportCheck=? order by reportNum desc LIMIT ?,?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, keyWord);
				pstmt.setInt(2, start);
				pstmt.setInt(3, cnt);
				}
				rs = pstmt.executeQuery();
				while (rs.next()) {
					ReportBean bean = new ReportBean();
					bean.setReportNum(rs.getInt("reportNum"));
					bean.setFromId(rs.getString("fromNum"));
					bean.setToId(rs.getString("toNum"));
					bean.setReportContent(rs.getString("reportContent"));
					bean.setReportDate(rs.getString("reportDate"));
					bean.setReportImage(rs.getString("reportImage"));
					bean.setReportCheck(rs.getInt("reportCheck"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		//Report Total Count : 총 게시물수
		public int getTotalCount(int keyWord) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			int totalCount = 0;
			try {
				con = pool.getConnection();
				if(keyWord==0) {
					//검색이 아닌경우
					sql = "select count(*) from tblreport";
					pstmt = con.prepareStatement(sql);
				}else {
					//검색인 경우
					sql = "select count(*) from tblreport where reportCheck like ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, keyWord);
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
		//Report Update : reportCheck
		public boolean updateReport(int reportNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update tblreport set reportCheck=2 where reportNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, reportNum);
				if(pstmt.executeUpdate()==1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		

}
