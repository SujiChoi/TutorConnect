<%@ page contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="mgr" class="mgr.QnaMgr" />
<%
	String msg = "오류 발생";
	

	int inqNum = Integer.parseInt(request.getParameter("inqNum")); 
	String url = "M_CS_QnA_Show.jsp?inqNum="+inqNum;
	int ref= Integer.parseInt(request.getParameter("ref"));
	boolean result = mgr.deleteQna(inqNum,ref);
	if(result){
		msg = "삭제 완료";
		url = "M_CS_QnA_List.jsp";
}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script> 
