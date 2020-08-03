<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="header.jsp" %>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="resources/js/includeHTML.js" src="resources/js/includeHTML.js"></script>
    <style>
      * {
        box-sizing: border-box;
      }
      html,
      body {
        font-family: "Raleway", sans-serif;
        margin: 0;
      }
      #contentWrap {
        padding: 0 21vw;
        height: auto;
        margin-top: 70px;
        text-align: center;
      }
    </style>
  </head>
  <body>
    <div id="contentWrap"></div>
    <div align="center" style="margin-top:200px;">
    	<img src="resources/img/service.png" width="100px" height="100px">
    	<h1>서비스 준비중 입니다.</h1>
   		<p>보다 나은 서비스 제공을 위하여 페이지 준비중에 있습니다.<p>
   		<p>빠른 시일내에 준비하여 찾아뵙겠습니다.</p>
    </div>
    <script>
      includeHTML();
    </script>
  </body>
</html>