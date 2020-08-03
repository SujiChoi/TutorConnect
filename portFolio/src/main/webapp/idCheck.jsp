<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.ReportMgr"/>
<%
request.setCharacterEncoding("UTF-8");
		String toNum = request.getParameter("toNum");
		String option = request.getParameter("option");
		int userNum=0;
		if(session.getAttribute("userNum")!=null){
			userNum=(Integer)session.getAttribute("userNum");
		}
		
		
%>
<html>
<head>
<title>ID체크</title>
</head>
<body>
<br>
<div align="center">
<%
if(option.equals("id")) userNum = mgr.checkId(toNum); 
else if(option.equals("TnickName")) userNum = mgr.checkTNickname(toNum);
else if(option.equals("SnickName")) userNum = mgr.checkSNickname(toNum);
else if(option.equals("UserNum")) if(mgr.checkUsernum(toNum)!=0) userNum = Integer.parseInt(toNum);  
%>
<b><%=toNum%></b>
<%
 	if(userNum!=0){
	     out.println("은(는) <p/>존재하는 사용자 입니다.<p/>");
	}else{    
	     out.println("은(는) <p/>존재하지 않는 사용자 입니다.<p/>");
	}
%>
<a href="javascript:this.close();">닫기</a>
</div>
</body>
</html> 