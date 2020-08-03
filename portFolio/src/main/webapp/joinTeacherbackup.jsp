<%@page import="java.util.Vector"%>
<%@page import="bean.UserBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
<jsp:useBean id="imgr" class="mgr.InfoMgr"/>
<%
request.setCharacterEncoding("UTF-8");
		int userNum=0;
		UserBean bean=new UserBean();
		if(session.getAttribute("userNum")!=null){
		userNum=(Integer)session.getAttribute("userNum");
		bean=mgr.getUser(userNum);
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
    <title>선생님 등록</title>
    <script src="js/includeHTML.js"></script>
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
        font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
        padding-bottom:40px;
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
        padding-top: 10px;
        color: #666666;
        font-weight: 800;
        white-space:pre-line;
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
        padding-left:14vw;
        padding-right:10vw;
        margin-bottom: 30px;
      }
      #hjf2{
        padding-left:14vw;
        padding-right:10vw;
        margin-bottom: 30px;
        display:none;
      }
      #hjf3{
        display: none;
        padding-left:14vw;
        padding-right:10vw;
        margin-bottom: 30px;
      }
      #hjf4{
        display: none;
        padding-left:14vw;
        padding-right:10vw;
        margin-bottom: 30px;
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
      textarea{
        resize:none;
      }
      textarea:focus{
        outline:none;
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
    		form=document.teacherFrm;
    		if(form.tNickname.value==""){
    			alert("닉네임을 입력해주세요!");
    			form.tNickname.focus();
    		}
    		else if(form.tRecord.value==""){
    			alert("학력을 입력해주세요!");
    		}
    		else if(form.tRange.value=="0"){
    			alert("교습대상을 입력해주세요!");
    		}
    		else if(form.tSubject1.value==""){
    			alert("가르치고 싶은 과목을 하나 이상 선택해주세요!");
    		}
    		else if(form.sa11.value==""){
    			alert("지역을 하나 이상 입력해주세요!");
    		}
    		else if(form.tImage.value==""){
    			alert("사진을 첨부해주세요!");
    		}
    		else{
    			var sa11=form.sa11.value;
        		var sa12=form.sa12.value;
        		form.tArea1.value=sa11+sa12;
        		var sa21=form.sa21.value;
        		var sa22=form.sa22.value;
        		form.tArea2.value=sa21+sa22;
        		var sa31=form.sa31.value;
        		var sa32=form.sa32.value;
        		form.tArea3.value=sa31+sa32;
        		form.submit();
    		}
    	}
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
    </script>
  </head>
  <body>
    <header include-html="header.jsp"></header>
    <div id="contentWrap">
      <h1 id="title">선생님 등록</h1>
   <div class="joinFlex">
          <div class="inputDesc">성명</div>
          <div class="inputBox">
           <input type="text" class="input" value="<%=bean.getUserName()%>" readonly>
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">핸드폰번호</div>
          <div class="inputBox">
          	<input type="text" class="input" value="<%=bean.getUserPhone() %>" readonly>
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">이메일</div>
          <div class="inputBox">
          <input type="text" class="input" value="<%=bean.getUserEmail() %>" readonly>
          </div>
        </div>
     <form name="teacherFrm" method="post" action="TeacherServlet" 
