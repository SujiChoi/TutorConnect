<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.UserBean" %>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
<jsp:useBean id="login" class="bean.UserBean"/>
<jsp:setProperty property="*" name="login"/>
<%
		request.setCharacterEncoding("UTF-8");
		String userId=request.getParameter("userId");
		String userPwd=request.getParameter("userPwd");
		String msg = "아이디나 비밀번호가 잘못되었습니다.";
		
		String url="login.jsp";
		int userNum=0;
		//관리자 ID확인
		if(userId.equals("root")&&userPwd.equals("1234")){
			session.setAttribute("userNum", 999999999);
			msg="관리자 로그인에 성공했습니다.";
			url="root/M_index.jsp";
		}else{
			
		boolean result = mgr.login(userId,userPwd);

		if(result){
			userNum=mgr.getUserNum(userId);
			session.setAttribute("userNum", userNum); 
			msg="로그인에 성공했습니다.";
			url="main.jsp";
		}
	}
%>
<script>
alert("<%=msg%>");
location.href="<%=url%>";
</script> 
