<%@page import="bean.StudentBean"%>
<%@page import="bean.TeacherBean"%>
<%@page import="java.util.Vector"%>
<%@page import="bean.UserBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
<jsp:useBean id="tmgr" class="mgr.TeacherMgr"/>
<jsp:useBean id="smgr" class="mgr.StudentMgr"/>
<jsp:useBean id="mmgr" class="mgr.MatchMgr"/>
<jsp:useBean id="rmgr" class="mgr.ReviewMgr"/>
<%
request.setCharacterEncoding("UTF-8");
		int userNum=0;
		int currentMsg=0; 
		UserBean bean=new UserBean();
		if(session.getAttribute("userNum")!=null){
			userNum=(Integer)session.getAttribute("userNum");
			bean=mgr.getUser(userNum);
			currentMsg=bean.getUserLastMessage();
		}

		int totalRecord1=0;
		int totalPage1=0;
		int nowPage1=1;
		int nowBlock1=1;
		totalRecord1=mmgr.mtTotalCount(userNum);
		if(request.getParameter("nowPage1")!=null){
			nowPage1=Integer.parseInt(request.getParameter("nowPage1"));
		}
		totalPage1=(int)Math.ceil((double)totalRecord1/10);
		if(totalPage1>10){
			totalPage1=10;
		}
		int totalRecord2=0;
		int totalPage2=0;
		int nowPage2=1;
		int nowBlock2=1;
		totalRecord2=mmgr.msTotalCount(userNum);
		if(request.getParameter("nowPage2")!=null){
			nowPage2=Integer.parseInt(request.getParameter("nowPage2"));
		}
		totalPage2=(int)Math.ceil((double)totalRecord2/10);
		if(totalPage2>10){
			totalPage2=10;
		}
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="resources/js/includeHTML.js"></script>
    <style>
      * {
        box-sizing: border-box;
      }
      html,
      body {
        margin: 0;
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
      #myPageMenu2 {
        width: 180px;
        height: 600px;
      }
      #myPageContents {
        width: 920px;
        height: auto;
        border-left: 1px solid gray;
        padding: 10px 50px 0px 50px;
      }
      .list {
        border-spacing: 0;
        width: 100%;
        border-collapse: collapse;
      }
      .tableTop {
        border-top: 2px solid black;
        border-bottom: 1px solid black;
        background-color: rgb(224, 224, 224);
        height: 30px;
        font-size: 17px;
      }
      .tableContent {
        height: 60px;
        border-bottom: 1px solid #666666;
        font-size: 14px;
        font-weight: 400;
        color: #666666;
      }
      th {
        font-weight: 400;
      }
      .tableButton {
        background-color: rgb(88, 193, 137);
        border: none;
        margin-bottom: 2px;
        color: white;
        width: 60%;
        border-radius: 2px;
        font-weight: 800;
        cursor: pointer;
        height: 22px;
      }
      .ellipsis {
        padding: 0 5%;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
        text-align: center;
        max-width: 215px;
      }
      .teacherName {
        color: #666666;
        font-weight: 400;
        font-size: 14px;
      }
      .teacherName:hover {
        text-decoration: underline;
      }
      .page a {
        color: black;
      }

      table.page1 {
        width: 100%;
        margin-top:10px;
      }

      a .up {
        color: darkgrey;
      }
      a .page .next {
        background-color: rgb(88, 193, 137);
        border: 1px solid rgb(88, 193, 137);
        color: white;
        border-radius: 5px;
        font-weight: bold;
        font-size: 15px;
        margin: 0px 3px;
      }

      .page .next {
        background-color: rgb(88, 193, 137);
        border: 1px solid rgb(88, 193, 137);
        color: white;
        border-radius: 5px;
        font-weight: bold;
        font-size: 15px;
        margin: 0px 3px;
      }
      .titlediv {
        font-size: 24px;
        font-weight: 400;
        color: rgb(88, 193, 137);
        text-align: left;
        margin-top: 20px; 
        margin-bottom: 10px;
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
    if(<%=userNum%>==0){
  	  alert("허용되지 않은 접근입니다.")
  	  location.href="main.jsp";
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
	function pageing1(page){
		document.pageForm.nowPage1.value=page;
		document.pageForm.submit();
	}
	function pageing2(page){
		document.pageForm.nowPage2.value=page;
		document.pageForm.submit();
	}
	function openReview(userNum, toNum){
		url="writeReview.jsp?userNum="+userNum+"&toNum="+toNum;
		window.open(url, "update", "width=800, height=201, left=520, top=350, scrollbars=no, location=no, toobar=no, menubar=no");
	}
	function deleteMatch(userNum, toNum){
		var flag=confirm("정말 찜목록에서 삭제하시겠습니까?");
		if(flag){
			document.deleteForm.fromNum.value=userNum;
    		document.deleteForm.toNum.value=toNum;
    		document.deleteForm.submit();
		}else{
			
		}
	}
    </script>
  </head>
  <body>
    <header include-html="header.jsp"></header>
    <div id="contentWrap">
    <form method="post" name="deleteForm" action="MatchDelete">
	    <input type="hidden" name="fromNum" value=""/>
	    <input type="hidden" name="toNum" value=""/>
    </form>
    <form method="get" name="pageForm">
    	<input type="hidden" name="nowPage1" value="<%=nowPage1 %>" action="commentList.jsp">
    	<input type="hidden" name="nowPage2" value="<%=nowPage2 %>" action="commentList.jsp">
    </form>
      <div id="myPageTitle">마이페이지</div>
      <div id="myPageMenu1">
        <div class="menus">
          <a href="" style="color: rgb(88, 193, 137);">나의 활동</a>
        </div>
        <div class="menus"><a href="pwdCheck.jsp">회원정보</a></div>
      </div>
      <hr style="margin: 25px 0px 0px 0px" />
      <div id="myPageMids">
        <div id="myPageMenu2">
          <div class="menus2">
            <a href="" style="color: rgb(88, 193, 137);">찜 확인</a>
          </div>
          <div class="menus2"><a href="commentList.jsp">작성 댓글</a></div>
        </div>
        <div id="myPageContents">
          <div id="myPageContent">
            <div class="titlediv">찜한 선생님</div>
            <table class="list" width="100%">
              <tr class="tableTop" text-align="center">
                <th width="15%">사진</th>
                <th width="15%">이름</th>
                <th width="25%">과목</th>
                <th width="25%">지역</th>
                <th width="10%">상태</th>
                <th width="10%"></th>
              </tr>
              <%Vector<Integer> mtlist=mmgr.getMatchedTeacher(userNum);
              		int listSize1=mtlist.size();
              		int nowList1=-1+((nowPage1-1)*10);
              		if(mtlist.isEmpty()){
              %>
              <tr class="tableContent">
                <td colspan="6">
                  찜한 선생님이 없습니다.
                </td>
              </tr>
              <%}else{ %>
              		<%for(int i=0; i<10;i++){
              			nowList1++;
              			 if(nowList1==listSize1) break;
              			 int teacherNum=mtlist.get(nowList1);
              			 TeacherBean teacherInfo=tmgr.getTeacherInfo(teacherNum);
              			 UserBean userInfo=mgr.getUser(teacherNum);
              			 String tImage=tmgr.getImage(teacherNum);
              			 String userName=userInfo.getUserName();
              			 String subject=teacherInfo.gettSubject1();
              			 if(teacherInfo.gettSubject2()!=null){
              				 subject+=", "+teacherInfo.gettSubject2();
              			 }
              			 if(teacherInfo.gettSubject3()!=null){
              				subject+=", "+teacherInfo.gettSubject3();
              			 }
              			 String area=teacherInfo.gettArea1();
              			 if(teacherInfo.gettArea2()!=null){
              				 area+=", "+teacherInfo.gettArea2();
              			 }
              			 if(teacherInfo.gettArea3()!=null){
              				 area+=", "+teacherInfo.gettArea3();
              			 }
              			 String status="찜";
              			 if(mmgr.isMatched(userNum, teacherNum)){
              				 status="매칭";
              			 }
              		%>
	              <tr class="tableContent">
	                <td>
	                <a href="Tpage.jsp?userNum=<%=userNum%>&teacherNum=<%=teacherNum%>">	                
	                  <img
	                    style="border-radius: 100px;"
	                    class="profile1"
	                    src="resources/img/<%=tImage %>"
	                    width="40"
	                    height="40"
	                  />
	                  </a>
	                </td>
	
	                <td><a class="teacherName" href="Tpage.jsp?userNum=<%=userNum%>&teacherNum=<%=teacherNum%>"><%=userName %></a></td>
	                <td>
	                  <div class="ellipsis">
	                    <%=subject %>
	                  </div>
	                </td>
	                <td><%=area %></td>
	                <td><%=status %></td>
	                <td>
	                  <%if(mmgr.isMatched(userNum, teacherNum)){ %>
	                  <%if(rmgr.hasReview(userNum, teacherNum)){ %>
	                  <input class="tableButton" type="button" value="리뷰작성" style="font-size: 10px;" onClick="alert('이미 작성한 리뷰가 존재합니다.')"/>
	                  <%}else{ %>
	                  <input class="tableButton" type="button" value="리뷰작성" style="font-size: 10px;" onClick="openReview(<%=userNum%>, <%=teacherNum%>)"/>
	                  <%} %>
	                  <br />
	                  <%}%>
	                  <input class="tableButton" type="button" value="삭제" onClick="deleteMatch(<%=userNum%>, <%=teacherNum%>)" />
	                </td>
	              </tr>
              		<%} %>
              <%} %>
              <table class="page1" align="center">
            	<tr>
            		<td class="page" align="center" width="100%">
            		<%for(int i=1; i<=totalPage1;i++){ %>
            		<a class="up" href="javascript:pageing1('<%=i%>')">
            		<%if(nowPage1==i){ %><font color="#00CC66"><%} %>
            		<%=i %>
            		<%if(nowPage1==i){ %></font><%} %>
            		</a>
            		<%} %>
            		</td>
            	</tr>
            </table>
            </table>
            <div class="titlediv">찜한 학생</div>
            <table class="list" width="100%">
              <tr class="tableTop" text-align="center">
                <th width="15%">사진</th>
                <th width="15%">이름</th>
                <th width="25%">과목</th>
                <th width="25%">지역</th>
                <th width="10%">상태</th>
                <th width="10%"></th>
              </tr>
              <%Vector<Integer> mslist=mmgr.getMatchedStudent(userNum);
              		int listSize2=mslist.size();
              		int nowList2=-1+((nowPage2-1)*10);
              		if(mslist.isEmpty()){
              %>
              <tr class="tableContent">
                <td colspan="6">
                  찜한 학생이 없습니다.
                </td>
              </tr>
              <%}else{ %>
              		<%for(int i=0; i<10;i++){
              			nowList2++;
              			 if(nowList2==listSize2) break;
              			 int studentNum=mslist.get(nowList2);
              			 StudentBean studentInfo=smgr.getStudentInfo(studentNum);
              			 UserBean userInfo=mgr.getUser(studentNum);
              			 String tImage=tmgr.getImage(studentNum);
              			 String userName=userInfo.getUserName();
              			 String subject=studentInfo.getsSubject1();
              			 if(studentInfo.getsSubject2()!=null){
              				 subject+=", "+studentInfo.getsSubject2();
              			 }
              			 if(studentInfo.getsSubject3()!=null){
              				subject+=", "+studentInfo.getsSubject3();
              			 }
              			 String area=studentInfo.getsArea1();
              			 if(studentInfo.getsArea2()!=null){
              				 area+=", "+studentInfo.getsArea2();
              			 }
              			 if(studentInfo.getsArea3()!=null){
              				 area+=", "+studentInfo.getsArea3();
              			 }
              			 String status="찜";
              			 if(mmgr.isMatched(userNum, studentNum)){
              				 status="매칭";
              			 }
              		%>
	              <tr class="tableContent">         
	                <td>
	                <a href="Spage.jsp?userNum=<%=userNum%>&studentNum=<%=studentNum%>">
	                  <img
	                    style="border-radius: 100px;"
	                    class="profile1"
	                    <%if(tImage!=null){ %>
	                    src="resources/img/<%=tImage %>"
	                    <%}else{ %>
	                    src="resources/img/anonymous.jpg
	                    "
	                    <%} %>
	                    width="40"
	                    height="40"
	                  />
	                  </a>
	                </td>
	
	                <td><a class="teacherName" href="Spage.jsp?userNum=<%=userNum%>&studentNum=<%=studentNum%>">
	                <%=userName %></a></td>
	                <td>
	                  <div class="ellipsis">
	                    <%=subject %>
	                  </div>
	                </td>
	                <td><%=area %></td>
	                <td><%=status %></td>
	                <td>
	                  <input class="tableButton" type="button" value="삭제" onClick="deleteMatch(<%=userNum%>, <%=studentNum%>)"/>
	                </td>
	              </tr>
              		<%} %>
              <%} %>
              <table class="page1" align="center">
            	<tr>
            		<td class="page" align="center" width="100%">
            		<%for(int i=1; i<=totalPage2;i++){ %>
            		<a class="up" href="javascript:pageing2('<%=i%>')">
            		<%if(nowPage2==i){ %><font color="#00CC66"><%} %>
            		<%=i %>
            		<%if(nowPage2==i){ %></font><%} %>
            		</a>
            		<%} %>
            		</td>
            	</tr>
            </table>
            </table>
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
