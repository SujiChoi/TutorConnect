<%@page import="mgr.DBConnectionMgr"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
		DBConnectionMgr pool=DBConnectionMgr.getInstance();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql=null;
		int userNum=0;
		if(request.getParameter("userNum")!=null){
			userNum=Integer.parseInt(request.getParameter("userNum"));
		}
		int recentNum=0;
		try{
			conn = pool.getConnection();
			sql="select max(num) from tblmessage where toNum=?";
			System.out.println("접속 성공");
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			rs=pstmt.executeQuery();
			if(rs.next()){
				recentNum=rs.getInt(1);
			}
		}catch(Exception e){
			System.out.println("접속실패");
			e.printStackTrace();
		}finally {
			pool.freeConnection(conn, pstmt, rs);
		}
%>
{
"recentNum" :  "<%=recentNum%>"
}
