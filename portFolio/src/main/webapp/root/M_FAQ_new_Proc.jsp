<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.FaqMgr"/>

<%
request.setCharacterEncoding("UTF-8");
	
	String faqtitle = request.getParameter("faqtitle");
	String faqcon = request.getParameter("faqcon"); 
	String cart = request.getParameter("faqcategory");
	
	if(faqtitle==null){
 		%>
 		<script>
 		alert("제목을 입력 해주세요.");
		</script>
 		<%
	}
 	boolean A = mgr.faqinsert(faqtitle,faqcon,cart);
	
 	if(A==true){
 		%>
 		<script>
 		alert("수정 완료 되었습니다.");
 		location.href="M_FAQ_List.jsp?category=<%=cart%>";
		</script>
 		<% 
 	}else{
 		%>
 		<script>
 		alert("작성중 오류 발생");
		</script>
 		<%
 	}
%>