<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.FaqMgr"/>

<%
request.setCharacterEncoding("UTF-8");


	int infonum = Integer.parseInt(request.getParameter("infonum"));
	String cart = request.getParameter("category");

 	boolean flag = mgr.faqdelete(infonum);
	  
 	if(flag==true){
 		%>
 		<script>
 		alert("성공적으로 삭제 되었습니다.");
 		location.href="M_FAQ_List.jsp?category=<%=cart%>";
		</script>
 		<%
 	}else{
 		%>
 		<script>
 		alert("작성중 오류 발생");
 		location.href="M_FAQ_List.jsp?category=<%=cart%>";

		</script>
 		<%
 	}
%>