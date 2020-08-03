<%@page import="mgr.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<jsp:useBean id="tMgr" class="mgr.TsearchMgr"/>   
<jsp:useBean id="bean" class="bean.TeacherBean"/>
<jsp:useBean id="rMgr" class="mgr.RootReviewMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		
		int userNum = UtilMgr.parseInt(request, "userNum");//주문번호를 정수 변환
		int fromNum = 0;
		if(request.getParameter("fromNum")!=null){
			fromNum = UtilMgr.parseInt(request, "fromNum");
		}
		int toNum = 0;
		if(request.getParameter("toNum")!=null){
			toNum = UtilMgr.parseInt(request, "toNum");
		}
		int tGrade=0;
		boolean result= false;
		String flag = request.getParameter("flag");
		String msg = "오류가 발생 하였습니다.";
		String url = "M_Tpage.jsp?userNum="+userNum;
		
		if(request.getParameter("tGrade")!=null){
			tGrade = UtilMgr.parseInt(request, "tGrade");//주문번호를 정수 변환
			
			if(flag.equals("update")){
				result = tMgr.updateTeacher(tGrade,userNum);
				if(result) {
					msg = "선생님 정보 수정완료";
					url = "M_Tpage.jsp?userNum="+userNum;
				}
			} 
		} 
		 if(flag.equals("delete")){
				result = tMgr.deleteTeacher(userNum);				
				if(result) {
					msg = "선생님 정보 삭제";
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