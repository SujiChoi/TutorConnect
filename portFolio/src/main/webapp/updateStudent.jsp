<%@page import="bean.StudentBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="bean.UserBean"%>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
<jsp:useBean id="imgr" class="mgr.InfoMgr"/>
<jsp:useBean id="smgr" class="mgr.StudentMgr"/>
<%
		request.setCharacterEncoding("UTF-8");
		int userNum=0;
		int currentMsg=0; 
		UserBean bean=new UserBean();
		boolean isStudentFlag=true;//학생등록이 되어있지 않은사람 구분을 위해 만듬.
		StudentBean sbean=new StudentBean();
		
		String major1=null, major2=null, major3=null;
		String area1=null, area2=null, area3=null;
		String street1=null, street2=null, street3=null;
		if(session.getAttribute("userNum")!=null){
			userNum=(Integer)session.getAttribute("userNum");
			bean=mgr.getUser(userNum);
			currentMsg=bean.getUserLastMessage();
			if(smgr.isStudent(userNum)){
				sbean=smgr.getStudentInfo(userNum);
				isStudentFlag=false;
				major1=imgr.searchMajor(sbean.getsSubject1());
				area1=sbean.getsArea1().substring(0,2);
				street1=sbean.getsArea1().substring(2);
				if(sbean.getsSubject2()!=null){//subject 2,3, area 2,3이 null값이 아닐때의 처리
					major2=imgr.searchMajor(sbean.getsSubject2());
				}
				if(sbean.getsSubject3()!=null){
					major3=imgr.searchMajor(sbean.getsSubject3());
				}
				if(sbean.getsArea2()!=null){
					area2=sbean.getsArea2().substring(0,2);
					street2=sbean.getsArea2().substring(2);
				}
				if(sbean.getsArea3()!=null){
					area3=sbean.getsArea3().substring(0,2);
					street3=sbean.getsArea3().substring(2);
				}
			}
		}
		Vector<String> mathMinors=imgr.searchMath();
		Vector<String> englishMinors=imgr.searchEnglish();
		Vector<String> koreanMinors=imgr.searchKorean();
		Vector<String> scienceMinors=imgr.searchScience();
		Vector<String> societyMinors=imgr.searchSociety();
		Vector<String> gforeignMinors=imgr.searchgForeign();
		Vector<String> jforeignMinors=imgr.searchjForeign();
		Vector<String> itMinors=imgr.searchIT();
		Vector<String> seSt=imgr.searchByCity("서울");
		Vector<String> bsSt=imgr.searchByCity("부산");
		Vector<String> dgSt=imgr.searchByCity("대구");
		Vector<String> icSt=imgr.searchByCity("인천");
		Vector<String> kjSt=imgr.searchByCity("광주");
		Vector<String> djSt=imgr.searchByCity("대전");
		Vector<String> usSt=imgr.searchByCity("울산");
		Vector<String> sjSt=imgr.searchByCity("세종");
		Vector<String> kkSt=imgr.searchByCity("경기");
		Vector<String> kwSt=imgr.searchByCity("강원");
		Vector<String> cbSt=imgr.searchByCity("충북");
		Vector<String> cnSt=imgr.searchByCity("충남");
		Vector<String> jbSt=imgr.searchByCity("전북");
		Vector<String> jnSt=imgr.searchByCity("전남");
		Vector<String> kbSt=imgr.searchByCity("경북");
		Vector<String> knSt=imgr.searchByCity("경남");
		Vector<String> jjSt=imgr.searchByCity("제주");
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
        width: 200px;
        margin-top: 10px;
      }
      .menus2 > a {
        font-size: 30px;
        font-weight: 800;
        color: black;
      }
      .menus2sub {
        width: 200px;
        padding-left: 80px;
      }
      .menus2sub > a {
        font-size: 18px;
        font-weight: 500;
        color: black;
      }
      #myPageMenu2 {
        width: 250px;
        height: 600px;
      }
      #myPageContents {
        width: 900px;
        height: auto;
        border-left: 1px solid gray;
        padding: 10px 50px 0px 0px;
      }
      .joinFlex {
        display: flex;
        margin-bottom: 30px;
        padding-left:7vw;
      }
      .inputDesc {
        width: 140px;
        padding-top: 10px;
        color: #666666;
        font-weight: 800;
      }
      .inputBox {
        width: 400px;
        height: 50px;
        border: 1px solid #666666;
        border-radius: 6px;
        padding: 5px;
      }
      .input {
        width: 100%;
        height: 100%;
        border: none;
        font-size: 18px;
      }
      .input:focus {
        outline: none;
      }
      #JF_address {
        display: flex;
        padding-left: 14vw;
        padding-right: 5vw;
        height: 150px;
        margin-bottom: 30px;
      }
      #JFA_desc {
        width: 140px;
        padding-top: 65px;
        color: #666666;
        font-weight: 800;
      }
      #JFA_buttondiv {
        padding: 30px;
        width: 150px;
        height: 150px;
      }
      .addressButton {
        cursor: pointer;
        background-color: rgb(88, 193, 137);
        width: 90px;
        height: 90px;
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: 800;
      }
      .zipcodeBox {
        width: 200px;
        height: 30px;
        border: 1px solid #666666;
        border-radius: 6px;
        margin-bottom: 10px;
      }
      .zipcodeInput {
        width: 100%;
        height: 1em;
        border: none;
        font-size: 14px;
      }
      .gender{
        width: 100px;
      }
      #iradio{
       margin: 15px;
       margin-top: 30px;
      }
      .MemberButton {
        cursor: pointer;
        font-size: 20px;
        background-color: rgb(88, 193, 137);
        width: 230px;
        height: 72px;
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: 800;
      }
      .bigSelect{
        height: 50px;
        width: 400px;
        border-radius: 6px;
        border: 1px solid #666666;
      }
      .bigSelect:focus{
      	outline:none;
      }
      .smallSelect{
        display: flex;
        width:195px;
        height: 50px;
        border: 1px solid #666666;
        border-radius: 6px;
        padding-left: 10px;
        margin-right:10px;
      }
      #hjf1{
      	display:none;
        margin-bottom: 30px;
        padding-left:7vw;
      }
      #hjf2{
        margin-bottom: 30px;
        display:none;
        padding-left:7vw;
      }
      #hjf3{
        display: none;
        margin-bottom: 30px;
        padding-left:7vw;
      }
      #hjf4{
        display: none;
        margin-bottom: 30px;
        padding-left:7vw;
      }
      .plusButton{
        background-color: rgb(88, 193, 137);
        border-radius: 50%;
        width:50px;
        height:50px;
        border:none;
        color:white;
        font-size: 25px;
        font-weight: 800;
        cursor:pointer;
        padding-top:5px;
        padding-left:2px;
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
      function openUpdate() {
        var menus2sub = document.getElementsByClassName("menus2sub");
        for (i = 0; i < menus2sub.length; i++) {
          if (menus2sub[i].style.display == "none") {
            menus2sub[i].style.display = "block";
          } else {
            menus2sub[i].style.display = "none";
          }
        }
      }
      function showSub2(){
	        var sub2=document.getElementById("hjf1");
	        sub2.style.display="flex";
	        var pb=document.getElementById("pb1");
	        pb.style.display="none";
	        
    }
  	function showSub3(){
      	var sub3=document.getElementById("hjf2");
          sub3.style.display="flex";
          var pb=document.getElementById("pb2");
	        pb.style.display="none";
    }
  	function showArea2(){
      	var area2=document.getElementById("hjf3");
          area2.style.display="flex";
          var pb=document.getElementById("pb3");
	        pb.style.display="none";
    }
  	function showArea3(){
      	var area3=document.getElementById("hjf4");
          area3.style.display="flex";
          var pb=document.getElementById("pb4");
	        pb.style.display="none";
    }
  	function inputCheck(){
  		form=document.studentFrm;
  		if(form.sNickname.value==""){
  			alert("닉네임을 입력해주세요!");
  			form.sNickname.focus();
  		}
  		else if(form.sRecord.value=="0"){
  			alert("학력을 입력해주세요!");
  		}
  		else if(form.sYear.value=="0"){
  			alert("학년을 입력해주세요!");
  		}
  		else if(form.sSubject1.value==""){
  			alert("배우고 싶은 과목을 하나 이상 선택해주세요!");
  		}
  		else if(form.sa11.value==""){
  			alert("지역을 하나 이상 입력해주세요!");
  		}
  		else{
  			var sa11=form.sa11.value;
      		var sa12=form.sa12.value;
      		form.sArea1.value=sa11+sa12;
      		var sa21=form.sa21.value;
      		var sa22=form.sa22.value;
      		form.sArea2.value=sa21+sa22;
      		var sa31=form.sa31.value;
      		var sa32=form.sa32.value;
      		form.sArea3.value=sa31+sa32;
      		form.submit();
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
    </script>
  </head>
  <body>
    <header include-html="header.jsp"></header>
    <div id="contentWrap">
      <div id="myPageTitle">마이페이지</div>
      <div id="myPageMenu1">
        <div class="menus">
          <a href="wishList.jsp">나의 활동</a>
        </div>
        <div class="menus">
          <a href="" style="color: rgb(88, 193, 137);">회원정보</a>
        </div>
      </div>
      <hr style="margin: 25px 0px 0px 0px" />
      <div id="myPageMids">
        <div id="myPageMenu2">
          <div class="menus2">
            <a href="javascript:openUpdate()" style="color: rgb(88, 193, 137);"
              >회원 정보 수정</a
            >
          </div>
          <div class="menus2sub">
            <a href="updateUser.jsp">기본정보</a>
          </div>
          <div class="menus2sub">
            <a href="" style="color: rgb(88, 193, 137);">학생정보</a>
          </div>
          <div class="menus2sub">
            <a href="updateTeacher.jsp">선생정보</a>
          </div>
          <div class="menus2"><a href="deleteUser.jsp">회원 탈퇴</a></div>
        </div>
        <div id="myPageContents">
		<%if(isStudentFlag){ %>
		학생 등록이 되어있지 않습니다.
		<%}else{ %>
		          <div id="myPageContent">
          
        <form method="post" name="studentFrm" action="updateStudentProc.jsp">
      	<input type="hidden" name="userNum" value="<%=userNum%>">
        <div class="joinFlex">
          <div class="inputDesc">닉네임</div>
          <div class="inputBox">
            <input type="text" name="sNickname" class="input" placeholder="10자 제한" maxlength="10" value="<%=sbean.getsNickname()%>"/>
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">학력</div>
            <select class="bigSelect" name="sRecord">
            <%
            	String record=null;
            	switch(sbean.getsRecord()){
		            case 1:
		            	record="초등학생";
		            	break;
		            case 2:
		            	record="중학생";
		            	break;
		            case 3:
		            	record="고등학생";
		            	break;
		            case 4:
		            	record="대학생";
		            	break;
		          }
            %>
              <option value="<%=sbean.getsRecord()%>" selected><%=record%>
              <option value="1">초등학생
              <option value="2">중학생
              <option value="3">고등학생
              <option value="4">대학생
          </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">학년</div>
            <select class="bigSelect" name="sYear">
              <%if(sbean.getsYear()==7){ %>
              <option value="<%=sbean.getsYear()%>" selected>졸업
              <%}else{ %>
              <option value="<%=sbean.getsYear()%>" selected><%=sbean.getsYear()%>학년
              <%} %>
              <option value="1">1학년
              <option value="2">2학년
              <option value="3">3학년
              <option value="4">4학년
              <option value="5">5학년
              <option value="6">6학년
              <option value="7">졸업
          </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">과목</div>
            <select class="smallSelect" name="ss1" onchange="subjectChange1()">
              <option value="<%=major1%>" selected><%=major1 %>
              <option value="국어">국어
              <option value="수학">수학
              <option value="영어">영어
              <option value="과학">과학
              <option value="사회">사회
              <option value="국가공인외국어">국가공인외국어
              <option value="제2외국어">제2외국어
              <option value="IT/컴퓨터">IT/컴퓨터
            </select>
            <select class="smallSelect" name="sSubject1"><!-- ss1설정에 따라서 변경된다. -->
              <option value="<%=sbean.getsSubject1()%>" selected><%=sbean.getsSubject1()%>
            </select>
             <a href="javascript:showSub2()" class="plusButton" id="pb1" >+</a>
        </div>
        <div id="hjf1">
          <div class="inputDesc">과목2</div>
            <select class="smallSelect" name="ss2" onchange="subjectChange2()">
              <%if(major2!=null){ %>
              <option value="<%=major2 %>" selected><%=major2 %>
              <%}else{ %>
              <option value="" selected>과목
              <%} %>
              <option value="국어">국어
              <option value="수학">수학
              <option value="영어">영어
              <option value="과학">과학
              <option value="사회">사회
              <option value="국가공인외국어">국가공인외국어
              <option value="제2외국어">제2외국어
              <option value="IT/컴퓨터">IT/컴퓨터
              <option value="제거">항목제거
            </select>
            <select class="smallSelect" name="sSubject2">
              <%if(sbean.getsSubject2()!=null){ %>
              <option value="<%=sbean.getsSubject2() %>" selected><%=sbean.getsSubject2() %>
              <%}else{ %>
              <option value="" selected>세부과목
              <%} %>
            </select>
            <a href="javascript:showSub3()" class="plusButton" id="pb2">+</a>
        </div>
        <div id="hjf2">
          <div class="inputDesc">과목3</div>
            <select class="smallSelect" name="ss3" onchange="subjectChange3()">
              <%if(major3!=null){ %>
              <option value="<%=major3 %>" selected><%=major3 %>
              <%}else{ %>
              <option value="" selected>과목
              <%} %>
              <option value="국어">국어
              <option value="수학">수학
              <option value="영어">영어
              <option value="과학">과학
              <option value="사회">사회
              <option value="국가공인외국어">국가공인외국어
              <option value="제2외국어">제2외국어
              <option value="IT/컴퓨터">IT/컴퓨터
              <option value="제거">항목제거
            </select>
            <select class="smallSelect" name="sSubject3">
              <%if(sbean.getsSubject3()!=null){ %>
              <option value="<%=sbean.getsSubject3() %>" selected><%=sbean.getsSubject3() %>
              <%}else{ %>
              <option value="" selected>세부과목
              <%} %>
            </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">희망 지역</div>
          <input type="hidden" name="sArea1" value="">
          <select class="smallSelect" name="sa11" onChange="areaChange1()">
              <option value="<%=area1%>" selected><%=area1 %>
              <option value="서울">서울
              <option value="부산">부산
              <option value="대구">대구
              <option value="인천">인천
              <option value="광주">광주
              <option value="대전">대전
              <option value="울산">울산
              <option value="세종">세종
              <option value="경기">경기
              <option value="강원">강원
              <option value="충북">충북
              <option value="충남">충남
              <option value="전북">전북
              <option value="전남">전남
              <option value="경북">경북
              <option value="경남">경남
              <option value="제주">제주
            </select>
            <select class="smallSelect" name="sa12">
              <option value="<%=street1%>" selected><%=street1 %>
            </select>
             <a href="javascript:showArea2()" class="plusButton" id="pb3" >+</a>
        </div>
        <div id="hjf3">
          <div class="inputDesc">희망 지역2</div>
          <input type="hidden" name="sArea2" value="">
            <select class="smallSelect" name="sa21" onChange="areaChange2()">
              <%if(area2!=null){ %>
              <option value="<%=area2%>" selected><%=area2 %>
              <%}else{ %>
              <option value="" selected>지역
              <%} %>
              <option value="서울">서울
              <option value="부산">부산
              <option value="대구">대구
              <option value="인천">인천
              <option value="광주">광주
              <option value="대전">대전
              <option value="울산">울산
              <option value="세종">세종
              <option value="경기">경기
              <option value="강원">강원
              <option value="충북">충북
              <option value="충남">충남
              <option value="전북">전북
              <option value="전남">전남
              <option value="경북">경북
              <option value="경남">경남
              <option value="제주">제주
              <option value="제거">항목제거
            </select>
            <select class="smallSelect" name="sa22">
              <%if(street2!=null){ %>
              <option value="<%=street2%>" selected><%=street2%>
              <%}else{ %>
              <option value="" selected>상세지역
              <%} %>
            </select>
            <a href="javascript:showArea3()" class="plusButton" id="pb4">+</a>
        </div>
        <div id="hjf4">
          <div class="inputDesc">희망 지역3</div>
          <input type="hidden" name="sArea3" value="">
            <select class="smallSelect" name="sa31" onChange="areaChange3()">
              <%if(area3!=null){ %>
              <option value="<%=area3%>" selected><%=area3 %>
              <%}else{ %>
              <option value="" selected>지역
              <%} %>
              <option value="서울">서울
              <option value="부산">부산
              <option value="대구">대구
              <option value="인천">인천
              <option value="광주">광주
              <option value="대전">대전
              <option value="울산">울산
              <option value="세종">세종
              <option value="경기">경기
              <option value="강원">강원
              <option value="충북">충북
              <option value="충남">충남
              <option value="전북">전북
              <option value="전남">전남
              <option value="경북">경북
              <option value="경남">경남
              <option value="제주">제주
              <option value="제거">항목제거
            </select>
            <select class="smallSelect" name="sa32">
              <%if(street3!=null){ %>
              <option value="<%=street3%>" selected><%=street3%>
              <%}else{ %>
              <option value="" selected>상세지역
              <%} %>
            </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">수업횟수</div>
            <select class="bigSelect" name="sDay">
              <option value="<%=sbean.getsDay()%>" selected><%=sbean.getsDay()%>
              <option value="협의">협의
              <option value="주2회">주2회
              <option value="주3회">주3회
              <option value="주5회">주5회
          </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">시간대</div>
            <select class="bigSelect" name="sTime">
              <option value="<%=sbean.getsTime()%>" selected><%=sbean.getsTime()%>
              <option value="협의">협의
              <option value="오전">오전
              <option value="오후">오후
              <option value="저녁">저녁
          </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">희망 과외비</div>
          <select class="bigSelect" name="sFee">
            <option value="<%=sbean.getsFee()%>" selected><%if(sbean.getsFee()==0){%>협의<%}else{ %><%=sbean.getsFee()%>만원이하<%} %>
            <option value="0">협의
            <option value="70">70만원이하
            <option value="60">60만원이하
            <option value="50">50만원이하
            <option value="40">40만원이하
            <option value="30">30만원이하
        </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">정보공개여부</div>
            <%if(sbean.getsOpen()==1){%>
            <input type="radio" name="sOpen" value="1" style="width:25px;height:25px;" checked> 예
            <input type="radio" name="sOpen" value="0" style="width:25px;height:25px;"> 아니오
            <%}else{ %>
            <input type="radio" name="sOpen" value="1" style="width:25px;height:25px;"> 예
            <input type="radio" name="sOpen" value="0" style="width:25px;height:25px;" checked> 아니오
            <%} %>
          </div>
      
    </form>
    <div id="MemberButton1">
        <button class="MemberButton" onclick="inputCheck()">
         정보 수정 완료
        </button>
      </div>
      </div>
		<%} %>
        </div>
      </div>
    </div>
    <div include-html="footer.jsp"></div>
    <div include-html="footer1.jsp"></div>
    <script>
      includeHTML();
      function subjectChange1(){//db에서 major, area값을 통해 minor, street값을 불러오는 기능. ajax를 사용하면 간략화 가능
    		ss1=document.studentFrm.ss1.value;
    		if(ss1=="수학"){
    			document.studentFrm.sSubject1.options.length=0;
    			<%for(int i=0;i<mathMinors.size(); i++){%>
    			document.studentFrm.sSubject1.options[<%=i%>]=new Option('<%=mathMinors.get(i)%>', '<%=mathMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="영어"){
    			document.studentFrm.sSubject1.options.length=0;
    			<%for(int i=0;i<englishMinors.size(); i++){%>
    			document.studentFrm.sSubject1.options[<%=i%>]=new Option('<%=englishMinors.get(i)%>', '<%=englishMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="국어"){
    			document.studentFrm.sSubject1.options.length=0;
    			<%for(int i=0;i<koreanMinors.size(); i++){%>
    			document.studentFrm.sSubject1.options[<%=i%>]=new Option('<%=koreanMinors.get(i)%>', '<%=koreanMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="과학"){
    			document.studentFrm.sSubject1.options.length=0;
    			<%for(int i=0;i<scienceMinors.size(); i++){%>
    			document.studentFrm.sSubject1.options[<%=i%>]=new Option('<%=scienceMinors.get(i)%>', '<%=scienceMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="사회"){
    			document.studentFrm.sSubject1.options.length=0;
    			<%for(int i=0;i<societyMinors.size(); i++){%>
    			document.studentFrm.sSubject1.options[<%=i%>]=new Option('<%=societyMinors.get(i)%>', '<%=societyMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="국가공인외국어"){
    			document.studentFrm.sSubject1.options.length=0;
    			<%for(int i=0;i<gforeignMinors.size(); i++){%>
    			document.studentFrm.sSubject1.options[<%=i%>]=new Option('<%=gforeignMinors.get(i)%>', '<%=gforeignMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="제2외국어"){
    			document.studentFrm.sSubject1.options.length=0;
    			<%for(int i=0;i<jforeignMinors.size(); i++){%>
    			document.studentFrm.sSubject1.options[<%=i%>]=new Option('<%=jforeignMinors.get(i)%>', '<%=jforeignMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="IT/컴퓨터"){
    			document.studentFrm.sSubject1.options.length=0;
    			<%for(int i=0;i<itMinors.size(); i++){%>
    			document.studentFrm.sSubject1.options[<%=i%>]=new Option('<%=itMinors.get(i)%>', '<%=itMinors.get(i)%>');
    			<%}%>
    		}
    	}
        function subjectChange2(){
      		ss2=document.studentFrm.ss2.value;
      		if(ss2=="수학"){
      			document.studentFrm.sSubject2.options.length=0;
      			<%for(int i=0;i<mathMinors.size(); i++){%>
      			document.studentFrm.sSubject2.options[<%=i%>]=new Option('<%=mathMinors.get(i)%>', '<%=mathMinors.get(i)%>');
      			<%}%>
      		}else if(ss2=="영어"){
      			document.studentFrm.sSubject2.options.length=0;
      			<%for(int i=0;i<englishMinors.size(); i++){%>
      			document.studentFrm.sSubject2.options[<%=i%>]=new Option('<%=englishMinors.get(i)%>', '<%=englishMinors.get(i)%>');
      			<%}%>
      		}else if(ss2=="국어"){
      			document.studentFrm.sSubject2.options.length=0;
      			<%for(int i=0;i<koreanMinors.size(); i++){%>
      			document.studentFrm.sSubject2.options[<%=i%>]=new Option('<%=koreanMinors.get(i)%>', '<%=koreanMinors.get(i)%>');
      			<%}%>
      		}else if(ss2=="과학"){
      			document.studentFrm.sSubject2.options.length=0;
      			<%for(int i=0;i<scienceMinors.size(); i++){%>
      			document.studentFrm.sSubject2.options[<%=i%>]=new Option('<%=scienceMinors.get(i)%>', '<%=scienceMinors.get(i)%>');
      			<%}%>
      		}else if(ss2=="사회"){
      			document.studentFrm.sSubject2.options.length=0;
      			<%for(int i=0;i<societyMinors.size(); i++){%>
      			document.studentFrm.sSubject2.options[<%=i%>]=new Option('<%=societyMinors.get(i)%>', '<%=societyMinors.get(i)%>');
      			<%}%>
      		}else if(ss2=="국가공인외국어"){
      			document.studentFrm.sSubject2.options.length=0;
      			<%for(int i=0;i<gforeignMinors.size(); i++){%>
      			document.studentFrm.sSubject2.options[<%=i%>]=new Option('<%=gforeignMinors.get(i)%>', '<%=gforeignMinors.get(i)%>');
      			<%}%>
      		}else if(ss2=="제2외국어"){
      			document.studentFrm.sSubject2.options.length=0;
      			<%for(int i=0;i<jforeignMinors.size(); i++){%>
      			document.studentFrm.sSubject2.options[<%=i%>]=new Option('<%=jforeignMinors.get(i)%>', '<%=jforeignMinors.get(i)%>');
      			<%}%>
      		}else if(ss2=="IT/컴퓨터"){
      			document.studentFrm.sSubject2.options.length=0;
      			<%for(int i=0;i<itMinors.size(); i++){%>
      			document.studentFrm.sSubject2.options[<%=i%>]=new Option('<%=itMinors.get(i)%>', '<%=itMinors.get(i)%>');
      			<%}%>
      		}else if(ss2=="제거"){
      			document.studentFrm.sSubject2.options.length=0;
      			document.studentFrm.sSubject2.options[0]=new Option('-', '0')
      		}
      	}
        function subjectChange3(){
      		ss3=document.studentFrm.ss3.value;
      		if(ss3=="수학"){
      			document.studentFrm.sSubject3.options.length=0;
      			<%for(int i=0;i<mathMinors.size(); i++){%>
      			document.studentFrm.sSubject3.options[<%=i%>]=new Option('<%=mathMinors.get(i)%>', '<%=mathMinors.get(i)%>');
      			<%}%>
      		}else if(ss3=="영어"){
      			document.studentFrm.sSubject3.options.length=0;
      			<%for(int i=0;i<englishMinors.size(); i++){%>
      			document.studentFrm.sSubject3.options[<%=i%>]=new Option('<%=englishMinors.get(i)%>', '<%=englishMinors.get(i)%>');
      			<%}%>
      		}else if(ss3=="국어"){
      			document.studentFrm.sSubject3.options.length=0;
      			<%for(int i=0;i<koreanMinors.size(); i++){%>
      			document.studentFrm.sSubject3.options[<%=i%>]=new Option('<%=koreanMinors.get(i)%>', '<%=koreanMinors.get(i)%>');
      			<%}%>
      		}else if(ss3=="과학"){
      			document.studentFrm.sSubject3.options.length=0;
      			<%for(int i=0;i<scienceMinors.size(); i++){%>
      			document.studentFrm.sSubject3.options[<%=i%>]=new Option('<%=scienceMinors.get(i)%>', '<%=scienceMinors.get(i)%>');
      			<%}%>
      		}else if(ss3=="사회"){
      			document.studentFrm.sSubject3.options.length=0;
      			<%for(int i=0;i<societyMinors.size(); i++){%>
      			document.studentFrm.sSubject3.options[<%=i%>]=new Option('<%=societyMinors.get(i)%>', '<%=societyMinors.get(i)%>');
      			<%}%>
      		}else if(ss3=="국가공인외국어"){
      			document.studentFrm.sSubject3.options.length=0;
      			<%for(int i=0;i<gforeignMinors.size(); i++){%>
      			document.studentFrm.sSubject3.options[<%=i%>]=new Option('<%=gforeignMinors.get(i)%>', '<%=gforeignMinors.get(i)%>');
      			<%}%>
      		}else if(ss3=="제2외국어"){
      			document.studentFrm.sSubject3.options.length=0;
      			<%for(int i=0;i<jforeignMinors.size(); i++){%>
      			document.studentFrm.sSubject3.options[<%=i%>]=new Option('<%=jforeignMinors.get(i)%>', '<%=jforeignMinors.get(i)%>');
      			<%}%>
      		}else if(ss3=="IT/컴퓨터"){
      			document.studentFrm.sSubject3.options.length=0;
      			<%for(int i=0;i<itMinors.size(); i++){%>
      			document.studentFrm.sSubject3.options[<%=i%>]=new Option('<%=itMinors.get(i)%>', '<%=itMinors.get(i)%>');
      			<%}%>
      		}else if(ss3=="제거"){
      			document.studentFrm.sSubject3.options.length=0;
      			document.studentFrm.sSubject3.options[0]=new Option('-', '0')
      		}
      	}
        function areaChange1(){
      	  sa11=document.studentFrm.sa11.value;
      	  if(sa11=="서울"){
      		  document.studentFrm.sa12.options.length=0;
  	    	<%for(int i=0;i<seSt.size(); i++){%>
  		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=seSt.get(i)%>', '<%=seSt.get(i)%>');
  		  	<%}%>
      	  }
      	  else if(sa11=="부산"){
      		  document.studentFrm.sa12.options.length=0;
      		<%for(int i=0;i<bsSt.size(); i++){%>
    		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=bsSt.get(i)%>', '<%=bsSt.get(i)%>');
    		  	<%}%>
      	  }
      	  else if(sa11=="대구"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<dgSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=dgSt.get(i)%>', '<%=dgSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="인천"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<icSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=icSt.get(i)%>', '<%=icSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="광주"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<kjSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=kjSt.get(i)%>', '<%=kjSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="대전"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<djSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=djSt.get(i)%>', '<%=djSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="울산"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<usSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=usSt.get(i)%>', '<%=usSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="세종"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<sjSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=sjSt.get(i)%>', '<%=sjSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="경기"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<kkSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=kkSt.get(i)%>', '<%=kkSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="강원"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<kwSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=kwSt.get(i)%>', '<%=kwSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="충북"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<cbSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=cbSt.get(i)%>', '<%=cbSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="충남"){
      		  document.studentFrm.sa12.options.length=0;
        		<%for(int i=0;i<cnSt.size(); i++){%>
      		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=cnSt.get(i)%>', '<%=cnSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa11=="전북"){
      		  document.studentFrm.sa12.options.length=0;
          		<%for(int i=0;i<jbSt.size(); i++){%>
        		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=jbSt.get(i)%>', '<%=jbSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa11=="전남"){
      		  document.studentFrm.sa12.options.length=0;
          		<%for(int i=0;i<jnSt.size(); i++){%>
        		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=jnSt.get(i)%>', '<%=jnSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa11=="경북"){
      		  document.studentFrm.sa12.options.length=0;
          		<%for(int i=0;i<kbSt.size(); i++){%>
        		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=kbSt.get(i)%>', '<%=kbSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa11=="경남"){
      		  document.studentFrm.sa12.options.length=0;
          		<%for(int i=0;i<knSt.size(); i++){%>
        		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=knSt.get(i)%>', '<%=knSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa11=="제주"){
      		  document.studentFrm.sa12.options.length=0;
          		<%for(int i=0;i<jjSt.size(); i++){%>
        		  	document.studentFrm.sa12.options[<%=i%>]=new Option('<%=jjSt.get(i)%>', '<%=jjSt.get(i)%>');
        		  	<%}%>
          	  }
        }
        function areaChange2(){
      	  sa21=document.studentFrm.sa21.value;
      	  if(sa21=="서울"){
      		  document.studentFrm.sa22.options.length=0;
  	    	<%for(int i=0;i<seSt.size(); i++){%>
  		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=seSt.get(i)%>', '<%=seSt.get(i)%>');
  		  	<%}%>
      	  }
      	  else if(sa21=="부산"){
      		  document.studentFrm.sa22.options.length=0;
      		<%for(int i=0;i<bsSt.size(); i++){%>
    		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=bsSt.get(i)%>', '<%=bsSt.get(i)%>');
    		  	<%}%>
      	  }
      	  else if(sa21=="대구"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<dgSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=dgSt.get(i)%>', '<%=dgSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="인천"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<icSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=icSt.get(i)%>', '<%=icSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="광주"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<kjSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=kjSt.get(i)%>', '<%=kjSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="대전"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<djSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=djSt.get(i)%>', '<%=djSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="울산"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<usSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=usSt.get(i)%>', '<%=usSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="세종"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<sjSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=sjSt.get(i)%>', '<%=sjSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="경기"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<kkSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=kkSt.get(i)%>', '<%=kkSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="강원"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<kwSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=kwSt.get(i)%>', '<%=kwSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="충북"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<cbSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=cbSt.get(i)%>', '<%=cbSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="충남"){
      		  document.studentFrm.sa22.options.length=0;
        		<%for(int i=0;i<cnSt.size(); i++){%>
      		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=cnSt.get(i)%>', '<%=cnSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa21=="전북"){
      		  document.studentFrm.sa22.options.length=0;
          		<%for(int i=0;i<jbSt.size(); i++){%>
        		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=jbSt.get(i)%>', '<%=jbSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa21=="전남"){
      		  document.studentFrm.sa22.options.length=0;
          		<%for(int i=0;i<jnSt.size(); i++){%>
        		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=jnSt.get(i)%>', '<%=jnSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa21=="경북"){
      		  document.studentFrm.sa22.options.length=0;
          		<%for(int i=0;i<kbSt.size(); i++){%>
        		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=kbSt.get(i)%>', '<%=kbSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa21=="경남"){
      		  document.studentFrm.sa22.options.length=0;
          		<%for(int i=0;i<knSt.size(); i++){%>
        		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=knSt.get(i)%>', '<%=knSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa21=="제주"){
      		  document.studentFrm.sa22.options.length=0;
          		<%for(int i=0;i<jjSt.size(); i++){%>
        		  	document.studentFrm.sa22.options[<%=i%>]=new Option('<%=jjSt.get(i)%>', '<%=jjSt.get(i)%>');
        		  	<%}%>
          	  }
      	else if(sa21=="제거"){
  			document.studentFrm.sa22.options.length=0;
  			document.studentFrm.sa22.options[0]=new Option('-', '0')
  			}
        }
        function areaChange3(){
      	  sa31=document.studentFrm.sa31.value;
      	  if(sa31=="서울"){
      		  document.studentFrm.sa32.options.length=0;
  	    	<%for(int i=0;i<seSt.size(); i++){%>
  		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=seSt.get(i)%>', '<%=seSt.get(i)%>');
  		  	<%}%>
      	  }
      	  else if(sa31=="부산"){
      		  document.studentFrm.sa32.options.length=0;
      		<%for(int i=0;i<bsSt.size(); i++){%>
    		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=bsSt.get(i)%>', '<%=bsSt.get(i)%>');
    		  	<%}%>
      	  }
      	  else if(sa31=="대구"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<dgSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=dgSt.get(i)%>', '<%=dgSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="인천"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<icSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=icSt.get(i)%>', '<%=icSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="광주"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<kjSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=kjSt.get(i)%>', '<%=kjSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="대전"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<djSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=djSt.get(i)%>', '<%=djSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="울산"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<usSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=usSt.get(i)%>', '<%=usSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="세종"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<sjSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=sjSt.get(i)%>', '<%=sjSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="경기"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<kkSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=kkSt.get(i)%>', '<%=kkSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="강원"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<kwSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=kwSt.get(i)%>', '<%=kwSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="충북"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<cbSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=cbSt.get(i)%>', '<%=cbSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="충남"){
      		  document.studentFrm.sa32.options.length=0;
        		<%for(int i=0;i<cnSt.size(); i++){%>
      		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=cnSt.get(i)%>', '<%=cnSt.get(i)%>');
      		  	<%}%>
        	  }
      	  else if(sa31=="전북"){
      		  document.studentFrm.sa32.options.length=0;
          		<%for(int i=0;i<jbSt.size(); i++){%>
        		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=jbSt.get(i)%>', '<%=jbSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa31=="전남"){
      		  document.studentFrm.sa32.options.length=0;
          		<%for(int i=0;i<jnSt.size(); i++){%>
        		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=jnSt.get(i)%>', '<%=jnSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa31=="경북"){
      		  document.studentFrm.sa32.options.length=0;
          		<%for(int i=0;i<kbSt.size(); i++){%>
        		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=kbSt.get(i)%>', '<%=kbSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa31=="경남"){
      		  document.studentFrm.sa32.options.length=0;
          		<%for(int i=0;i<knSt.size(); i++){%>
        		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=knSt.get(i)%>', '<%=knSt.get(i)%>');
        		  	<%}%>
          	  }
      	  else if(sa31=="제주"){
      		  document.studentFrm.sa32.options.length=0;
          		<%for(int i=0;i<jjSt.size(); i++){%>
        		  	document.studentFrm.sa32.options[<%=i%>]=new Option('<%=jjSt.get(i)%>', '<%=jjSt.get(i)%>');
        		  	<%}%>
          	  }
      	else if(sa31=="제거"){
  			document.studentFrm.sa32.options.length=0;
  			document.studentFrm.sa32.options[0]=new Option('-', '0')
  			}
        }
    </script>
  </body>
</html>
