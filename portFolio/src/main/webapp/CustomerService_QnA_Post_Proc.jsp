<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.QnaMgr" />
<jsp:useBean id="bean" class="bean.QNABean"/>
<jsp:setProperty property="*" name="bean"/>
<%

request.setCharacterEncoding("UTF-8");

 String SAVEFOLDER = "/home/hosting_users/busanit4033/tomcat/webapps/ROOT/resources/img";
 String ENCTYPE = "UTF-8";
 int MAXSIZE = 10*1024*1024;

 MultipartRequest multi = new MultipartRequest(request, SAVEFOLDER, MAXSIZE, ENCTYPE, new DefaultFileRenamePolicy());

	String msg = "오류 발생";
	String url = "CS_QnA_Post.jsp";
	
	boolean result = mgr.insertQnA(multi);
	if(result){
		msg = "문의 글 등록 완료";
		url = "CS_QnA_List.jsp";
	}    
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>