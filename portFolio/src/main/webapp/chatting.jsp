<%@page import="java.sql.*"%>
<%@page import="bean.UserBean"%>
<%@page import="bean.MessageBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="umgr" class="mgr.UserMgr"/>
<jsp:useBean id="mmgr" class="mgr.MessageMgr"/>
<jsp:useBean id="match" class="mgr.MatchMgr"/>
<jsp:useBean id="tmgr" class="mgr.TeacherMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		int userNum=Integer.parseInt(request.getParameter("userNum"));
		UserBean myInfo=umgr.getUser(userNum);
		int userLastMessage=mmgr.getCurrentMsgByFooter(userNum);
		umgr.updateUserLastMessage(userNum, userLastMessage);
		//채팅 아이콘 반짝이는 효과를 페이지 이동시 사라지지 않게 하려고 넣었으나 돔 로드 이슈때문에 현재는 중단.
		String ip=request.getRemoteAddr();
		String myImg="";
		int currentMsg=0;
		if(tmgr.getImage(userNum)!=null){
			myImg=tmgr.getImage(userNum);
		}
		Vector<MessageBean> mList=new Vector<MessageBean>();
		int opponentNum=0;
		String opponentImg="";
		UserBean opponentInfo=new UserBean();
		if(request.getParameter("opponentNum")!=null){//상대가 선택 되어있을때의 처리
			opponentNum=Integer.parseInt(request.getParameter("opponentNum"));
			mmgr.updateNotRead(userNum, opponentNum);//읽지 않은 메시지 갱신
			mList=mmgr.getMessage(userNum, opponentNum);
			opponentInfo=umgr.getUser(opponentNum);
			if(tmgr.getImage(opponentNum)!=null){
				opponentImg=tmgr.getImage(opponentNum);
			}
			if(mmgr.getCurrentMsg(userNum, opponentNum)!=0){
				currentMsg=mmgr.getCurrentMsg(userNum, opponentNum);
			}//가장 최근의 메시지를 들고오는 처리. 채팅방 자동 갱신시에 사용된다.
		}
		Vector<Integer> oList=match.getOpponents(userNum);


