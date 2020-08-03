<%@ page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <style>
      * {
        box-sizing: border-box;
      }
      html,
      body {
        font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
        margin: 0;
      }
      a {
        text-decoration: none;
      }
      #contentWrap {
        width: 600px;
        height: 300px;
        padding: 10px;
      }
      #top {
        text-align: center;
        font-size: 30px;
        font-weight: 800;
        color: rgb(88, 193, 137);
      }
      #mid {
        padding: 0 15%;
      }
      #bot {
        margin-top: 20px;
        padding: 0 35%;
      }
      .inputbox {
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
      .button {
        width: 100%;
        cursor: pointer;
        height: 60px;
        background-color: rgb(88, 193, 137);
        border: none;
        color: white;
        border-radius: 6px;
        font-size: 20px;
        font-weight: 800;
      }
    </style>
    <link
      href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-kr.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSans-jp.css"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
      rel="stylesheet"
    />
    <script>
    </script>
  </head>
  <body>
  <form method="post" name="findPwdForm" action="findPwdProc.jsp">
    <div id="contentWrap">
      <div id="top">패스워드 찾기</div>
      	<div id="mid">
      	
          <div class="inputbox">
            <div class="svg">
              <img src="resources/img/userId.svg" />
            </div>
            <input
              autocomplete="off"
              type="text"
              class="input"
              id="userId"
              name="userId"
              placeholder="아이디"
              value=""
            />
          </div>
          <div class="inputbox">
            <div class="svg" style="padding-top: 5px;">
              <img src="resources/img/email.jpg" width="32" />
            </div>
            <input
              autocomplete="off"
              type="text"
              class="input"
              id="userEmail"
              name="userEmail"
              placeholder="이메일"
              value=""
            />
          </div>
      </div>
      <div id="bot">
        <input type="submit" class="button" value="제출"/>
      </div>
    </div>
</form>    
  </body>
</html>
