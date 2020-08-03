<%@ page contentType="text/html; charset=UTF-8"%>

<%
		request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
<jsp:useBean id="bean" class="bean.UserBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
		String name=request.getParameter("userName");
		String name1 = bean.getUserName();
		
		boolean result=mgr.registerUser(bean);
		String msg="회원가입 실패";
		String url="join.jsp";
		if(result){
			msg="회원가입 성공";
			url="main.jsp";
		} 
%>
<script>
alert("<%=msg%>");
location.href="<%=url%>";
</script>