%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- <meta http-equiv="refresh" content="15"> -->
    <title>Document</title>
    <script type="text/javascript" src="resources/js/jquery-3.5.0.min.js"></script>
    <style>
            * {
        box-sizing: border-box;
      }
      html,
      body {
        font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
        margin: 0;
      }
      a{
      text-decoration:none;
      color:black;
      }
      #contentWrap {
        width: 1000px;
        height: auto;
        display: flex;
      }
      #listDiv {
        width: 300px;
        height: 600px;
        overflow-x: hidden;
        overflow-y: scroll;
        scrollbar-width: none;
        background-color:rgb(58, 163, 117); 
      }
      #listDiv::-webkit-scrollbar {
        display: none;
      }
      #chatDiv {
        width: 700px;
        height: 600px;
        background-color: white;
      }
      /*팝업 메세지창 큰거*/
      #messageDiv {
        width: 700px;
        height: 550px;
        overflow-x: hidden;
        overflow-y: scroll;
        scrollbar-width: none;
        background-color: white;
        padding: 5px 10px;
      }
      #messageDiv::-webkit-scrollbar {
        display: none;
      }
      .opponentList {
        width: 100%;
        height: 60px;
		background-color: rgb(58, 163, 117);
        font-size: 18px;
        color: white;
        padding:5px;
        display:flex;
        justify-content:space-between;
      }
      /*리스트 호버링 색*/
      .opponentList:hover {
        background-color: rgb(88, 193, 147);
      }
    .opponentList1 {
        width: 100%;
        height: 30px;
		background-color:  rgb(58, 163, 117);
		padding-top:-3px;
        font-size: 18px;
        color: white;
        text-align:center;
        font-weight:bold;
        border: 3px solid rgb(58, 163, 117);
      }
      .opponentLeft{
      display:flex;
      width:auto;
      }
      .notRead{
      color:yellow;
      padding-top:8px;
      }
      .opponentName{
      	padding-top:9px;
      }
      #typingWrap {
        display: flex;
        width: 100%;
        height: 50px;
      }
      #submitDiv {
        width: 10%;
        height: 50px;
        display:flex;
      }
      /*타이핑*/
      #typingDiv {
        border: 5px solid rgb(58, 163, 117);
        width: 85%;
        height: 50px;
      }
      .inputMessage {
        width: 100%;
        height: 100%;
      }
      .inputMessage:focus {
        outline: none;
      }
      .apponentBox {
        display: flex;
        width: 100%;
        height: auto;
        padding: 5px;
        margin-top: 15px;
      }
      .myBox {
        display: flex;
        justify-content: flex-end;
        width: 100%;
        height: auto;
        padding: 5px;
        margin-top: 5px;
      }
      .mbox {
        text-align: right;
      }
      .apponentChat {
        width: auto;
        max-width: 400px;
        min-height: 40px;
        height: auto;
        border-radius: 4px;
        background-color: rgb(240,244,248);
        padding: 10px;
        word-break:break-all;
      }
      .myChat {
        width: auto;
        max-width: 400px;
        min-height: 40px;
        height: auto;
        border-radius: 4px;
        background-color: rgb(46, 148, 204);
        color:white;
        padding: 10px;
        text-align: left;
         word-break:break-all;
      }
      .name {
        color: black;
        margin-bottom: 5px;
      }
      .chatform {
        width: 100%;
        height: 50px;
        display: flex;
      }
      .submitButton {
        width: 100%;
        height: 50px;
        color: white;
        font-weight: 800;
        font-size:20px;
        background:rgb(58, 163, 117);
        border: 5px solid rgb(58, 163, 117);
      }
      .imageWrapOp{
      	padding:10px;
      	padding-left:0;
      }
      .imageWrapMy{
      	padding:10px;
      	padding-right:0;
      }
      .circleImage{
      	width:52px;
      	height:52px;
      	border-radius:50%;
      }
      .smallCircleImage{
      	width:46px;
      	height:46px;
      	border-radius:50%;
      	margin-right:10px;
      }
      #menuDiv {
        background: rgb(58, 163, 117);
        width: 5%;
        height: 50px;
        background-image: url("resources/img/menu3.svg");
        background-size: 30px;
        background-position: right;
        background-repeat: no-repeat;
        border-left: 1px solid rgb(240,244,248);
        cursor: pointer;
      }
      #menuContent {
        position: fixed;
        top: 455px;
        left: 300px;
        width: 150px;
        height: 100px;
        padding: 5px;
        padding-left: 3px;
        background-color: rgb(58, 163, 117);
        border-radius: 4px 4px 0 0;
        border-left: 1px solid rgb(240,244,248);
        
      }
      .menuContents {
        width: 250;
        height: 40px;
        background-color: rgb(58, 163, 117);
        color: white;
        font-weight: 600;
        padding: 8px 0;
        text-align: center;
        font-size: 18px;
        cursor: pointer;
      }
      .menuContents:hover {
        background-color: rgb(78, 183, 137);
      }
      
      .matchMessageDiv {
        text-align: center;
        width: 300px;
        font-size: 18px;
        font-weight: 600;
        padding-left: 15px;
        padding-top: 10px;
        color:white;
      }
      .matchButtonDiv {
        display: flex;
        justify-content: space-evenly;
        width: 320px;
        height: 80px;
        padding: 20px;
      }
      .matchDivButton {
        height: 50px;
        width: 80px;
        background-color: rgb(46, 148, 204);
        border: none;
        color: white;
        border-radius: 4px;
        font-weight: 800;
        cursor:pointer;
        font-size:18px;
      }
      .matchDivButton:hover{
      	background-color:rgb(66,168,224);
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
   		window.onload=function(){//하지 않으면 메뉴가 처음에 두번 클릭해야 나옴.
   			document.getElementById("menuContent").style.display="none";
   		}
   		var recentNum=<%=currentMsg%>
        function loop() {//새로운 메시지가 있을때 클라이언트의 화면을 새로고침 시켜준다.
          var xhttp = new XMLHttpRequest();
          xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
              var data = JSON.parse(this.responseText);
              console.log(data);
              if(recentNum!=data.recentNum){
              	window.location.reload();
              }
            }
          };
          xhttp.open("GET", "messageToJson.jsp?userNum=<%=userNum%>&opponentNum=<%=opponentNum%>", true);
          xhttp.send();
        }
        setInterval(loop, 1000);//loop함수를 1초마다 반복.
    	function selectOpponent(num){//상대를 선택했을때 실행되는 함수
    		document.opponentForm.opponentNum.value=num;
    		document.opponentForm.submit();
    	}
    	function showMenus(){//메뉴를 클릭시 껐다 킬수 있다
    		menu=document.getElementById("menuContent");
    		if(menu.style.display=="none"){
    			menu.style.display="block";
    		}else{
    			menu.style.display="none";
    		}
    	}
    </script>
  </head>
  <body>
    <div id="contentWrap">
      <div id="listDiv">
      <div class="opponentList1">
      	과외 커넥터 채팅 리스트
	</div>
        <form method="get" name="opponentForm" action="chatting.jsp">
        	<input type="hidden" name="userNum" value="<%=userNum%>">
        	<input type="hidden" name="opponentNum" value="">
        	<%if(oList.size()==0){ %>
        	채팅 상대가 없습니다.
        	<%} %>
	        <%for(int i=0; i<oList.size(); i++){ //상대 리스트 불러옴
	        		int oNum=oList.get(i);
	        		UserBean obean=umgr.getUser(oNum);
	        		String oName=obean.getUserName();
	        		String oImg="";
	        		if(tmgr.getImage(oNum)!=null){
	        			oImg=tmgr.getImage(oNum);
	        		}
	        		int notRead=mmgr.countNotRead(userNum, oNum);//상대가 나에게 보낸 메시지중 읽지 않은 개수를 불러오는 메서드.
	        %>
	        
	        <a href="javascript:selectOpponent(<%=oNum%>)">
		        <div class="opponentList" <%if(opponentNum==oNum){%>style="background-color:rgb(88, 193, 147)"<%} %>>
		        	<div class="opponentLeft">
			        	<%if(oImg.equals("")){ %><!-- 등록된 이미지가 없을때 -->
			        	<img src="resources/img/anonymous.jpg" class="smallCircleImage">
			        	<%}else{ %><!-- 있을때 -->
			        	<img src="resources/img/<%=oImg%>" class="smallCircleImage">
			        	<%} %>
			        	<div class="opponentName">
			        		<%=oName%>님과의 채팅
			        	</div>
		        	</div>
		        	<%if(notRead!=0){ %><!-- 읽지않은 메시지가 존재하지 않을때 숫자를 표시하지 않음. -->
		        	<div class="notRead"><%=notRead %></div>
		        	<%} %>
		        </div>
	        </a>
	        <%} %>
        </form>
      </div>
      <div id="chatDiv">
        <div id="messageDiv">
        <div id="menuContent">
        <!-- 매칭 처리등에 사용되는 잡다한 폼들 -->
        <form method="post" name="matchForm" action="matchingProc.jsp">
	      	<input type="hidden"  name="userNum" value="<%=userNum%>">
	      	<input type="hidden" name="opponentNum" value="<%=opponentNum%>">
	      	<input type="hidden" name="flags" value="match">
      	</form>
      	<form method="post" name="declineForm" action="matchingProc.jsp">
	      	<input type="hidden"  name="userNum" value="<%=userNum%>">
	      	<input type="hidden" name="opponentNum" value="<%=opponentNum%>">
	      	<input type="hidden" name="flags" value="decline">
      	</form>
      	<form method="post" name="cancleForm" action="matchingProc.jsp">
	      	<input type="hidden"  name="userNum" value="<%=userNum%>">
	      	<input type="hidden" name="opponentNum" value="<%=opponentNum%>">
	      	<input type="hidden" name="flags" value="cancle">
      	</form>
      	<form method="post" name="sendMatchForm" action="matchingProc.jsp">
	      	<input type="hidden"  name="userNum" value="<%=userNum%>">
	      	<input type="hidden" name="opponentNum" value="<%=opponentNum%>">
	      	<input type="hidden" name="ip" value="<%=ip%>">
	      	<input type="hidden" name="flags" value="sendMatch">
      	</form>
            <%if(match.isMatched(userNum, opponentNum)){ %><!-- 매칭이 이미 된 상대 -->
            <div class="menuContents" onClick="alert('이미 매칭이 되어있는 상대입니다!!')">
              매칭 신청하기
            </div>
            <%}else if(match.isDeclined(userNum, opponentNum)){ %><!-- 매칭이 거절된상대 -->
            <div class="menuContents" onClick="alert('매칭을 거절한 상대입니다.')">
              매칭 신청하기
            </div>
            <%}else{ %>
            <div class="menuContents" onClick="document.sendMatchForm.submit()">
              매칭 신청하기
            </div>
            <%} %>
            <div class="menuContents" onClick="document.cancleForm.submit()" style="border-top: 1px solid #cccccc;">
              팔로우 취소
            </div>
          </div>
          <%for(int i=0; i<mList.size(); i++){//채팅목록 불러오기
	        	  MessageBean bean=mList.get(i);
	        	  if(bean.getFromNum()==userNum){//보낸 메시지
	        	  %>
	        	  <div class="myBox" >
		            <div class="mbox">
		              <div class="name"><%=myInfo.getUserName()%></div>
		              <!-- 자신이 적은 메시지 -->
		              <div class="myChat" <%if(bean.getMessage().equals("Q&KJfRv09*CmjRKlPh1!")){ %>style="background-color: rgb(88, 193, 137)"<%} %>>
		                <%if(bean.getMessage().equals("Q&KJfRv09*CmjRKlPh1!")){ %><!-- 매칭 메시지는 특정값이 tblMessage에 들어왔을때 보임. -->
			                <%if(match.isMatched(userNum, opponentNum)){ %>
			                매칭이 완료되었습니다! 축하드립니다!
			                <%}else if(match.isDeclined(userNum, opponentNum)){ %>
			                매칭 신청이 거절되었습니다.
			                <%}else{ %>
			                매칭 메시지를 보냈습니다.
			                <%} %>
		                <%}else{ %>
		                <%=bean.getMessage() %>
		                <%} %>
		              </div>
		            </div>
		            <div class="imageWrapMy">
		            	<%if(myImg.equals("")){ %>
		            	<img src="resources/img/anonymous.jpg" class="circleImage">
		            	<%}else{ %>
		            	<img src="resources/img/<%=myImg%>" class="circleImage">
		            	<%} %>
		            </div>
		          </div> 
		          <!-- 상대가 적은 메시지 -->
	        	<%}else if(bean.getToNum()==userNum){ %>
	        	<div class="apponentBox">
	        		<div class="imageWrapOp">
		            	<%if(opponentImg.equals("")){%>
		            	<img src="resources/img/anonymous.jpg" class="circleImage">
		            	<%}else{ %>
		            	<img src="resources/img/<%=opponentImg%>" class="circleImage">
		            	<%} %>
		            </div>
		            <div class="abox">
		              <div class="name"><%=opponentInfo.getUserName()%></div>
		              <div class="apponentChat"<%if(bean.getMessage().equals("Q&KJfRv09*CmjRKlPh1!")){ %>style="color:white; background-color: rgb(88, 193, 137)"<%} %>>
		                <%if(bean.getMessage().equals("Q&KJfRv09*CmjRKlPh1!")){ %>
		                	<%if(match.isMatched(userNum, opponentNum)){ %>
			                매칭이 완료되었습니다! 축하드립니다!
			                <%}else if(match.isDeclined(opponentNum, userNum)){ %>
			                매칭 신청을 거절했습니다.
			                <%}else{ %>
			                <div class="matchMessageDiv">
			                  <%=opponentInfo.getUserName()%>님이 매칭을 신청했습니다!
			                </div>
			                <div class="matchButtonDiv"><!-- 상대가 보낸 매칭메시지의 경우 수락 거절 버튼이 표시된다. -->
			                  <input type="button" class="matchDivButton" value="수락" onClick="document.matchForm.submit()" />
			                  <input type="button" class="matchDivButton" value="거절" onClick="document.declineForm.submit()" />
			                </div>
			                <%} %>
		                <%}else{ %>
		                <%=bean.getMessage() %>
		                <%} %>
		              </div>
		            </div>
		          </div> 
          		<%}//else if(받은 메시지) %>
          <%}//for %> 
        </div>
        <%if(opponentNum!=0){ %>
        <div id="typingWrap">
          <form method="get" class="chatform" id="chatform" action="chattingProc.jsp">
          <input type="hidden" name="userNum" value="<%=userNum%>">
          <input type="hidden" name="opponentNum" value="<%=opponentNum%>">
          <input type="hidden" name="ip" value="<%=ip%>">
          <a href="javascript:showMenus()" id="menuDiv"></a>
            <div id="typingDiv">
              <input type="text" class="inputMessage" id="im" name="message" value="" placeholder="메시지를 입력해주세요" autocomplete="off"/>
            </div>
            <div id="submitDiv">
              <input type="button" class="submitButton" value="전송" onClick="chatform.submit()" />
            </div>
          </form>
        </div>
        <%} %>
      </div>
    </div>
    <script>
      var objDiv = document.getElementById("messageDiv");
      objDiv.scrollTop = objDiv.scrollHeight;
      $(document).ready(function() {
    	    $('#chatform').submit(function() {
    	        if ($('#im').val() == '') {
    	            alert('보낼 메시지를 입력해주세요!');
    	            return false;
    	        }//아무것도 입력하지 않고 엔터를 누르면 alert가 발동.
    	    }); // end submit()
    	}); // end ready()
    	
/*       setTimeout("location.reload()", 60000); */
    </script>
  </body>
</html>
