<%@page import="java.util.Vector"%>
<%@page import="bean.TeacherBean"%>
<%@page import="bean.UserBean"%>
<%@page import="bean.ReviewBean"%>
<%@page import="bean.StudentBean"%>
<%@page import="mgr.UtilMgr"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="tsMgr" class="mgr.TsearchMgr"/>
<jsp:useBean id="sMgr" class="mgr.StudentMgr"/>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
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
	
	if(userNum==0){
	%>
	<script>
	alert("로그인이 필요한 페이지 입니다.");
	location.href="login.jsp";
	</script>
	<%
	}
	
	int studentNum=0;
	if(request.getParameter("studentNum")!=null){
		studentNum=Integer.parseInt(request.getParameter("studentNum"));
	}
%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="resources/js/includeHTML.js"></script>
    <script type="text/javascript" src="resources/js/jquery-3.5.0.min.js"></script>
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
        margin-top: 70px;
      }
    .search{/*바깥 큰 테두리*/
		background-color: #eeeeee;
		margin:0px 5%;
		border-radius: 5px;
	}     
	 /*현승씨 코드*/
       .review {
        border-radius: 6px;
        padding: 20px;        
      }
      .reviews {
        height: 100%;
        background-color:white;
        border-radius: 6px;
        padding:20px;
        padding-left:50px;
      }
      .reviewImg {
        width: 200px;
        height: 200px;
        border-radius: 5px;
        margin: 0 25px;
      }
      .reviewDescWrap {
        width: 170px;
        height: 170px;
        padding: 20px 0;
        padding-right: 20px;
      }
      .reviewDesc {
      	width:100%;
        height: 100%;
      }
      .rdTitle {
        width: 170px;
        font-size: 20px;
        font-weight: 800;
        padding-top: 3px;
        color:white;
      }
      .rdContent {
        width: 170px;
        font-size: 14px;
        font-weight: 400;
        word-break: break-all;
        color:white;
        
      }.content {
        padding: 0px 10px;
        font-size: 16px;
        width : 50%;
        display: flex;
      }
      /*메뉴*/
      .s2i_name {
        margin:5px;
        margin-left:0px;
        font-size: 15px;
        padding:6px;
      }
      .profile {
        display: flex;
      }
	/*리스트*/
      .s2i_desc {
        width:130px;
        text-align:center;        
      	padding:6px;
      	margin: 5px;
      	margin-right:4px;
        font-size: 15px;
        background-color: rgb(88, 193, 137);
        color:white;
        border-radius: 5px;
        font-weight: bold;
        }
      .pretag{
      	width:800px;
      	white-space: pre-wrap; /* CSS3*/
		white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
		white-space: -pre-wrap; /* Opera 4-6 */
		white-space: -o-pre-wrap; /* Opera 7 */
		word-wrap: break-all; /* Internet Explorer 5.5+ */ 
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
    </script>
  </head>
  <body>
    <header include-html="header.jsp"></header>

    	<div id="contentWrap">
    		<h2>학생 상세 페이지</h2>
    		<div id='searchv' class="search">
    			<%
    				StudentBean sbean = sMgr.Spage(studentNum);
    				TeacherBean tbean = tsMgr.Tpage(studentNum);
    				UserBean ubean = sMgr.Sinfopage(studentNum);
    				
    				//학력 변경
    				int record = sbean.getsRecord();
    				String srecord = "";
    				if(record==1){srecord += "초등학교";}
    				else if(record==2){srecord += "중학교";}
    				else if(record==3){srecord += "고등학교";}
    				else if(record==4){srecord += "대학교";}
    				
    				//학년
    				int grade = sbean.getsYear();
    				String sgrade = "";
    				if(grade==0){sgrade += "졸업";}
    				else if(grade==1){sgrade += "1학년";}
    				else if(grade==2){sgrade += "2학년";}
    				else if(grade==3){sgrade += "3학년";}
    				else if(grade==4){sgrade += "4학년";}
    				else if(grade==5){sgrade += "5학년";}
    				else if(grade==6){sgrade += "6학년";}
    				
    				
    				
    				//성별 변경
    				String gender = ubean.getUserGender();
    				String sgender = "";
    				if(gender.equals("1")){sgender="남자";}
    				else if(gender.equals("2")){sgender="여자";}
    				
    				//생년월일 계산
    				String birth = ubean.getUserBirth();
					int year = Integer.parseInt(birth.substring(0,4));
					//올해 빼기 - year
					
					SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy");
					Date time = new Date();
					int thisyear = Integer.parseInt(format1.format(time));
    				
					year = thisyear-year;
					//생년월일 계산끝
					
					int fee = sbean.getsFee();
					String money;
					if(fee==0){
						money="협의";
					}else{
						money=fee+"만원 이하";
					}
					
					//선생님 프로필 사진
					String tImage = tbean.gettImage();
					
					
					if(sbean.getsOpen()==0){
						%>
						<script>
						alert("비공개 회원 입니다.");
						location.href = history.back();
						</script>
					<%
					}else if(sbean.getsOpen()==1){
						%>
    			<div class="review">
		            <div class="reviews" style="display: flex;justify-content:center;">
						<div class="reviewImg">
						<!-- 선생님 등록이 되어있으면 등록된 선생님 이미지, 없으면 기본 이미지 -->
		                	<%if(tImage == null) {%>
								<img src="resources/img/anonymous.jpg" style="border-radius: 5px;" width="100%" height="100%">
								<%}else {%>
								<img src="resources/img/<%=tImage%>" style="border-radius: 5px;" width="100%" height="100%">
							<%}%>
						</div>

		                <div class="reviewDesc">
				              <div class="s2i_content">
				              		<div class="profile">
					              		<div class="content">
						              			<div class="s2i_desc">이름</div>
						                		<div class="s2i_name"><%=ubean.getUserName() %></div>
				                		</div>
				                		<div class="content">
						                		<div class="s2i_desc" >닉네임</div>
						                		<div class="s2i_name"><%=sbean.getsNickname() %></div>
				                		</div>
									</div>
				            <!-- 학교, 전공 -->
				                <div class="profile">
						              <div class="content">
						                	<div class="s2i_desc">나이 / 성별</div>
						                	<div class="s2i_name"><%= year +"세 / "+sgender%></div>
					                	</div>
						                <div class="content">
							                  <div class="s2i_desc" >횟수 / 시간</div>					                  
							                  <div class="s2i_name"><%=sbean.getsDay()+" / "+ sbean.getsTime()%></div>
					               		</div>
				                </div>
				             <!-- 학년 -->
				                <div class="profile">
						              <div class="content">				                	
						                  <div class="s2i_desc">학년</div>
						                  <div class="s2i_name"><%=srecord%> <%=sgrade%></div>
					                  </div>					              
				                	<div class="content">				                				                
						                  <div class="s2i_desc">희망 과외 비용</div>					                  
						                  <div class="s2i_name"><%=money%></div>
				               		</div>
				                </div>
				                
				             <!-- 희망 과목 -->
				                <div class="content" style="width:100%;">
					                  <div class="s2i_desc">수업 가능 과목</div>
					                  <div class="s2i_name">
					                  <%=sbean.getsSubject1()%>
					                  <%if(sbean.getsSubject2()!=null){ %>
					                  <%=", "+sbean.getsSubject2()%>
					                  <%} %>
					                  <%if(sbean.getsSubject3()!=null){ %>
					                  <%=", "+sbean.getsSubject3() %>
					                  <%} %></div>      
				                </div>
				                
				             <!-- 희망 지역 -->
				                <div class="content" style="width:100%;">
				                  <div class="s2i_desc">희망 지역</div>
				                  <div class="s2i_name"><%=sbean.getsArea1()%>
				                  <%if(sbean.getsArea2()!=null){ %>
					                  <%=", "+sbean.getsArea2()%>
					                  <%} %>
					                  <%if(sbean.getsArea3()!=null){ %>
					                  <%=", "+sbean.getsArea3() %>
					                  <%} %></div>
				                </div>
				              
				              </div>
				              <!-- s2i_content 끝 -->
		                </div>
		                <!-- reviewDesc 끝-->
		                
		            </div>
			            
   		          </div><!-- reviews 끝 -->
				<%} %><!-- else -->
    		</div><!-- search -->
    		</br>
				
		<div class="content" style="justify-content: flex-end;width: 100%;">
				<%if(userNum!=studentNum){ %>
					<%if(userNum==0){ %>
					<div class="s2i_desc"><a href="login.jsp">1:1 채팅하기</a></div>
					<div class="s2i_desc" onclick=""><a href="login.jsp">찜하기</a></div>
					<%}else{ %>
					<div class="s2i_desc"><a href="SpageProc.jsp?userNum=<%=userNum%>&studentNum=<%=studentNum%>&flag=chat">1:1 채팅하기</a></div>
					<div class="s2i_desc" onclick=""><a href="SpageProc.jsp?userNum=<%=userNum%>&studentNum=<%=studentNum%>&flag=not">찜하기</a></div>
					<%} %>
				<%} %>
				<div class="s2i_desc" ><a href="javascript:history.back()">뒤로</a></div>
		</div>
		<br>
		
    	</div>
	<div include-html="footer.jsp"></div>
    <footer include-html="footer1.jsp"></footer>
    <script>
      includeHTML();
      
      function alreadyStudent(){
    		alert("이미 학생으로 등록되어 있습니다!");
    	}
    	function alreadyTeacher(){
    		alert("이미 선생님으로 등록되어 있습니다!");
    	}
    </script>
  </body>
</html>

