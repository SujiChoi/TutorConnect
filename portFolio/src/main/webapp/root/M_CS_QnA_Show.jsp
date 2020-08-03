<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.QNABean"%>
<%@page import="bean.RootBean"%>
<jsp:useBean id="mgr" class="mgr.QnaMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	int inqNum = Integer.parseInt(request.getParameter("inqNum"));
	QNABean bean = mgr.getQna(inqNum);

	

%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>문의 글 수정하기</title>
    <script src="resources/js/includeHTML.js">

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
      #contentWrap {
        padding: 0 21vw;
        height: auto;
        margin-top: 40px;
        text-align: center;
        padding-bottom: 40px;
        font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
      }

      #myPageMenu1 {
        display: flex;
        justify-content: flex-end;
      }
      .menus {
        text-align: center;
        width: 150px;
      }
      .menus > a {
        font-size: 30px;
        font-weight: 800;
        color: black;
      }

      #myPageMenu2 {
        width: 180px;
        height: 600px;
      }
      #myPageContents {
        width: 920px;
        height: 600px;
        
      }
      #myPageContent{
      	height:auto;
      	margin-top:50px;
      }
      #btn {
      	display: inline-block;
	    padding: .5em .75em;
	    color: #fff;
	    font-size: inherit;
	    line-height: normal;
	    vertical-align: middle;
	    background-color: #58c189;
	    cursor: pointer;
	    border: 1px solid #ebebeb;
	    border-bottom-color: #e2e2e2;
	    border-radius: .25em;
      }
      .filebox input[type="file"] {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip:rect(0,0,0,0);
    border: 0;
}

.filebox label {
    display: inline-block;
    padding: .5em .75em;
    color: #999;
    font-size: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #fdfdfd;
    cursor: pointer;
    border: 1px solid #ebebeb;
    border-bottom-color: #e2e2e2;
    border-radius: .25em;
}

.upload-name1{

    display: inline-block;
    padding: .5em .75em;
    font-size: inherit;
    font-family: inherit;
    line-height: normal;
    vertical-align: middle;
    background-color: #f5f5f5;
  border: 1px solid #ebebeb;
  border-bottom-color: #e2e2e2;
  border-radius: .25em;
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;

}

.filebox.bs3-primary label {
  color: #fff;
    background-color: rgb(88, 193, 137);
    
}
.ttt .aaa{
	width:75px;
}
.ttt .ddd1{
	background: white;
	
}
.ttt .ddd2{
	width:680px;
	height:auto;
	background: white;

}
.ttt .ddd3{
padding-top:30px;

}
.ttt .dd1{
	display: flex;
	justify-content: flex-end;
	padding-top:10px;
	padding-right:15px;
}
.ttt .dd2{
	display: flex;
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
    <script>
    function openChatting(num){
		if(num==0){
			alert("채팅 기능은 로그인 후 이용하실 수 있습니다.");
		}else{
			url="chatting.jsp?userNum="+num;
			window.open(url, "chat", "width=1000, height=601, scrollbars=no, location=no, toobar=no, menubar=no");
		}
	}
    function alreadyStudent(){
		alert("이미 학생으로 등록되어 있습니다!");
	}
	function alreadyTeacher(){
		alert("이미 선생님으로 등록되어 있습니다!");
	}
    function downFn(upFile){
		df = document.downFrm;
		df.upFile.value=upFile;
		df.submit();
	}
    </script>
  </head>
  <body>
    <header><%@ include file="M_header.jsp" %></header>
    <div id="contentWrap">
      <div id="myPageMids" align="center">
        <div id="myPageContents" align="center">
          <div id="myPageContent" align="center">
		      <h2 align="left" style="margin:0px;">Q&A</h2>
		      <br>
				<form name="postFrm" method="post" action="CS_QnA_Update_Proc.jsp?inqNum=<%=bean.getInqNum() %>" 
				enctype="multipart/form-data">
				<%-- <input name="fromNum" type="hidden" value="<%=bean.getFromNum()%>"> --%>
				<table width="600" cellpadding="3" align="center">
					<tr>
						<td align=center>
						<table class="ttt" align="center"  style="background-color: #f5f5f5; padding:10px; width:800px;">
							<tr>
								<td class="aaa">제 목</td>
								<td colspan="2">
								<div class="ddd2" style="background-color: white;style="padding:5px 10px 5px 10px;">
								 &nbsp;&nbsp;<%=bean.getInqTitle() %>
								</div></td>
							</tr>
							<tr>
								<td class="aaa" style="vertical-align:top;">내 용</td>
<!-- 화면에 보이는 텍스트 -->
<td colspan="2"><div class="ddd2" style="padding:5px 10px 5px 10px;">
<%if (bean.getFilename()==null) {%>
<div class="inqContent" size="50" style="height:300px;">

<pre>
<%=bean.getInqContent() %>
<%}else{%>
<div class="inqContent" size="50" style="height:auto;">
<pre>
<img src="../resources/img/<%=bean.getFilename()%>" width="600px" height="auto"><br>
<%=bean.getInqContent() %>

</pre>
<%}%>
								</div>
								</div>
								</td>
							</tr>
							<tr class="ddd3">
								<td></td><!-- 1 -->
								<td><!-- 2 -->
									<input type="checkbox" name="secret" value="1"<%if(bean.getSecret()==1)out.print("checked");%>>비밀글
								</td>
								<td><!-- 3 -->
									 <div class="dd1">
								
									 <input type="hidden" name="inqNum" value="<%=bean.getInqNum()%>"> 
									<input id="btn" type="button" value="답변" onClick="javascript:location.href='M_CS_QnA_Update.jsp?inqNum=<%=bean.getInqNum()%>'">
									<input id="btn" type="button"  style="margin-left:5px;"value="삭제" onClick="javascript:location.href='M_CS_QnA_Delete_Proc.jsp?inqNum=<%=bean.getInqNum()%>&ref=<%=bean.getInqNum()%>'">				 
									<input id="btn" type="button" style="margin-left:5px;" value="리스트" onClick="javascript:history.back();">
									</div>
								</td>
								
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</form>
         	 </div>
     	 </div>
   		 </div>
    </div>
    <script>
      includeHTML();
    </script>
  </body>
</html>
