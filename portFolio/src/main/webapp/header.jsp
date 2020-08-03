<%@page import="bean.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
<jsp:useBean id="mmgr" class="mgr.MessageMgr"/>

<%
	request.setCharacterEncoding("UTF-8");
		int userNum=0; //관리자 번호
		UserBean bean=new UserBean();
		int currentMsg=0;
		int userLastMessage=0;
		
		if(session.getAttribute("userNum")!=null){
			userNum=(Integer)session.getAttribute("userNum");
			bean=mgr.getUser(userNum);
			currentMsg=bean.getUserLastMessage(); 
		}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      * {
        box-sizing: border-box;
      }
      html,
      body {
        font-family: "Raleway", sans-serif;
        margin: 0;
      }
      div a {
        position: relative;
        outline: none;
        color: #fff;
        text-decoration: none;
        letter-spacing: 1px;
        font-weight: 800;
        text-shadow: 0 0 1px rgba(255, 255, 255, 0.3);
        font-size: 19px;
      }
      div a:hover,
      div a:focus {
        outline: none;
      }
      #page_top {
        width: 100%;
        height: 210px;
      }
      #pt_menu {
        width: 100%;
        height: 180px;
        display: flex;
        justify-content: space-between;
        padding: 25px 24vw;
      }
      #ptb_menu {
        width: 100%;
        height: 60px;
        display: flex;
        justify-content: space-between;
        padding: 0 21vw;
        background: rgb(88, 193, 137);
      }
      .ptb_menus {
        width: 300px;
        display: flex;
      }
      .ptb_items {
        width: 150px;
        text-align: center;
        padding: 12px 0;
        color: #ffffff;
        font-weight: 800;
      }
      .ptb_items a {
        padding: 10px;
        font-family: "Jua", sans-serif;
        color: white;
        font-size: 23px;
        font-weight: 700;
        text-shadow: none;
        -webkit-transition: color 0.3s;
        -moz-transition: color 0.3s;
        transition: color 0.3s;
      }
      .ptb_items a::before,
      .ptb_items a::after {
        position: absolute;
        left: 0;
        width: 100%;
        height: 2px;
        background: #fff;
        content: "";
        opacity: 0;
        -webkit-transition: opacity 0.3s, -webkit-transform 0.3s;
        -moz-transition: opacity 0.3s, -moz-transform 0.3s;
        transition: opacity 0.3s, transform 0.3s;
        -webkit-transform: translateY(-10px);
        -moz-transform: translateY(-10px);
        transform: translateY(-10px);
      }

      .ptb_items a::before {
        top: 0;
        -webkit-transform: translateY(-10px);
        -moz-transform: translateY(-10px);
        transform: translateY(-10px);
      }

      .ptb_items a::after {
        bottom: 0;
        -webkit-transform: translateY(10px);
        -moz-transform: translateY(10px);
        transform: translateY(10px);
      }

      .ptb_items a:hover,
      .ptb_items a:focus {
        color: #fff;
      }

      .ptb_items a:hover::before,
      .ptb_items a:focus::before,
      .ptb_items a:hover::after,
      .ptb_items a:focus::after {
        opacity: 1;
        -webkit-transform: translateY(0px);
        -moz-transform: translateY(0px);
        transform: translateY(0px);
      }
      .pt_items {
        padding-top: 105px;
      }
      .pt_items > a {
        font-size: 16px;
        color: #00c6bd;
        font-family: "Jua", sans-serif;
        font-weight: 400;
      }
      .pt_items a::before,
      .pt_items a::after {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 55px;
        height: 55px;
        border: 2px solid rgba(00, 198, 189, 0.3);
        border-radius: 50%;
        content: "";
        opacity: 0;
        -webkit-transition: -webkit-transform 0.3s, opacity 0.3s;
        -moz-transition: -moz-transform 0.3s, opacity 0.3s;
        transition: transform 0.3s, opacity 0.3s;
        -webkit-transform: translateX(-50%) translateY(-50%) scale(0.2);
        -moz-transform: translateX(-50%) translateY(-50%) scale(0.2);
        transform: translateX(-50%) translateY(-50%) scale(0.2);
      }

      .pt_items a::after {
        width: 60px;
        height: 60px;
        border-width: 6px;
        -webkit-transform: translateX(-50%) translateY(-50%) scale(0.8);
        -moz-transform: translateX(-50%) translateY(-50%) scale(0.8);
        transform: translateX(-50%) translateY(-50%) scale(0.8);
      }

      .pt_items a:hover::before,
      .pt_items a:hover::after,
      .pt_items a:focus::before,
      .pt_items a:focus::after {
        opacity: 1;
        -webkit-transform: translateX(-50%) translateY(-50%) scale(1);
        -moz-transform: translateX(-50%) translateY(-50%) scale(1);
        transform: translateX(-50%) translateY(-50%) scale(1);
      }
      #selectLanguage {
        display: flex;
        justify-content: space-between;
        padding-right: 40px;
        height: 30px;
        background-color: #eeeeee;
      }
      .slitem {
        color: #999999;
        height: 100%;
        padding: 0 15px;
        border-left: 1px solid #cccccc;
      }
      .slitem:hover {
        background-color: #cccccc;
      }
      #slright {
        display: flex;
      }
      #slleft {
        padding-left: 300px;
        padding-top: 2px;
        font-weight: 800;
        color: rgb(88, 193, 137);
      }
    </style>
    <script src="js/modernizr.custom.js"></script>
    <link
      href="https://fonts.googleapis.com/css2?family=Nanum+Pen+Script&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
      rel="stylesheet"
    />
    <script>

    </script>
  </head>
  <body>
    <div id="selectLanguage">
      <div id="slleft">
      
      	<%if(userNum==999999999){ %>
      	      	      관리자님 환영합니다!!
      	<%}else if(userNum!=0){ %>
      	      		<%=bean.getUserName()%>님 환영합니다!!
 		<%} %>
      </div>
      <div id="slright">
       <%if(userNum==999999999){ %>
        <a href="root/M_index.jsp"><div class="slitem">관리자</div></a>
      	<%} %>
        <a href="main_english.jsp"><div class="slitem">English</div></a>
        <a href="main_japanase.jsp">
          <div class="slitem" style="border-right: 1px solid #cccccc;">日本語
          </div>
        </a>
      </div>
    </div>
    <div id="page_top">
      <div id="pt_menu">
        <div class="pt_items"><a href="CS_QnA_List.jsp">고객센터</a></div>
        <div id="pt_logo">
          <a href="main.jsp"><img src="resources/img/logo2.jpg" width="250px" /></a>
        </div>
        <div class="pt_items">
          <%if(userNum==0){ %>
          <a href="login.jsp">로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="terms.jsp">회원가입</a>
          <%}else if(userNum==999999999){ %>
          &nbsp;&nbsp;&nbsp;&nbsp;<a href="logoutProc.jsp?lang=K">로그아웃</a>
          <%}else{ %>
          <a href="wishList.jsp">마이페이지</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="logoutProc.jsp?lang=K">로그아웃</a>
          <%} %>
        </div>
      </div>
      <div id="ptb_menu">
      	<div class="ptb_items"><a href="Tsearch.jsp">선생님 찾기</a></div>
        <div class="ptb_items"><a href="Ssearch.jsp">학생 찾기</a></div>
        <%if(userNum!=0){ %>
        	<%if(mgr.isTeacher(userNum)){//이 파일을 인클루드 하는 페이지에서 펑션을 생성해줘야함. 아래에 있는것도 마찬가지. %>
        	<div class="ptb_items"><a href="javascript:alreadyTeacher()">선생님 등록</a></div>
        	<%}else{ %>
        	<div class="ptb_items"><a href="joinTeacher.jsp">선생님 등록</a></div>
        	<%} %>
        <%}else{ %>
        <div class="ptb_items"><a href="login.jsp">선생님 등록</a></div>
        <%} %>
        <%if(userNum!=0){ %>
        	<%if(mgr.isStudent(userNum)){ %>
        	<div class="ptb_items"><a href="javascript:alreadyStudent()">학생 등록</a></div>
        	<%}else{ %>
        	<div class="ptb_items"><a href="joinStudent.jsp">학생 등록</a></div>
        	<%} %>
        <%}else{ %>
        <div class="ptb_items"><a href="login.jsp">학생 등록</a></div>
        <%} %>
      </div>
    </div>
  </body>
</html>
