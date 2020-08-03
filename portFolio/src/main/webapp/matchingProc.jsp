<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mmgr" class="mgr.MatchMgr"/>
<jsp:useBean id="cmgr" class="mgr.MessageMgr"/>
<%
request.setCharacterEncoding("UTF-8");
		String flags=request.getParameter("flags");
		int userNum1=Integer.parseInt(request.getParameter("userNum"));
		int userNum2=Integer.parseInt(request.getParameter("opponentNum"));
		String msg="에러 발생";
		if(flags.equals("sendMatch")){
			String ip=request.getParameter("ip");
			cmgr.sendMessage(userNum1, userNum2, "Q&KJfRv09*CmjRKlPh1!", ip);
			msg="매칭 메시지 전송 완료";
		}else if(flags.equals("match")){
			mmgr.matchCancle(userNum1, userNum2);
			mmgr.matchCancle(userNum2, userNum1);
			mmgr.matching(userNum1, userNum2);
			mmgr.matching(userNum2, userNum1);
			msg="매칭이 완료되었습니다!";
		}else if(flags.equals("decline")){
			mmgr.matchCancle(userNum2,userNum1);
			mmgr.decline(userNum1, userNum2);
			msg="매칭을 거절했습니다.";
		}else{
			mmgr.matchCancle(userNum1, userNum2);
			mmgr.matchCancle(userNum2, userNum1);
			msg="팔로잉을 취소했습니다.";
		}
%>
<script>
alert("<%=msg%>");
location.href="chatting.jsp?userNum=<%=userNum1%>&opponentNum=<%=userNum2%>";
</script>