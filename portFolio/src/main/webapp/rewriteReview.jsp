<%@page import="bean.UserBean"%>
<%@page import="bean.ReviewBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="rmgr" class="mgr.ReviewMgr"/>
<jsp:useBean id="tmgr" class="mgr.TeacherMgr"/>
<jsp:useBean id="umgr" class="mgr.UserMgr"/>
<%
request.setCharacterEncoding("UTF-8");
 		int userNum=Integer.parseInt(request.getParameter("userNum"));
		int toNum=Integer.parseInt(request.getParameter("toNum"));
		ReviewBean rbean=rmgr.getReview(userNum, toNum);
		UserBean userInfo=umgr.getUser(userNum);
		String tImage=tmgr.getImage(userNum);
		String ip=request.getRemoteAddr();
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
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
      #contentWrap {
        width: 800px;
        height: 200px;
        background-color: #eeeeee;
        display: flex;
        display: flex;
      }
      #reviewProfile {
        width: 150px;
        height: 100%;
        padding: 27px 25px;
      }
      #reviewContents {
        width: 650px;
        height: 100%;
        padding: 15px 15px 15px 0;
      }
      #reviewContent {
        width: 100%;
        height: 100%;
        border-radius: 6px;
        resize: none;
        border: none;
        padding: 6px;
      }
      #reviewContent:focus {
        outline: none;
      }
      #profileImage {
        padding: 0 25px;
      }
      .profileimg {
        border-radius: 50%;
        width: 50px;
        height: 50px;
      }
      #profileName {
        text-align: center;
        font-size: 16px;
        font-family: "Raleway", sans-serif;
      }
      a {
        text-decoration: none;
      }
      #star1,
      #star2,
      #star3 {
        color: red;
      }
      #star4,
      #star5 {
        color: gray;
      }
      #reviewButton {
        margin-top: 10px;
        padding: 5px 20px;
      }
      .btn {
        background-color: rgb(88, 183, 137);
        color: white;
        border: none;
        cursor: pointer;
        width: 60px;
        height: 30px;
        border-radius: 4px;
        font-weight: 800;
        font-size: 14 px;
      }
      .btn:hover {
        background-color: rgb(118, 213, 167);
      }
    </style>
    <script>
      var rates=<%=rbean.getReviewRate()%>;
      function star1() {
        document.getElementById("star1").style.color = "red";
        document.getElementById("star2").style.color = "gray";
        document.getElementById("star3").style.color = "gray";
        document.getElementById("star4").style.color = "gray";
        document.getElementById("star5").style.color = "gray";
        document.reviewForm.reviewRate.value = 1;
      }
      function star2() {
        document.getElementById("star1").style.color = "red";
        document.getElementById("star2").style.color = "red";
        document.getElementById("star3").style.color = "gray";
        document.getElementById("star4").style.color = "gray";
        document.getElementById("star5").style.color = "gray";
        document.reviewForm.reviewRate.value = 2;
      }
      function star3() {
        document.getElementById("star1").style.color = "red";
        document.getElementById("star2").style.color = "red";
        document.getElementById("star3").style.color = "red";
        document.getElementById("star4").style.color = "gray";
        document.getElementById("star5").style.color = "gray";
        document.reviewForm.reviewRate.value = 3;
      }
      function star4() {
        document.getElementById("star1").style.color = "red";
        document.getElementById("star2").style.color = "red";
        document.getElementById("star3").style.color = "red";
        document.getElementById("star4").style.color = "red";
        document.getElementById("star5").style.color = "gray";
        document.reviewForm.reviewRate.value = 4;
      }
      function star5() {
        document.getElementById("star1").style.color = "red";
        document.getElementById("star2").style.color = "red";
        document.getElementById("star3").style.color = "red";
        document.getElementById("star4").style.color = "red";
        document.getElementById("star5").style.color = "red";
        document.reviewForm.reviewRate.value = 5;
      }
      window.onload=function(){
    	  switch(rates){
          case 1:
        	  star1();
        	  break;
          case 2:
        	  star2();
        	  break;
          case 3:
        	  star3();
        	  break;
          case 4:
        	  star4();
        	  break;
          case 5:
        	  star5();
        	  break;
          }
      }
      function submitReview(){
    	  if(document.reviewForm.reviewContent.value.trim()==""){
    		  alert("내용을 입력하지 않았습니다!");
    	  }else{
    		  document.reviewForm.submit();
    	  }
      }
      
    </script>
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
    <div id="contentWrap">
      <div id="reviewProfile">
        <div id="profileImage">
          <%if(tImage!=null){ %>
          <img src="resources/img/<%=tImage %>" class="profileimg" />
          <%}else{ %>
          <img src="resources/img/anonymous.jpg" class="profileimg"/>
          <%} %>
        </div>
        <div id="profileName"><%=userInfo.getUserName()%></div>
        <div id="rate">
          <a id="star1" href="javascript:star1()">★</a>
          <a id="star2" href="javascript:star2()">★</a>
          <a id="star3" href="javascript:star3()">★</a>
          <a id="star4" href="javascript:star4()">★</a>
          <a id="star5" href="javascript:star5()">★</a>
        </div>
        <div id="reviewButton">
          <input type="button" value="전송" class="btn" onClick="submitReview()"/>
        </div>
      </div>
      <div id="reviewContents">
      	  <form method="post" name="reviewForm" action="reviewProc.jsp" style="width:100%; height:100%;">
      	  	<input type="hidden" value="update" name="flag"/>
            <input type="hidden" value="" name="reviewRate" />
            <input type="hidden" value="<%=userNum %>" name="fromNum"/>
            <input type="hidden" value="<%=toNum%>" name="toNum"/>
            <input type="hidden" value="<%=ip%>" name="ip"/>
            <textarea id="reviewContent" name="reviewContent"></textarea>
          </form>
      </div>
    </div>
  </body>
</html>
