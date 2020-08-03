<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mgr" class="mgr.StudentMgr"/>
<%
		String sqlstart="insert into tblstudent(userNum, sRecord, sYear, sDay, sTime, sFee, sDate, sNickname, sOpen, sSubject1, sArea1";
		int userNum=Integer.parseInt(request.getParameter("userNum"));
		int sRecord=Integer.parseInt(request.getParameter("sRecord"));
		int sYear=Integer.parseInt(request.getParameter("sYear"));
		String sDay=request.getParameter("sDay");
		String sTime=request.getParameter("sTime");
		int sFee=Integer.parseInt(request.getParameter("sFee"));
		String sNickname=request.getParameter("sNickname");
		int sOpen=Integer.parseInt(request.getParameter("sOpen"));
		final String cm="','";
		String sqlsub2="";
		String sqlsub3="";
		String sqlarea2="";
		String sqlarea3="";
		String sSubject1=request.getParameter("sSubject1");
		String sSubject2=request.getParameter("sSubject2");
		String sSubject3=request.getParameter("sSubject3");
		String sArea1=request.getParameter("sArea1");
		String sArea2=request.getParameter("sArea2");
		String sArea3=request.getParameter("sArea3");
		if(!sSubject2.equals("")){
			sqlsub2=", sSubject2";
			sSubject2=",'"+sSubject2+"'";
		}
		if(!sSubject3.equals("")){
			sqlsub3=", sSubject3";
			sSubject3=",'"+sSubject3+"'";
		}
		if(!sArea2.equals("")){
			sqlarea2=", sArea2";
			sArea2=",'"+sArea2+"'";
		}
		if(!sArea3.equals("")){
			sqlarea3=", sArea3";
			sArea3=",'"+sArea3+"'";
		}
		String sql=sqlstart+sqlsub2+sqlsub3+sqlarea2+sqlarea3
				+") values('"+userNum+cm+sRecord+cm+sYear+cm+sDay+cm+sTime+cm+sFee+"',"
				+"now()"+",'"+sNickname+cm+sOpen+cm+sSubject1+cm+sArea1+"'"
				+sSubject2+sSubject3+sArea2+sArea3+")";
		String msg="학생등록 실패";
		String url="joinStudent.jsp";
		boolean result=mgr.registerStudent(sql);
		if(result){
			msg="학생등록 성공";
			url="main.jsp";
		} 
%>
<script>
alert("<%=msg%>");
location.href="<%=url%>";
</script>
