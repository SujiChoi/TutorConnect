<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link
      href="https://fonts.googleapis.com/css2?family=Gamja+Flower&display=swap"
      rel="stylesheet"
    />
    <style>
      * {
        box-sizing: border-box;
      }
      html,
      body {
        width: 100%;
        height: 100%;
        margin: 0;
      }
      a {
        text-decoration: none;
      }
      #contentWrap {
        position: fixed;
        left: 0;
        top: 30px;
        width: 100%;
        height: 100%;
        overflow: auto;
/*         background-color:rgb(138, 243, 187); */
      }
      #contentWrap2 {
        background-color: white;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -54%);
        width: 750px;
        height: 670px;
        padding-top: 100px;
        padding-left: 150px;
        padding-right: 150px;
        border-radius: 12px;
        border-image: linear-gradient();
        border-radius: 50%;
      }
      #top_logo {
        width: 100%;
        height: 75px;
        padding-left: 80px;
        margin-bottom: 60px;
      }
      .inputBox {
        margin-top: 15px;
        border-radius: 6px;
        border: 3px solid rgb(88, 193, 137);
        width: 100%;
        height: 60px;
        padding: 10px 10px;
        display: flex;
      }
      .input {
        width: 380px;
        height: 100%;
        border: none;
        font-size: 20px;
        color: #666666;
        font-family: "Jua", sans-serif;
        cursor: pointer;
        margin-left: 10px;
      }
      .input:focus {
        outline: none;
      }
      .wrapper {
        margin-top: 30px;
        width: 100%;
        height: 60px;
        border-radius: 6px;
        font-size: 20px;
        color: white;
        font-weight: 800;
      }
      .loginButton {
        cursor: pointer;
        padding: 14px;
        text-align: center;
        text-decoration: none;
        color: white;
        border: 3px solid rgb(88, 193, 137);
        border-bottom: 4px solid rgb(58, 163, 117);
        background-color: rgb(88, 193, 137);
        font-size: 22px;
        display: inline-block;
        border-radius: 6px;
        -webkit-transition: all 0.3s ease-in-out;
        transition: all 0.3s ease-in-out;
        width: 100%;
        height: 100%;
        font-weight: 800;
        font-family: "Jua", sans-serif;
      }
      .loginButton:hover {
        background-color: white;
        color: rgb(88, 193, 137);
        border: 3px solid rgb(88, 193, 137);
      }
      #bottomFlex {
        display: flex;
        justify-content: space-between;
        margin-top: 20px;
      }
      .bfItems > a {
        color: #00c6bd;
        font-size: 16px;
        font-family: "Jua", sans-serif;
        -webkit-transition: all 0.3s ease-in-out;
        transition: all 0.3s ease-in-out;
      }
      .bfItems > a:hover {
        color: #50d6cd;
      }
      .svg {
        width: auto;
      }
      #selectLanguage {
        display: flex;
        justify-content: flex-end;
        padding-right: 40px;
        height: 30px;
        background-color: #eeeeee;
        text-decoration: none;
        letter-spacing: 1px;
        font-weight: 800;
        text-shadow: 0 0 1px rgba(255, 255, 255, 0.3);
        font-size: 19px;
      }
      .slitem {
        color: #aaaaaa;
        height: 100%;
        padding: 0 15px;
        border-left: 1px solid #cccccc;
      }
      .slitem:hover {
        background-color: #cccccc;
      }
    </style>
    <link
      href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
      rel="stylesheet"
    />
    <script>
    function openFindPwd(){
    	window.open("findPwd.jsp", "findPwd", "width=600, height=301, scrollbars=no, location=no, toobar=no, menubar=no");
    }
    function inputCheck(){
		if(document.loginpost.userId.value==""){
			alert("아이디를 입력하세요!");
			document.loginpost.userId.focus();
		}
		else if(document.loginpost.userPwd.value==""){
			alert("패스워드를 입력하세요!");
			document.loginpost.userPwd.focus();
		}
		else{
			document.loginpost.submit();
		}
	}
    </script>
  </head>
  <body>
    <div id="selectLanguage">
      <a href="main_english.jsp"><div class="slitem">English</div></a>
      <a href="main_japanase.jsp"
        ><div class="slitem" style="border-right: 1px solid #cccccc;">
          日本語
        </div></a
      >
    </div>
    <div id="contentWrap">
      <div id="contentWrap2">
        <div id="top_logo">
          <a href="main.jsp"><img src="resources/img/logo2.jpg" width="250px" /></a>
        </div>
        <form method="post" name="loginpost" action="loginProc.jsp">
          <div class="inputBox">
            <div class="svg">
              <img src="resources/img/userId.svg" width="30px" />
            </div>
            <input type="text" class="input" name="userId" value="" placeholder="아이디" />
          </div>
          <div class="inputBox">
            <div class="svg">
              <img src="resources/img/userPwd.svg" width="30px" />
            </div>
            <input
              type="password"
              class="input"
              name="userPwd"
              value=""
              placeholder="비밀번호"
            />
          </div>
          <div class="wrapper">
            <input
              type="button"
              onClick="inputCheck()"
              class="loginButton"
              value="로그인"
            />
          </div>
        </form>
        <div id="bottomFlex">
          <div class="bfItems"><a href="terms.jsp">회원가입</a></div>
          <div class="bfItems"><a href="javascript:openFindPwd()">PW 찾기</a></div>
        </div>
      </div>
    </div>
  </body>
</html>
