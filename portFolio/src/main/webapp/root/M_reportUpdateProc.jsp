<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="rMgr" class="mgr.RootReportMgr"/>

<%
request.setCharacterEncoding("UTF-8");

	int reportNum = Integer.parseInt(request.getParameter("reportNum"));
	boolean flag = rMgr.updateReport(reportNum);
	if(flag){
%>
		<script>
			alert("성공적으로 수정하였습니다");
			location.href="M_reportList.jsp";
		</script>
<%
	}else{
%>
		<script>
			alert("수정도중 에러가 발생하였습니다.");
			history.back();
		</script>
<%}%>