<%@page import="bean.UserBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="umgr" class="mgr.UserMgr"/>
<jsp:useBean id="mmmgr" class="mgr.MessageMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
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
        margin: 0;
      }
      a {
        text-decoration: none;
      }
           #footer {
      	background-color: #eeeeee;
     display: flex;
    width: 100%;
  	  	 padding-left: 450px;
  	 
  	 padding-bottom: 10px;
  	 
    }

		.footer1 {
	    background-color: #eeeeee;
	    width: 100%;
	    padding-left: 460px;
	    padding-right: 400px;
	    padding-bottom: 10px;
	}
	.footer2 {
	    background-color: #eeeeee;
	    width: 100%;
	    padding-left: 440px;
	    padding-right: 430px;
	    padding-bottom: 5px;
	}
	.footerbox{
		

		
		text-align: center;
		
	}
	
	.imgfooterbox {
	    margin-top: 15px;
	}
	
 	#bottomid{ 
		padding-top: 200px;
		color: #999999;
 	} 
 	.footeritem {
 	
 	font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
 	font-weight:400;
 	 font-size: 13px;
 	 color: #999999;
  	
       padding-left: 10px;
       padding-right: 10px;
     
        border-left: 1px #cccccc;
 	}
 	
 	
 	.footeritem:hover {  background-color: #cccccc;}
 	
 	 .footerdiv{
 	  	font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
 	font-weight:400;
 	  	 color: #999999;
        padding-left: 10px;
       padding-right: 10px;
        border-left: 1px #cccccc;
  		 font-size: 13px;
 	 }
 
	
	#pimg{
		    margin-top: 0px;
		     font-size: 15px;
 	 color: #999999;
	}
	.imgdiv{
	margin-top: 20px;
	
	}
	.pclass{
	 text-align: center;
	font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
 	font-weight:400;
 	 font-size: 18px;
 	 color: #999999;
 	 
	}
	.divpadding{
	
	    padding-left: 40px;
       padding-right: 40px;
	
	}
	.imgboxdiv{
		display:flex;
		width: 200px;
		height: 47px;
	}
	.imgclass{
	 padding-top: 10px;
	padding-right: 1px;
	margin: 10px;
	}
	.imgclass1{
	 padding-top: 0px;
	padding-right: 1px;
	margin: 10px;
	}
	
	.imgtext{
	font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
 	font-weight:400;
 	 font-size: 13px;
 	 color: #999999;
		padding-top: 20px;
	
	}
	.imgtext1{
	font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
 	font-weight:400;
 	 font-size: 13px;
 	 color: #999999;
		padding-top: 10px;
	
	}
	.imgbox{
	margin-top:10px;
	padding-bottom:0px;
	}
	.fotp{
	font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
 	font-weight:400;
 	 font-size: 13px;
 	 color: #999999;
	margin:0px;
	padding-bottom: 10px;
	}
	

 
    .copydiv{
    margin-bottom:10px;
    border: 1px solid;
       border-left:hidden;
        border-bottom: hidden;
        border-right:hidden;
        
    }
    
    	.fotp1{
	font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
 	font-weight:400;
 	 font-size: 13px;
 	 color: #999999;
	text-align: center;
	padding-bottom: 1px;
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
  </head>
  <body>
  <footer id="footer">
   <div class="imgfooterbox">
   <div class="imgbox"><img alt="" src="resources/img/updatelogo2.jpg"  style="width: 200px; ,height: 100px;" ></div>
   <div class="imgboxdiv"><div class="imgclass"><img alt="" src="resources/img/phoneicon.svg" ></div><div class="imgtext">010-7548-6124</div></div>
   <div class="imgboxdiv"><div class="imgclass1"><img alt="" src="resources/img/emailicon.svg" ></div><div class="imgtext1">BusanIT@naver.com</div></div></div>
  
   
<div class="divpadding">
   <div class="footerbox"><br>
	<a href="#" class="footera"><div class="footeritem"><p class="ptext">이용약관</p></div></a> 
	<a href="#" class="footera"><div class="footeritem"><p class="ptext">개인정보 처리방침</p></div></a>
	<a href="#" class="footera"><div class="footeritem"><p class="ptext">제휴제안</p></div></a>
	<a href="#" class="footera"><div class="footeritem"><p class="ptext">고객센터</p></div></a>
  </div>
  </div>

<div class="divpadding">
	<div class="footerbox"><br>
  
	  <div class="footerdiv"><p class="ptext">회사소개 </p></div>
  <div class="footerdiv"><p class="ptext">네이버 블로그</p></div>
  <div class="footerdiv"><p class="ptext">유튜브</p></div>
  
   </div>
   </div>
   
   <div class="divpadding">
   <div class="footerbox"><br>
   
   <a href="#" class="footera"><div class="footeritem"><p class="ptext">과외커넥터팀</p></div></a>
   <a href="#" class="footera"><div class="footeritem"><p class="ptext">과외커넥터팀 카카오톡</p></div></a>
   <a href="#" class="footera"><div class="footeritem"><p class="ptext">과외커넥터팀 페이스북</p></div></a>
   <a href="#" class="footera"><div class="footeritem"><p class="ptext">과외커넥터팀 인스타그램</p></div></a>
   </div>
   </div>
 <div class="divpadding">
      <div class="footerbox"><br>
      
   <div class="footerdiv"><p class="ptext">과외커넥터 소개</p></div>
   <div class="footerdiv"><p class="ptext">과외커넥터 AI</p></div>
   <div class="footerdiv"><p class="ptext">비즈니스</p></div>
   <div class="footerdiv"><p class="ptext">홍보채널</p></div>
 
   </div>
   </div>
    </footer>
      <footer class="footer1">
     <div><p class="fotp">사업자등록번호 : 244-44-77777  &nbsp;&nbsp; (48262)부산광역시 진구 525 (부산IT빌딩)</p></div>
  
  </footer>

  <footer class="footer2">
   <div class="copydiv"><p class="fotp1">COPYRIGHT @ All rights reserverd.</p></div>
   </footer>
  </body>
</html>