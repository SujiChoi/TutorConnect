<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
<jsp:useBean id="smgr" class="mgr.StudentMgr"/>
<jsp:useBean id="tmgr" class="mgr.TeacherMgr"/>
<%
request.setCharacterEncoding("UTF-8");
		String nick=request.getParameter("nick");
		boolean flag=false;
		flag=smgr.isExists(nick);
%>
<html>
<head>
<title>ID체크</title>
</head>
<body>
<br>
<div align="center">
<b><%=nick%></b>
<%
 	if(flag){
	     out.println("은(는) <p/>사용 불가능한 닉네임 입니다.<p/>");
%>
<script>
	   	opener.document.studentFrm.isExistsFlag.value="no";
	   </script>
<%
	}else{    
	     out.println("은(는) <p/>사용 가능한 닉네임 입니다.<p/>");
	   %>
	   <script>
	   	opener.document.studentFrm.isExistsFlag.value="yes";
	   </script>
	   
<%
	}
%>
<a href="javascript:this.close();">닫기</a>
</div>
</body>
</html> 