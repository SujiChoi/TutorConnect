<%@page import="bean.UserBean"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.QNABean"%>
<jsp:useBean id="mgr" class="mgr.QnaMgr"/>
<jsp:useBean id="umgr" class="mgr.UserMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
	int userNum=0;
	int currentMsg=0; 
	UserBean abean=new UserBean();
	if(session.getAttribute("userNum")!=null){
		userNum=(Integer)session.getAttribute("userNum");
		abean=umgr.getUser(userNum);
		currentMsg=abean.getUserLastMessage();
	}
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
      }
      #myPageTitle {
        font-size: 40px;
        text-align: left;
        margin-top: 60px;
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
      #myPageMids {
        display: flex;
      }
      .menus2 {
        text-align: left;
        width: 150px;
        margin-top: 20px;
      }
      .menus2 > a {
        font-size: 30px;
        font-weight: 800;
        color: black;
      }
      .menus3 {
        text-align: left;
        width: 150px;
        margin-top: 20px;
      }
      .menus3 > a {
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
        border-left: 1px solid gray;
        padding: 20px;
        
      }
      #myPageContent{
      	height:auto;
      	margin-top:20px;
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
	width:680px;
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
	justify-content: space-between;
	padding-top:10px;
	padding-right:15px;
}
.ttt .dd2{
	display: flex;
}
.ttt .dd3{
	

.file span{
	font-weight: bold;
	font-family: "Raleway", sans-serif;
	font-size: 15px;
	border-radius: 4px;
	color: white;
	background:rgb(88, 193, 137);	
	border:1px solid rgb(88, 193, 137);
	padding: 4px;
	
}
.file{
	margin-left:5px;
	width:400px;
	text-align:left;
}
.file a{
	color:blue;
	font-size: 15px;
	font-weight: bold;
	text-decoration: underline;
}
    </style>
    <script>
	var recentNum=<%=currentMsg%>
    
    var temp=0;
    var flashflag=false;//채팅 아이콘 점멸을 위한 boolean 변수
    function flashChat(){
    	var chat=document.getElementById("page_bottom");
    	if(flashflag){
    		chat.style.backgroundColor="#FFA500";
    		flashflag=false;
    	}else{
    		chat.style.backgroundColor="red";
    		flashflag=true;
    	}
    }
    var goFlash;
    function loop() {
      var xhttp = new XMLHttpRequest();
      xhttp.onreadystatechange = function () {
        if (this.readyState == 4 && this.status == 200) {
          var data = JSON.parse(this.responseText);
          console.log(data);
          if(recentNum!=data.recentNum){//AJAX를 통해 DB에서 받아온 데이터가 페이지를 로드할때 가져온 tblmessage 최대값과 다를때
        	  goFlash=setInterval(flashChat(), 1000);//flashChat()메서드를 1초에 한번씩 실행한다
          }
          else{
          }
          temp=data.recentNum;
        }
      };
      xhttp.open("GET", "getCurrentMsg.jsp?userNum=<%=userNum%>", true);
      xhttp.send();
    }
    var checkMessage;
	checkMessage=setInterval(loop, 1000);
	var usm=<%=currentMsg%>
	if(recentNum!=usm){
		goFlash=setInterval(flashChat(), 1000);
	}//버그로 인해 사용불가.
	
    function openChatting(num){ 
		if(num==0){
			alert("채팅 기능은 로그인 후 이용하실 수 있습니다.");
		}else{
			clearInterval(checkMessage);
			document.getElementById("page_bottom").style.backgroundColor="red";//채팅 아이콘을 누를시 점멸이 멈춘다
			url="chatting.jsp?userNum="+num;
			window.open(url, "chat", "width=1000, height=601, scrollbars=no, location=no, toobar=no, menubar=no");
			/* recentNum=temp; */
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
    function down(reportImage) {
		document.downFrm.reportImage.value=reportImage;
		document.downFrm.submit();
	}
    </script>
  </head>
  <body>
    <header include-html="header.jsp"></header>
    <div id="contentWrap">
      <div id="myPageTitle">고객 센터</div>
      <hr style="margin: 25px 0px 0px 0px" />
      <div id="myPageMids">
        <div id="myPageMenu2">
          <div class="menus2">
            <a href="CS_QnA_List.jsp" style="color: rgb(88, 193, 137);">Q&A</a>
          </div>
          <div class="menus2"><a href="CS_FAQ_List.jsp?category=찾기">FAQ</a></div>
          <div class="menus3"><a href="CS_Report.jsp">신고하기</a></div>
        </div>
        <div id="myPageContents">
          <div id="myPageContent">
         


<form name="postFrm" method="post" action="CustomerService_QnA_Update_Proc.jsp?inqNum=<%=bean.getInqNum() %>" 
enctype="multipart/form-data">
<%-- <input name="fromNum" type="hidden" value="<%=bean.getFromNum()%>"> --%>
<table width="600" cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table class="ttt" align="center"  style="background-color: #f5f5f5; padding:10px; width:800px;">
			<tr>
				<td class="aaa">제 목</td>
				<td>
					<div class="ddd1">
						<div class="inqTitle" size="50" maxlength="30">
						<%=bean.getInqTitle() %>
						</div>
					</div>
				</td>
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
<img src="resources/img/<%=bean.getFilename()%>" width="550px" height="auto"><br>
<%=bean.getInqContent() %>

</pre>
<%}%>
				</div>
				</div>
				</td>
			</tr>
			<tr class="ddd3">
				<td></td>
				<td> <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
					  <div class="dd1">
					<div class="dd3" style="padding-top:10px;">
					<input type="checkbox" name="secret" value="1"<%if(bean.getSecret()==1)out.print("checked");%>>비밀글
     				</div>
					  <div class="dd2">
					 <input type="hidden" name="inqNum" value="<%=bean.getInqNum()%>"> 
					
					<%if(userNum==bean.getFromNum()&&bean.getDepth()!=1) {%>
					<div class="file" style="padding-top:5px;"><span><b>첨부파일</b></span>&nbsp;&nbsp;<%if(bean.getFilename()!=null&&!bean.getFilename().equals("")){%>
    		<a href="javascript:down('<%=bean.getFilename()%>')" style="color:#58c189; padding-right:20px;"><%=bean.getFilename()%></a>
    		
    	<%}else{out.println("첨부된 파일이 없습니다.");}%></div>
					<input id="btn" type="button" value="수정" onClick="javascript:location.href='CS_QnA_Update.jsp?inqNum=<%=bean.getInqNum()%>'">
					<input id="btn" type="button" value="삭제" onClick="javascript:location.href='CustomerService_QnA_Delete_Proc.jsp?inqNum=<%=bean.getInqNum()%>&ref=<%=bean.getInqNum()%>'">				 
					<input id="btn" type="button" value="리스트" onClick="javascript:history.back();">
					<%}else {%>
					 <input id="btn" type="button" value="리스트" onClick="javascript:history.back();">
					 <%} %>
					 </div>
					
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
    <div include-html="footer.jsp"></div>
    <div include-html="footer1.jsp"></div>
    <form method="post" name="downFrm" action="M_download.jsp">
	<input type="hidden" name="reportImage">
</form>
    <script>
      includeHTML();
    </script>
  </body>
</html>
