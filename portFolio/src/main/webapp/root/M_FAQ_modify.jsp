<%@page import="java.util.Locale.Category"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
		String faqtitle = request.getParameter("faqtitle");
		String faqcon = request.getParameter("faqcon");
		String category = request.getParameter("category");
		int infonum = Integer.parseInt(request.getParameter("infonum"));
%>

<!DOCTYPE html>
<html lang="en">
  <head>
   <script src="resources/js/includeHTML.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" /></head>
    <title>FAQ</title>
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
        margin-top: 50px;
        text-align: center;
      }
      span{
      font-size:20px;
      font-weight:800;
      margin-top:200px;
      }
      p{
      	font-size:28px;
      	font-weight: 800;
      	text-align: left;
      	margin-left: 260px;
      }
  
 .FAQwrap {
        text-align: center;
        font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
}
  .joinFlex {
        display: flex;
        padding-left:14vw;
        padding-right:10vw;
        margin-bottom: 30px;
      }
      #title {
        font-size: 40px;
        color: #666666;
      }
      .inputDesc {
        width: 140px;
        padding-top: 2px;
        color: #666666;
        font-weight: 800;
      }
      .FAQinputBox {
        width: 430px;
        height: 30px;
        border: 1px solid #666666;
        border-radius: 6px;
        padding: 5px;
      }
      .input {
        width: 100%;
        height: 100%;
        border: none;
        font-size: 14px;
      }
           .buttoncss{
           
           display: flex;
        padding-left:30vw;
        padding-right:10vw;
        margin-left: 30px;
           }
     .inputButton1  {
        cursor: pointer;
        font-size: 20px;
        background-color: rgb(88, 193, 137);
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: 800;
        margin-left:25px;
      }
        .category{
        height: 30px;
        width: 100px;
        border-radius: 6px;
        border: 1px solid #666666;
      }
      .category:focus{
      	outline:none;
      }
      
    .BackButton{
  		margin-left: 20px;
          cursor: pointer;
        font-size: 20px;
        background-color: rgb(88, 193, 137);
     	padding:1.5px 6px 1.5px 6px;
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: 800;
        text-decoration: none;
  
  }
</style>

  <script type="text/javascript">
function inputCheck1(){

  	document.faqform.submit();
	}
	

</script>
</head>
<body>    

    <header><%@ include file="M_header.jsp" %> </header>
    <div id="contentWrap">

				
				
 <form method="post" name="faqform" action="M_FAQ_modify_Proc.jsp">
		    <div class="joinFlex">
				<div>
					<h2 style="margin:0px;" align="left">FAQ 수정</h2>
				</div>
			</div>	
		<div class="FAQwrap">
		    <div class="joinFlex">
		          <div class="inputDesc">카테고리</div>
		            <select class="category" name="faqcategory">
		            	<option value="<%=category%>" selected><%=category%>
		              	<option value="찾기" selected>찾기
		              	<option value="등록">등록
		              	<option value="회원가입">회원가입
		              	<option value="로그인">로그인
		          </select>
		        </div>
				 <div class="joinFlex">
				          <div class="inputDesc">제목</div>
				          <div class="FAQinputBox">
				            <input type="text" name="faqtitle" class="input" value="<%=faqtitle %>" placeholder="" />
				          </div>
				        </div>
				        <div class="joinFlex">
				          <div class="inputDesc">내용</div>
				            <textarea rows="20" cols="60" name="faqcon" ><%=faqcon %></textarea>
				          </div>

						<div class="buttoncss">
					        <button class="inputButton1" onclick="inputCheck1()">수정 완료</button>
					        <div><a href="javascript:history.back();" class="BackButton">뒤로 가기</a></div>        
				         </div>
				<input type="hidden" name="category" value="<%=category%>">	 
				<input type="hidden" name="infonum" value="<%=infonum%>">
				        
	        </div>       
	</form>
</div>
</body>
</html>        
      