<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.MessageMgr"/>
<%
request.setCharacterEncoding("UTF-8");
		int userNum=Integer.parseInt(request.getParameter("userNum"));
		int opponentNum=Integer.parseInt(request.getParameter("opponentNum"));
		String message=request.getParameter("message");
		String ip=request.getParameter("ip");
		mgr.sendMessage(userNum, opponentNum, message, ip);
%>
<script>
location.href="chatting.jsp?userNum=<%=userNum%>&opponentNum=<%=opponentNum%>";
</script>