<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mail" class="mgr.MailSend"/>
<%
request.setCharacterEncoding("UTF-8");

		String id=request.getParameter("userId");
		String userEmail=request.getParameter("userEmail");
		boolean flag=mail.sendPwd(id, userEmail);
		String msg="유효하지 않은 ID나 이메일 값입니다!";
		if(flag){
			msg="당신의 이메일로 임시 패스워드를 전송 완료했습니다.";
		} 
%>
<script>
alert("<%=msg%>");
window.close();
</script>