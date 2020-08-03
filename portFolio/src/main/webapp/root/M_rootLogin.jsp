<%@ page contentType="text/html; charset=UTF-8"%>


<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>과외커넥터 관리자로그인</title>
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
        margin-top: 30px;
        text-align: center;
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
      #pt_logo{
      	margin-left:360px;
      	margin-top:100px;
      }
      #loginform{
      	margin:20px;
      	
      }
    
    span{
    font-size: 20px;
    font-align:center;
    font-weight:800;
    text-align: center;
    
    }
    .iid{
    width:400px;
    height:50px;
    font-size:15px;
    margin-top:0px;
    }
    .ipwd{
    width:400px;
    height:50px;
    font-size:15px;
    margin-top:20px;
    
    }
    .ilogin{
    width:400px;
    height:50px;
    font-size:15px;
    margin-top:20px;
    border:none;
    cursor:pointer;
    color: #ffffff;
    font-weight: 800;
    font-size:20px;
    background: rgb(88, 193, 137);
    }
    input[type="text"]{ 
    height: auto; /* 높이 초기화 */ 
    line-height: normal; /* line-height 초기화 */ 
    padding: .8em .5em; /* 여백 설정 */ }


    </style>
  </head>
  <body>
  	 <div id="page_top">
      <div id="pt_menu">
        <div id="pt_logo">
          <img src="img/logo2.jpg" width="250px" />
        </div>
      </div>
      </div>
    <div id="contentWrap">
    	<div><span>관리자  로그인</span></div>
        <form id="loginform" method="post" action="M_rootLoginProc.jsp">
        
        <div class="rid">
        <input class="iid" name="rootid" type="text" placeholder="아이디"/>
        </div>
        <div class="rpwd">
        <input class="ipwd" name="rootpwd"type="text" placeholder="비밀번호"/>
        </div>
        <div class="rlogin">
        <input  class="ilogin" type="submit" value="로그인">
        </div>
        </form>
	
    </div>

    <script>
    </script>
  </body>
</html>
