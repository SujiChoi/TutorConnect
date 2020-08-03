<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.FaqMgr"/>

<%
request.setCharacterEncoding("UTF-8");

	String faqtitle = request.getParameter("faqtitle");
	String faqcon = request.getParameter("faqcon");
	String cart = request.getParameter("category");
	int infonum = Integer.parseInt(request.getParameter("infonum"));


 	boolean A = mgr.faqupdate(infonum,faqtitle,faqcon,cart);
	
 	if(A==true){
 		%>
 		<script> 
 		alert("수정이 완료 되었습니다.");
 		location.href="M_FAQ_List.jsp?category=<%=cart%>";
		</script>
 		<%
 	}else{
 		%>
 		<script>
 		alert("수정중 오류 발생");
		</script>
 		<%
 	}
%>
