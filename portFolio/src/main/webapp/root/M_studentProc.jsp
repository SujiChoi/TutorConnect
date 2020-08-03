<%@page import="mgr.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="sMgr" class="mgr.StudentMgr"/>   
<jsp:useBean id="bean" class="bean.TeacherBean"/>
<jsp:useBean id="rMgr" class="mgr.RootReviewMgr"/>
<%
		request.setCharacterEncoding("UTF-8");

		String url = null;
		
		int userNum = UtilMgr.parseInt(request, "userNum");//주문번호를 정수 변환
		int fromNum = 0;
		if(request.getParameter("fromNum")!=null){
			fromNum = UtilMgr.parseInt(request, "fromNum");
		}
		int toNum = 0;
		if(request.getParameter("toNum")!=null){
			fromNum = UtilMgr.parseInt(request, "toNum");
		}
		int tGrade=0;
		boolean result= false;
		String flag = request.getParameter("flag");
		String msg = "오류가 발생 하였습니다.";

		 if(flag.equals("delete")){
				result = sMgr.deleteStudent1(userNum);				
				if(result) {
					msg = "학생 정보 삭제";
					url = "M_memberMgr.jsp";
				}				
			}
		 if(flag.equals("update1")){ 
				result = rMgr.updateReview(fromNum, toNum);				
				if(result) {
					msg = "댓글  삭제";
					url = "M_Tpage.jsp?userNum="+userNum;
				}
			}
		// update, delete

%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>