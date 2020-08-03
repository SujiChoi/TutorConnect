<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.QnaMgr" />

<%
	request.setCharacterEncoding("UTF-8");

	int inqNum = Integer.parseInt(request.getParameter("inqNum"));
	String inqTitle = request.getParameter("inqTitle");
	String inqContent = request.getParameter("inqContent");
	String ref = request.getParameter("ref");

	String msg = "오류 발생";
	String url = "M_CS_QnA_Update.jsp?inqNum="+inqNum;
	
	boolean result = mgr.insertQna(inqNum,inqTitle,inqContent,ref);
	if(result){
		msg = "작성 완료"; 
		url = "M_CS_QnA_List.jsp";
	} 
%>
<script> 
	alert("<%=msg%>");
	location.href="<%=url%>"; 
</script>