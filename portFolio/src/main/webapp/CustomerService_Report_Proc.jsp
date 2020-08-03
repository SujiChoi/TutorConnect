<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.ReportMgr"/>
<%	
	request.setCharacterEncoding("UTF-8");

	String msg = "신고 대상을 확인하세요";
	String url = "CS_Report.jsp";

  	boolean result = mgr.insertReport(request);
  	
 	if(result){
		msg = "신고 글 등록 완료";
		url = "CS_QnA_List.jsp";
	} 
%>
<script> 
	alert("<%=msg%>");
	location.href="<%=url%>";    
</script>