<!-- UtilMgr 임포트 teamproject에서는 안됨!!!!! -->
<%@page import="bean.UserBean"%>
<%@page import="bean.QNABean"%>
<%@page import="java.util.Vector"%>
<%@page import="mgr.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
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
		
	int totalRecord = 0;
	int numPerPage = 15;//페이지당 레코드 개수
	int pagePerBlock = 15;//블럭당 페이지 개수
	int totalPage = 0;//총 페이지 개수
	int totalBlock = 0;//총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭
	
	//검색에 필요한 변수
	String keyField = "", keyWord = "";
	//검색일때
	if(request.getParameter("keyWord")!=null){
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	totalRecord = mgr.getTotalCount(keyField, keyWord);
	
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}
	
	int start = (nowPage*numPerPage)-numPerPage;
	
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>QnA 리스트</title>
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
        color: black;
      }
      .menus3 {
        text-align: left;
        width: 150px;
        margin-top: 20px;
      }
      .menus3 > a {
        font-size: 30px;
        color: black;
      }
      #myPageMenu2 {
        width: 180px;
        height: 600px;
      }
      #myPageContents {
        width: 920px;
        height: auto;
        border-left: 1px solid gray;
        padding: 20px;
      }
      table {
      	margin-top: 20px;
      }
      table, td {
      	border-collapse: collapse; 
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
      #btn1 {
      	display: inline-block;
	    padding: .3em .5em;
	    color: #fff;
	    font-size: small;
	    line-height: normal;
	    vertical-align: middle;
	    background-color: #58c189;
	    cursor: pointer;
	    border: 1px solid #ebebeb;
	    border-bottom-color: #e2e2e2;
	    border-radius: .25em;
      }
      #inqtitle {
      	color: black;
      	font-size: 16px;
      }
      th {
      	background-color: #dbdbdb;
      	text-align: center;
      }
       a.up{
		color:darkgrey;
		}
       .review {
        border-radius: 6px;
        padding: 20px;        
      }
       .trth {
			background-color: rgb(224, 224, 224);
			text-align: center;
			height: 30px;
			font-size: 20px;
		}
	.trtd {
			border-bottom: 2px solid rgb(224, 224, 224);
			background-color: white;
			text-align: center;
			font-size: 18px;
			
		}
		      #dd{
	display: flex;
      }
    </style>
    <script>
    function gotoReport(){
    	var userNum=<%=userNum%>
    	if(userNum==0){
    		alert("로그인 후에 이용 가능합니다.");
    	}else{
    		location.href="CS_QnA_Post.jsp?userNum="+userNum;
    	}
    }
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
	function paging(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	function qnaDetail(inqNum) {
		document.detail.inqNum.value=inqNum;
		document.detail.submit();
		}
	function showQnA(inqNum, fromNum, secret, depth) {
		userNum = document.detail.userNum.value;
		if(secret=="1"&&depth==1&&fromNum!=userNum) alert("비밀글은 작성자만 열람 가능");  
		else if(depth==1) location.href='CS_QnA_Show.jsp?inqNum='+inqNum;
		else if(secret=="1"&&fromNum!=userNum) alert("비밀글은 작성자만 열람 가능");  
		else if(fromNum==userNum) location.href='CS_QnA_Show.jsp?inqNum='+inqNum;
		else location.href='CS_QnA_Show.jsp?inqNum='+inqNum;  
	}
	/* function updateQnA(inqNum, fromNum , secret) {
		userNum = document.detail.userNum.value;
		if(userNum=="0000") location.href='CS_QnA_Update.jsp?inqNum='+inqNum;
		else if(secret=="1"&&fromNum!=userNum) alert("비밀글은 작성자만 열람 가능");  
		else location.href='CS_QnA_Update.jsp?inqNum='+inqNum;  
	} */
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
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
          <div id="myPageContent" align="center">
				
<!-- 게시물 번호 Start -->
<%
	Vector<QNABean> vlist = mgr.getQnaList(keyField, keyWord, start);
	int listSize = vlist.size();
	if(vlist.isEmpty()){
		%>
		 <div class="review" style="background:rgb(243, 243, 243); margin:0px 10%;">
     			<h1 style="text-align: center;">
					<span style="color:gray;">등록된</span>
					<span style="color:rgb(88, 193, 137);">문의가 </span>
					<span style="color:gray;">없습니다.</span>
    			</h1>
 		</div> 
		<%
	}else{
%>
<table>
	<tr class="trth">
		<th width="15%">작성일</th>
		<th width="1000px">제목</th>
		<th width="10%">작성자</th>
	</tr>
	<%
		for(int i=0;i<numPerPage;i++){
			if(i==listSize) break;
			QNABean bean = vlist.get(i);
			String inqDate = bean.getInqDate();		
			inqDate = inqDate.substring(0,11);
			String inqTitle = bean.getInqTitle();
			int fromNum = bean.getFromNum();
			UserBean userInfo=umgr.getUser(fromNum);
			int InqNum = bean.getInqNum();
			int depth = bean.getDepth();
			String name = userInfo.getUserName();
			if(null == name){
				name = "관리자";
			}
	%>
	<tr class="trtd">
		
		<td style="text-align: center;"><%=inqDate %></td>
		<%-- javascript:location.href='CS_QnA_Update.jsp?inqNum=<%=bean.getInqNum()%>' --%>
		
		<td style="text-align:left;">
		<div id="dd">
		<%for(int j=0;j<depth;j++){%>
			&nbsp;&nbsp;&nbsp;ㄴ
			<%} %>
		<div>
		<a id="inqtitle" href="javascript:showQnA('<%=bean.getInqNum() %>','<%=bean.getFromNum()%>','<%=bean.getSecret()%>', '<%=bean.getDepth()%>')"><%=inqTitle %></a>
		</div>
		<%if(bean.getSecret()==1){ %>
		<div>
			<img alt="자물쇠" src="resources/img/lock.png" height="20px" width="20px" style="margin:2px;">
		</div>
		<%}%>
		</div>
		</td>
		<%if(!name.equals("관리자")){%>
		
		<td style="text-align: center;"><%=name %></td>
		<%}else{%>
		<td style="text-align: center;color:rgb(88, 193, 137);font-weight: bold;"><%=name %></td>
		
		<%}%>
	</tr>
	<%} //for %> 
</table>
<!-- 게시물 번호 End>
<!-- 페이징 및 블럭 Start -->
<table>
<tr>
	<td>
	<%if(totalPage>0){ %>
	<!-- 이전 블럭 -->
	<%if(nowBlock>1){ %>
		<a href="javascript:block('<%=nowBlock-1%>')">PREV</a>
	<%} %>
	<!-- 페이지 -->
	<%
		int pageStart = (nowBlock-1)*pagePerBlock+1;
		int pageEnd = (pageStart+pagePerBlock)<totalPage?pageStart+pagePerBlock:totalPage+1;
		for(;pageStart<pageEnd;pageStart++){
	%>
		<a class="up" href="javascript:paging('<%=pageStart%>')">
		<%if(nowPage==pageStart){%><font color="#00CC66"><%}%>
		<%=pageStart%>
		<%if(nowPage==pageStart){%></font><%}%>
		</a>
	<%		
		}
	%>
	<!-- 다음 블럭 -->
	<%if(totalBlock>nowBlock){ %>
		<a href="javascript:block('<%=nowBlock+1%>')">NEXT</a>
	<%} %>
	<%} %> <!-- if(totalPage>0) -->
	</td>
</tr>
</table>
<%} //if-else %>
<!-- 페이징 및 블럭 End -->
<form  name="searchFrm">
	<table  width="600" cellpadding="4" cellspacing="0">
 		<tr>
  			<td align="center" valign="bottom">
   				<select style="height: 23px" name="keyField" size="1" >
    				<option value="userName"> 작성자</option>
    				<option value="inqTitle"> 제목</option>
   				</select>
   				<input style="height: 23px" size="16" name="keyWord">
   				<input id="btn1" type="button"  value="찾기" onClick="javascript:check()">
   				<input type="hidden" name="nowPage" value="1">
  			</td>
 		</tr>
	</table>
</form>
<form name="readFrm">
	<input type="hidden" name="totalRecord" value="<%=totalRecord%>">
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="keyField" value="<%=keyField%>">
	<input type="hidden" name="keyWord" value="<%=keyWord%>">
</form>
<form name="detail" method="post">
	<input type="hidden" name="userNum" value="<%=userNum%>">
</form>
<br>
<input id="btn" type="button" value="문의하기" onclick="gotoReport()">
<p/>
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
