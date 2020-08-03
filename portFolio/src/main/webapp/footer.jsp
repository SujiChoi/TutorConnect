<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
		int userNum=0;
		if(session.getAttribute("userNum")!=null){
			userNum=(Integer)session.getAttribute("userNum");
		}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script>
    </script>
    <style>
      * {
        box-sizing: border-box;
      }
      html,
      body {
        margin: 0;
      }
      a {
        text-decoration: none;
      }
      #page_bottom {
      cursor:pointer;
        bottom: 20px;
        right: 20px;
        position: fixed;
        height: 60px;
        width: 60px;
        background: red;
        border-radius: 6px;
        padding: 5px;
      }
    </style>
  </head>
  <body>
    <div id="page_bottom" onclick="openChatting('<%=userNum%>')"><img src="resources/img/chat.svg" width="50px" />
    </div>
  </body>
</html>
