<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>과외커넥터 관리자페이지</title>
    <script src="../resources/js/includeHTML.js"></script>
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
        margin-top: 200px;
        text-align: center;
      }
      span{
      font-size:20px;
      font-weight:800;
      margin-top:200px;
      }
    </style>
  </head>
  <body>
    <header><%@ include file="M_header.jsp" %> </header>
    <div id="contentWrap">
    	<span>관리자 페이지 입니다.</span>
    </div>
    <script>
      includeHTML();
    </script>
  </body>
</html>
