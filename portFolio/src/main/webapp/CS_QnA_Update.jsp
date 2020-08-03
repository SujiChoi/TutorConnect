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
	
	/* 관리자 userNum 임의로 0000 */
	

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
      #myPageTitle {
        font-size: 40px;
        text-align: left;
        font-weight: 800;
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
      #dd{
	display: flex;
	justify-content: space-between;
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
<table cellpadding="3" align="center">
	<tr>
		<td align=center>
		<table align="center">
			<tr>
				<td style="text-align: right;padding:0px 15px;">제 목</td>
				<td>
				<input name="inqTitle" style="width:650px;" value="<%=bean.getInqTitle() %>"></td>
			</tr>
			<tr>
				<td style="text-align: right;padding:0px 15px;">내 용</td>
				<td><textarea name="inqContent" rows="17" cols="90"><%=bean.getInqContent() %></textarea></td>
			</tr>
			<tr>
			 <tr>
     			<td style="text-align: right;padding:0px 15px;">파일 수정하기</td> 
     			<td>
     			<div id="dd">
     			 <div class="filebox bs3-primary">
                            <input class="upload-name" id="fileName" value="<%=bean.getFilename()%>" disabled="disabled">
                            <label for="ex_filename">업로드</label> 
                          <input type="file" id="ex_filename" class="upload-hidden" name="filename"
                          onchange="javascript:document.getElementById('fileName').value = this.value">
		          </div>
		          <div>
		             <input type="checkbox" name="secret" value="1"
     				<%if(bean.getSecret()==1)out.print("checked");%>>비밀글
		          </div>
		          </div>
		          </td>
		    	</tr>
			<tr>
			<td></td>
				<td align="right" style="padding-top:40px;"> <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
					 <input type="hidden" name="inqNum" value="<%=bean.getInqNum()%>"> 
					 <input id="btn" type="submit" value="수정">
					 <input id="btn" type="reset" value="다시쓰기">
					 <input id="btn" type="button" value="삭제" onClick="javascript:location.href='CustomerService_QnA_Delete_Proc.jsp?inqNum=<%=bean.getInqNum()%>'">				 
					 <input id="btn" type="button" value="리스트" onClick="javascript:location.href='CS_QnA_List.jsp'">
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
    <script>
      includeHTML();
    </script>
  </body>
</html>
