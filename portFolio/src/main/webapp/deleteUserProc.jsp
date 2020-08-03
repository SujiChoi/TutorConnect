<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="umgr" class="mgr.UserMgr"/>
<jsp:useBean id="smgr" class="mgr.StudentMgr"/>
<jsp:useBean id="tmgr" class="mgr.TeacherMgr"/>
<jsp:useBean id="mmgr" class="mgr.MatchMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		int userNum=Integer.parseInt(request.getParameter("userNum"));
		umgr.deleteUser(userNum);
		smgr.deleteStudent(userNum);
		tmgr.deleteTeacher(userNum);
		mmgr.deleteMatch(userNum);
		session.invalidate();
%>
<script>
alert("회원 탈퇴 처리가 완료되었습니다.");
location.href="main.jsp";
</script>