enctype="multipart/form-data">
      
	<input type="hidden" name="userNum" value="<%=userNum%>">
        <div class="joinFlex">
          <div class="inputDesc">닉네임</div>
          <div class="inputBox">
            <input type="text" name="tNickname" class="input" placeholder="10글자 제한" maxlength="10" />
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">최종학력</div>
          <div class="inputBox">
            <input type="text" class="input"  name="tRecord" value="" placeholder="ex)부산대학교 기계공학과 석사">
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">교습대상</div>
            <select class="bigSelect" name="tRange">
              <option value="0" selected>선택하세요.
              <option value="1">초등학생
              <option value="2">중학생
              <option value="3">고등학생
              <option value="4">대학생
              <option value="5">성인
              <option value="6">무관
          </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">과목</div>
            <select class="smallSelect" name="ss1" onchange="subjectChange1()">
              <option value="" selected>과목
              <option value="국어">국어
              <option value="수학">수학
              <option value="영어">영어
              <option value="과학">과학
              <option value="사회">사회
              <option value="국가공인외국어">국가공인외국어
              <option value="제2외국어">제2외국어
              <option value="IT/컴퓨터">IT/컴퓨터
            </select>
            <select class="smallSelect" name="tSubject1">
              <option value="" selected>세부과목
            </select>
             <a href="javascript:showSub2()" class="plusButton" id="pb1" >+</a>
        </div>
        <div id="hjf1">
          <div class="inputDesc">과목2</div>
            <select class="smallSelect" name="ss2" onchange="subjectChange2()">
              <option value="" selected>과목
              <option value="국어">국어
              <option value="수학">수학
              <option value="영어">영어
              <option value="과학">과학
              <option value="사회">사회
              <option value="국가공인외국어">국가공인외국어
              <option value="제2외국어">제2외국어
              <option value="IT/컴퓨터">IT/컴퓨터
            </select>
            <select class="smallSelect" name="tSubject2">
              <option value="" selected>세부과목
            </select>
            <a href="javascript:showSub3()" class="plusButton" id="pb2">+</a>
        </div>
        <div id="hjf2">
          <div class="inputDesc">과목3</div>
            <select class="smallSelect" name="ss3" onchange="subjectChange3()">
              <option value="" selected>과목
              <option value="국어">국어
              <option value="수학">수학
              <option value="영어">영어
              <option value="과학">과학
              <option value="사회">사회
              <option value="국가공인외국어">국가공인외국어
              <option value="제2외국어">제2외국어
              <option value="IT/컴퓨터">IT/컴퓨터
            </select>
            <select class="smallSelect" name="tSubject3">
              <option value="" selected>세부과목
            </select>
        </div>

        <div class="joinFlex">
          <div class="inputDesc">희망 지역</div>
          <input type="hidden" name="tArea1" value="">
          <select class="smallSelect" name="sa11" onChange="areaChange1()">
              <option value="" selected>지역
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
              <option value="" selected>상세지역
            </select>
             <a href="javascript:showArea2()" class="plusButton" id="pb3" >+</a>
        </div>
        <div id="hjf3">
          <div class="inputDesc">희망 지역2</div>
            <input type="hidden" name="tArea2" value="">
            <select class="smallSelect" name="sa21" onChange="areaChange2()">
              <option value="" selected>지역
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
            <select class="smallSelect" name="sa22">
              <option value="" selected>상세지역
            </select>
            <a href="javascript:showArea3()" class="plusButton" id="pb4">+</a>
        </div>
        <div id="hjf4">
          <div class="inputDesc">희망 지역3</div>
            <input type="hidden" name="tArea3" value="">
            <select class="smallSelect" name="sa31" onChange="areaChange3()">
              <option value="" selected>지역
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
            <select class="smallSelect" name="sa32">
              <option value="" selected>상세지역
            </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">수업횟수</div>
            <select class="bigSelect" name="tDay">
              <option value="협의" selected>협의
              <option value="주2회">주2회
              <option value="주3회">주3회
              <option value="주5회">주5회
          </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">시간대</div>
            <select class="bigSelect" name="tTime">
              <option value="협의" selected>협의
              <option value="오전">오전
              <option value="오후">오후
              <option value="저녁">저녁
          </select>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">희망 과외비</div>
          <select class="bigSelect" name="tFee">
            <option value="0" selected>협의
            <option value="70">70만원이하
            <option value="60">60만원이하
            <option value="50">50만원이하
            <option value="40">40만원이하
            <option value="30">30만원이하
        </select>
        </div>
          <div class="joinFlex">
            <div class="inputDesc">선생님 사진 등록</div>
            <input type="file" name="tImage" id="tImage" />
          </div>
          <div class="joinFlex">
            <div class="inputDesc">선생님 과외 영상</div>
            <input type="file" name="tFile" />
          </div>
          <div class="joinFlex">
            <div class="inputDesc">자기소개</div>
            <textarea name="tPR" cols="54" rows="10"></textarea>
          </div>
        <div class="joinFlex">
          <div class="inputDesc">정보공개여부</div>
          <input type="checkbox" name="tOpen" value="1" style="width:25px;height:25px;"> 
        </div>
      
    </form>
    <div id="MemberButton1">
        <button class="MemberButton" onclick="inputCheck()">
         선생님 등록완료
        </button>
      </div>
    </div>
    <div include-html="footer.jsp"></div>
    <div include-html="footer1.jsp"></div>
    <script>
      includeHTML();
      /* $(document).ready(function () {
          $('html, body').animate({
              scrollTop: $('#contentWrap').offset().top
          }, 'fast'); //slow
      }); */
      function subjectChange1(){
    		ss1=document.teacherFrm.ss1.value;
    		if(ss1=="수학"){
    			document.teacherFrm.tSubject1.options.length=0;
    			<%for(int i=0;i<mathMinors.size(); i++){%>
    			document.teacherFrm.tSubject1.options[<%=i%>]=new Option('<%=mathMinors.get(i)%>', '<%=mathMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="영어"){
    			document.teacherFrm.tSubject1.options.length=0;
    			<%for(int i=0;i<englishMinors.size(); i++){%>
    			document.teacherFrm.tSubject1.options[<%=i%>]=new Option('<%=englishMinors.get(i)%>', '<%=englishMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="국어"){
    			document.teacherFrm.tSubject1.options.length=0;
    			<%for(int i=0;i<koreanMinors.size(); i++){%>
    			document.teacherFrm.tSubject1.options[<%=i%>]=new Option('<%=koreanMinors.get(i)%>', '<%=koreanMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="과학"){
    			document.teacherFrm.tSubject1.options.length=0;
    			<%for(int i=0;i<scienceMinors.size(); i++){%>
    			document.teacherFrm.tSubject1.options[<%=i%>]=new Option('<%=scienceMinors.get(i)%>', '<%=scienceMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="사회"){
    			document.teacherFrm.tSubject1.options.length=0;
    			<%for(int i=0;i<societyMinors.size(); i++){%>
    			document.teacherFrm.tSubject1.options[<%=i%>]=new Option('<%=societyMinors.get(i)%>', '<%=societyMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="국가공인외국어"){
    			document.teacherFrm.tSubject1.options.length=0;
    			<%for(int i=0;i<gforeignMinors.size(); i++){%>
    			document.teacherFrm.tSubject1.options[<%=i%>]=new Option('<%=gforeignMinors.get(i)%>', '<%=gforeignMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="제2외국어"){
    			document.teacherFrm.tSubject1.options.length=0;
    			<%for(int i=0;i<jforeignMinors.size(); i++){%>
    			document.teacherFrm.tSubject1.options[<%=i%>]=new Option('<%=jforeignMinors.get(i)%>', '<%=jforeignMinors.get(i)%>');
    			<%}%>
    		}else if(ss1=="IT/컴퓨터"){
    			document.teacherFrm.tSubject1.options.length=0;
    			<%for(int i=0;i<itMinors.size(); i++){%>
    			document.teacherFrm.tSubject1.options[<%=i%>]=new Option('<%=itMinors.get(i)%>', '<%=itMinors.get(i)%>');
    			<%}%>
    		}
    	}
      function subjectChange2(){
  		ss2=document.teacherFrm.ss2.value;
  		if(ss2=="수학"){
  			document.teacherFrm.tSubject2.options.length=0;
  			<%for(int i=0;i<mathMinors.size(); i++){%>
  			document.teacherFrm.tSubject2.options[<%=i%>]=new Option('<%=mathMinors.get(i)%>', '<%=mathMinors.get(i)%>');
  			<%}%>
  		}else if(ss2=="영어"){
  			document.teacherFrm.tSubject2.options.length=0;
  			<%for(int i=0;i<englishMinors.size(); i++){%>
  			document.teacherFrm.tSubject2.options[<%=i%>]=new Option('<%=englishMinors.get(i)%>', '<%=englishMinors.get(i)%>');
  			<%}%>
  		}else if(ss2=="국어"){
  			document.teacherFrm.tSubject2.options.length=0;
  			<%for(int i=0;i<koreanMinors.size(); i++){%>
  			document.teacherFrm.tSubject2.options[<%=i%>]=new Option('<%=koreanMinors.get(i)%>', '<%=koreanMinors.get(i)%>');
  			<%}%>
  		}else if(ss2=="과학"){
  			document.teacherFrm.tSubject2.options.length=0;
  			<%for(int i=0;i<scienceMinors.size(); i++){%>
  			document.teacherFrm.tSubject2.options[<%=i%>]=new Option('<%=scienceMinors.get(i)%>', '<%=scienceMinors.get(i)%>');
  			<%}%>
  		}else if(ss2=="사회"){
  			document.teacherFrm.tSubject2.options.length=0;
  			<%for(int i=0;i<societyMinors.size(); i++){%>
  			document.teacherFrm.tSubject2.options[<%=i%>]=new Option('<%=societyMinors.get(i)%>', '<%=societyMinors.get(i)%>');
  			<%}%>
  		}else if(ss2=="국가공인외국어"){
  			document.teacherFrm.tSubject2.options.length=0;
  			<%for(int i=0;i<gforeignMinors.size(); i++){%>
  			document.teacherFrm.tSubject2.options[<%=i%>]=new Option('<%=gforeignMinors.get(i)%>', '<%=gforeignMinors.get(i)%>');
  			<%}%>
  		}else if(ss2=="제2외국어"){
  			document.teacherFrm.tSubject2.options.length=0;
  			<%for(int i=0;i<jforeignMinors.size(); i++){%>
  			document.teacherFrm.tSubject2.options[<%=i%>]=new Option('<%=jforeignMinors.get(i)%>', '<%=jforeignMinors.get(i)%>');
  			<%}%>
  		}else if(ss2=="IT/컴퓨터"){
  			document.teacherFrm.tSubject2.options.length=0;
  			<%for(int i=0;i<itMinors.size(); i++){%>
  			document.teacherFrm.tSubject2.options[<%=i%>]=new Option('<%=itMinors.get(i)%>', '<%=itMinors.get(i)%>');
  			<%}%>
  		}
  	}
      function subjectChange3(){
    		ss3=document.teacherFrm.ss3.value;
    		if(ss3=="수학"){
    			document.teacherFrm.tSubject3.options.length=0;
    			<%for(int i=0;i<mathMinors.size(); i++){%>
    			document.teacherFrm.tSubject3.options[<%=i%>]=new Option('<%=mathMinors.get(i)%>', '<%=mathMinors.get(i)%>');
    			<%}%>
    		}else if(ss3=="영어"){
    			document.teacherFrm.tSubject3.options.length=0;
    			<%for(int i=0;i<englishMinors.size(); i++){%>
    			document.teacherFrm.tSubject3.options[<%=i%>]=new Option('<%=englishMinors.get(i)%>', '<%=englishMinors.get(i)%>');
    			<%}%>
    		}else if(ss3=="국어"){
    			document.teacherFrm.tSubject3.options.length=0;
    			<%for(int i=0;i<koreanMinors.size(); i++){%>
    			document.teacherFrm.tSubject3.options[<%=i%>]=new Option('<%=koreanMinors.get(i)%>', '<%=koreanMinors.get(i)%>');
    			<%}%>
    		}else if(ss3=="과학"){
    			document.teacherFrm.tSubject3.options.length=0;
    			<%for(int i=0;i<scienceMinors.size(); i++){%>
    			document.teacherFrm.tSubject3.options[<%=i%>]=new Option('<%=scienceMinors.get(i)%>', '<%=scienceMinors.get(i)%>');
    			<%}%>
    		}else if(ss3=="사회"){
    			document.teacherFrm.tSubject3.options.length=0;
    			<%for(int i=0;i<societyMinors.size(); i++){%>
    			document.teacherFrm.tSubject3.options[<%=i%>]=new Option('<%=societyMinors.get(i)%>', '<%=societyMinors.get(i)%>');
    			<%}%>
    		}else if(ss3=="국가공인외국어"){
    			document.teacherFrm.tSubject3.options.length=0;
    			<%for(int i=0;i<gforeignMinors.size(); i++){%>
    			document.teacherFrm.tSubject3.options[<%=i%>]=new Option('<%=gforeignMinors.get(i)%>', '<%=gforeignMinors.get(i)%>');
    			<%}%>
    		}else if(ss3=="제2외국어"){
    			document.teacherFrm.tSubject3.options.length=0;
    			<%for(int i=0;i<jforeignMinors.size(); i++){%>
    			document.teacherFrm.tSubject3.options[<%=i%>]=new Option('<%=jforeignMinors.get(i)%>', '<%=jforeignMinors.get(i)%>');
    			<%}%>
    		}else if(ss3=="IT/컴퓨터"){
    			document.teacherFrm.tSubject3.options.length=0;
    			<%for(int i=0;i<itMinors.size(); i++){%>
    			document.teacherFrm.tSubject3.options[<%=i%>]=new Option('<%=itMinors.get(i)%>', '<%=itMinors.get(i)%>');
    			<%}%>
    		}
    	}
      function areaChange1(){
    	  sa11=document.teacherFrm.sa11.value;
    	  if(sa11=="서울"){
    		  document.teacherFrm.sa12.options.length=0;
	    	<%for(int i=0;i<seSt.size(); i++){%>
		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=seSt.get(i)%>', '<%=seSt.get(i)%>');
		  	<%}%>
    	  }
    	  else if(sa11=="부산"){
    		  document.teacherFrm.sa12.options.length=0;
    		<%for(int i=0;i<bsSt.size(); i++){%>
  		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=bsSt.get(i)%>', '<%=bsSt.get(i)%>');
  		  	<%}%>
    	  }
    	  else if(sa11=="대구"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<dgSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=dgSt.get(i)%>', '<%=dgSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="인천"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<icSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=icSt.get(i)%>', '<%=icSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="광주"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<kjSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=kjSt.get(i)%>', '<%=kjSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="대전"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<djSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=djSt.get(i)%>', '<%=djSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="울산"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<usSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=usSt.get(i)%>', '<%=usSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="세종"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<sjSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=sjSt.get(i)%>', '<%=sjSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="경기"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<kkSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=kkSt.get(i)%>', '<%=kkSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="강원"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<kwSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=kwSt.get(i)%>', '<%=kwSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="충북"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<cbSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=cbSt.get(i)%>', '<%=cbSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="충남"){
    		  document.teacherFrm.sa12.options.length=0;
      		<%for(int i=0;i<cnSt.size(); i++){%>
    		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=cnSt.get(i)%>', '<%=cnSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa11=="전북"){
    		  document.teacherFrm.sa12.options.length=0;
        		<%for(int i=0;i<jbSt.size(); i++){%>
      		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=jbSt.get(i)%>', '<%=jbSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa11=="전남"){
    		  document.teacherFrm.sa12.options.length=0;
        		<%for(int i=0;i<jnSt.size(); i++){%>
      		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=jnSt.get(i)%>', '<%=jnSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa11=="경북"){
    		  document.teacherFrm.sa12.options.length=0;
        		<%for(int i=0;i<kbSt.size(); i++){%>
      		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=kbSt.get(i)%>', '<%=kbSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa11=="경남"){
    		  document.teacherFrm.sa12.options.length=0;
        		<%for(int i=0;i<knSt.size(); i++){%>
      		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=knSt.get(i)%>', '<%=knSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa11=="제주"){
    		  document.teacherFrm.sa12.options.length=0;
        		<%for(int i=0;i<jjSt.size(); i++){%>
      		  	document.teacherFrm.sa12.options[<%=i%>]=new Option('<%=jjSt.get(i)%>', '<%=jjSt.get(i)%>');
      		  	<%}%>
        	  }
      }
      function areaChange2(){
    	  sa21=document.teacherFrm.sa21.value;
    	  if(sa21=="서울"){
    		  document.teacherFrm.sa22.options.length=0;
	    	<%for(int i=0;i<seSt.size(); i++){%>
		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=seSt.get(i)%>', '<%=seSt.get(i)%>');
		  	<%}%>
    	  }
    	  else if(sa21=="부산"){
    		  document.teacherFrm.sa22.options.length=0;
    		<%for(int i=0;i<bsSt.size(); i++){%>
  		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=bsSt.get(i)%>', '<%=bsSt.get(i)%>');
  		  	<%}%>
    	  }
    	  else if(sa21=="대구"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<dgSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=dgSt.get(i)%>', '<%=dgSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="인천"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<icSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=icSt.get(i)%>', '<%=icSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="광주"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<kjSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=kjSt.get(i)%>', '<%=kjSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="대전"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<djSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=djSt.get(i)%>', '<%=djSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="울산"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<usSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=usSt.get(i)%>', '<%=usSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="세종"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<sjSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=sjSt.get(i)%>', '<%=sjSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="경기"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<kkSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=kkSt.get(i)%>', '<%=kkSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="강원"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<kwSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=kwSt.get(i)%>', '<%=kwSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="충북"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<cbSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=cbSt.get(i)%>', '<%=cbSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="충남"){
    		  document.teacherFrm.sa22.options.length=0;
      		<%for(int i=0;i<cnSt.size(); i++){%>
    		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=cnSt.get(i)%>', '<%=cnSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa21=="전북"){
    		  document.teacherFrm.sa22.options.length=0;
        		<%for(int i=0;i<jbSt.size(); i++){%>
      		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=jbSt.get(i)%>', '<%=jbSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa21=="전남"){
    		  document.teacherFrm.sa22.options.length=0;
        		<%for(int i=0;i<jnSt.size(); i++){%>
      		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=jnSt.get(i)%>', '<%=jnSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa21=="경북"){
    		  document.teacherFrm.sa22.options.length=0;
        		<%for(int i=0;i<kbSt.size(); i++){%>
      		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=kbSt.get(i)%>', '<%=kbSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa21=="경남"){
    		  document.teacherFrm.sa22.options.length=0;
        		<%for(int i=0;i<knSt.size(); i++){%>
      		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=knSt.get(i)%>', '<%=knSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa21=="제주"){
    		  document.teacherFrm.sa22.options.length=0;
        		<%for(int i=0;i<jjSt.size(); i++){%>
      		  	document.teacherFrm.sa22.options[<%=i%>]=new Option('<%=jjSt.get(i)%>', '<%=jjSt.get(i)%>');
      		  	<%}%>
        	  }
      }
      function areaChange3(){
    	  sa31=document.teacherFrm.sa31.value;
    	  if(sa31=="서울"){
    		  document.teacherFrm.sa32.options.length=0;
	    	<%for(int i=0;i<seSt.size(); i++){%>
		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=seSt.get(i)%>', '<%=seSt.get(i)%>');
		  	<%}%>
    	  }
    	  else if(sa31=="부산"){
    		  document.teacherFrm.sa32.options.length=0;
    		<%for(int i=0;i<bsSt.size(); i++){%>
  		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=bsSt.get(i)%>', '<%=bsSt.get(i)%>');
  		  	<%}%>
    	  }
    	  else if(sa31=="대구"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<dgSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=dgSt.get(i)%>', '<%=dgSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="인천"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<icSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=icSt.get(i)%>', '<%=icSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="광주"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<kjSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=kjSt.get(i)%>', '<%=kjSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="대전"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<djSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=djSt.get(i)%>', '<%=djSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="울산"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<usSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=usSt.get(i)%>', '<%=usSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="세종"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<sjSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=sjSt.get(i)%>', '<%=sjSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="경기"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<kkSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=kkSt.get(i)%>', '<%=kkSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="강원"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<kwSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=kwSt.get(i)%>', '<%=kwSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="충북"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<cbSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=cbSt.get(i)%>', '<%=cbSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="충남"){
    		  document.teacherFrm.sa32.options.length=0;
      		<%for(int i=0;i<cnSt.size(); i++){%>
    		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=cnSt.get(i)%>', '<%=cnSt.get(i)%>');
    		  	<%}%>
      	  }
    	  else if(sa31=="전북"){
    		  document.teacherFrm.sa32.options.length=0;
        		<%for(int i=0;i<jbSt.size(); i++){%>
      		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=jbSt.get(i)%>', '<%=jbSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa31=="전남"){
    		  document.teacherFrm.sa32.options.length=0;
        		<%for(int i=0;i<jnSt.size(); i++){%>
      		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=jnSt.get(i)%>', '<%=jnSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa31=="경북"){
    		  document.teacherFrm.sa32.options.length=0;
        		<%for(int i=0;i<kbSt.size(); i++){%>
      		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=kbSt.get(i)%>', '<%=kbSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa31=="경남"){
    		  document.teacherFrm.sa32.options.length=0;
        		<%for(int i=0;i<knSt.size(); i++){%>
      		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=knSt.get(i)%>', '<%=knSt.get(i)%>');
      		  	<%}%>
        	  }
    	  else if(sa31=="제주"){
    		  document.teacherFrm.sa32.options.length=0;
        		<%for(int i=0;i<jjSt.size(); i++){%>
      		  	document.teacherFrm.sa32.options[<%=i%>]=new Option('<%=jjSt.get(i)%>', '<%=jjSt.get(i)%>');
      		  	<%}%>
        	  }
      }
    </script>
  </body>
</html>
