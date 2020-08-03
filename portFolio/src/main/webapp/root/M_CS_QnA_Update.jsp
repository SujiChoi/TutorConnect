<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.QNABean"%>
<%@page import="bean.RootBean"%>
<%@ include file="M_header.jsp" %>
<jsp:useBean id="mgr" class="mgr.QnaMgr"/>
<%
request.setCharacterEncoding("UTF-8");
	userNum=0;
	if(session.getAttribute("userNum")!=null){
		userNum=(Integer)session.getAttribute("userNum");
	}
	int inqNum = Integer.parseInt(request.getParameter("inqNum"));
	QNABean bean = mgr.getQna(inqNum);
	
	/* 관리자 userNum 임의로 0000 */
	

%>
<!DOCTYPE html>
<html>
  <head>
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
      #myPageTitle {
        font-size: 40px;
        text-align: left;
        font-weight: 800;
        margin-top: 60px;
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
		PageMenu2 {
        width: 180px;
        height: 600px;
      }
      #myPageContents {
        width: 920px;
        height: 600px;
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

/* named upload */
.filebox .upload-name  {
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
      p{
      	font-size:28px;
      	font-weight: 800;
      	text-align: left;
      	margin-left: 260px;
      	
      	
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
    <div id="contentWrap">
      <div id="myPageMids" align="center">
        <div id="myPageContents" align="center">
          <div id="myPageContent" align="center">
          	<h2 align="left" style="margin:0px;">Q&A 답변 작성</h2>
		      <br>
				<form name="postFrm" method="post" action="M_CS_QnA_Update_Proc.jsp">
				<%-- <input name="fromNum" type="hidden" value="<%=bean.getFromNum()%>"> --%>
				<table cellpadding="3" align="center" style="background-color: #F5F5F5;padding:10px;">
					<tr>
						<td align=center>
						<table align="center">
							<tr>
								<td style="width:60px;">제 목    </td>
								<td  colspan="3">
								<input name="inqTitle" style="width:700px;" value="답변: <%=bean.getInqTitle() %>"></td>
							</tr>
							<tr>
								<td style="width:60px;">내 용    </td>
								<td  colspan="3">
								<textarea style="width:700px;height:300px;" name="inqContent" rows="10" cols="50">
<%=bean.getInqContent() %>

========답변 글을 쓰세요.=======

								</textarea></td>
								<input type="hidden" name="ref" value="<%=bean.getInqNum()%>">
							</tr>
							<tr align="right" >
								<td colspan="3" style="padding-top:10px;"> 
									 <input type="hidden" name="inqNum" value="<%=bean.getInqNum()%>"> 
									 <input id="btn" type="submit" value="작성">
									 <input id="btn" type="button" value="뒤로" onClick="javascript:location.href='M_CS_QnA_List.jsp'">
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
