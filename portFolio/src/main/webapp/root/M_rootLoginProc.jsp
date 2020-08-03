<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="rMgr" class="mgr.RootMemberMgr" />
<%
	request.setCharacterEncoding("UTF-8");

	String rootid = request.getParameter("rootid");
	String rootpwd = request.getParameter("rootpwd");
	boolean rootCheck = rMgr.rootCheck(rootid, rootpwd);
    if(rootCheck) {
	    session.setAttribute("rootKey", rootid);
	    session.setAttribute("rootnum", 999999999);
%>
   <script>
   location.href="M_index.jsp";
   </script>
<%}else{%>
   <script>
   alert("입력한 정보가 정확하지 않습니다.");
   location.href="../login.jsp";
   </script>
<%}%>