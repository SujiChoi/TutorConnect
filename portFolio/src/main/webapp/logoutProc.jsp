<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

String lang = request.getParameter("lang");

String url = null;
String msg = null;


if(lang.equals("E")){
	url = "main_english.jsp";
}else if(lang.equals("J")){
	url = "main_japanase.jsp";
}else if(lang.equals("K")){
	url = "main.jsp";
}

session.invalidate();
%>
<script>
location.href="<%=url%>";
</script>