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
		int opponentNum=0;
		if(request.getParameter("opponentNum")!=null){
			userNum=Integer.parseInt(request.getParameter("userNum"));
			opponentNum=Integer.parseInt(request.getParameter("opponentNum"));
		}
		int recentNum=0;
		try{
			/* Class.forName("org.gjt.mm.mysql.Driver"); */
			conn = pool.getConnection();
			/* conn=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/teamproject?useUnicode=true&characterEncoding=EUC_KR", "root" ,"1234"); */
			sql="select max(num) from tblmessage where (toNum=? or fromNum=?) and (toNum=? or fromNum=?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, userNum);
			pstmt.setInt(2, userNum);
			pstmt.setInt(3, opponentNum);
			pstmt.setInt(4, opponentNum);
			System.out.println(userNum+" "+opponentNum);
			rs=pstmt.executeQuery();
			if(rs.next()){
				recentNum=rs.getInt(1);
			}
			
		}catch(Exception e){
			System.out.println("접속실패");
			e.printStackTrace();
		}finally{
			pool.freeConnection(conn, pstmt, rs);
		}
%>
{
"recentNum" :  "<%=recentNum%>"
}
