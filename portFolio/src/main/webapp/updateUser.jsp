<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="bean.UserBean"%>
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
        width: 200px;
        margin-top: 10px;
        margin-right: 30px;
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
        width: 920px;
        height: auto;
        border-left: 1px solid gray;
        padding: 10px 50px 0px 0px;
      }
      .joinFlex {
        display: flex;
        padding-left:7vw;
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
        padding-left: 7vw;
        height: 130px;
        margin-bottom: 30px;
      }
      #JFA_desc {
        width: 140px;
        padding-top: 50px;
        color: #666666;
        font-weight: 800;
      }
      #JFA_buttondiv {
        padding: 20px;
        width: 130px;
        height: 130px;
      }
      .addressButton {
        background-color: rgb(88, 193, 137);
        width: 90px;
        height: 90px;
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: 800;
        cursor:pointer;
      }
      .gender{
        width: 100px;
        padding-top:8px;
        font-weight:800;
      }
      #iradio{
       margin: 15px;
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
      function inputCheck(){
      	form=document.joinFrm;
      	 if(form.userId.value==""){
      		alert("아이디를 입력하세요!");
      		form.userId.focus();
      	}
      	else if(form.userPwd.value==""){
      		alert("비밀번호를 입력하세요!");
      		form.userPwd.focues();
      	}
      	else if(form.pwdCheck.value==""){
      		alert("비밀번호 확인을 입력하세요!");
      		form.pwdCheck.focues();
      	}
      	else if(form.userPwd.value!=form.pwdCheck.value){
      		alert("입력하신 비밀번호가 다릅니다!");
      		form.pwdCheck.focus();
      	}
      	else if(form.userName.value==""){
      		alert("이름을 입력하세요!");
      		form.userName.focues();
      	}
      	else if(form.userPhone.value==""){
      		alert("전화번호를 입력하세요!");
      		form.userPhone.focues();
      	}
      	else if(form.userEmail.value==""){
      		alert("이메일을 입력하세요!");
      		form.userEmail.focues();
      	}
      	else if(form.userEmail.value==""){
      		alert("이메일을 입력하세요!");
      		form.userEmail.focues();
      	}
      	else if(form.userBirth.value.length<8){
       		alert("8자리의 생년월일을 입력해주세요!");
       		form.userBirth.focues();
       	} 
      	else{
      		form.submit();
      	} 
      }
    </script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
      //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
      function sample4_execDaumPostcode() {
        new daum.Postcode({
          oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var roadAddr = data.roadAddress; // 도로명 주소 변수
            var extraRoadAddr = ""; // 참고 항목 변수

            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
              extraRoadAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== "" && data.apartment === "Y") {
              extraRoadAddr +=
                extraRoadAddr !== ""
                  ? ", " + data.buildingName
                  : data.buildingName;
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraRoadAddr !== "") {
              extraRoadAddr = " (" + extraRoadAddr + ")";
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("sample4_postcode").value = data.zonecode;
            document.getElementById("sample4_roadAddress").value = roadAddr;
            document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
			
            // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
            if (roadAddr !== "") {
              document.getElementById(
                "sample4_extraAddress"
              ).value = extraRoadAddr;
            } else {
              document.getElementById("sample4_extraAddress").value = "";
            }

            var guideTextBox = document.getElementById("guide");
            // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
            if (data.autoRoadAddress) {
              var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
              guideTextBox.innerHTML = "(예상 도로명 주소 : " + expRoadAddr + ")";
              guideTextBox.style.display = "block";
            } else if (data.autoJibunAddress) {
              var expJibunAddr = data.autoJibunAddress;
              guideTextBox.innerHTML = "(예상 지번 주소 : " + expJibunAddr + ")";
              guideTextBox.style.display = "block";
            } else {
              guideTextBox.innerHTML = "";
              guideTextBox.style.display = "none";
            }
          },
        }).open();
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
            <a href="" style="color: rgb(88, 193, 137);">기본정보</a>
          </div>
          <div class="menus2sub">
            <a href="updateStudent.jsp">학생정보</a>
          </div>
          <div class="menus2sub">
            <a href="updateTeacher.jsp">선생정보</a>
          </div>
          <div class="menus2"><a href="deleteUser.jsp">회원 탈퇴</a></div>
        </div>
        <div id="myPageContents">
          <div id="myPageContent">
          <form method="post" name="joinFrm" action="UpdateUser">
          <input type="hidden" name="userNum" value="<%=userNum %>"/>
        <div class="joinFlex">
          <div class="inputDesc">아이디</div>
          <div class="inputBox" style="border:none;">
            <input type="text" name="userId" class="input" value="<%=bean.getUserId()%>" placeholder="아이디" readonly/>
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">비밀번호</div>
          <div class="inputBox">
            <input type="password" name="userPwd" class="input" value="<%=bean.getUserPwd() %>" placeholder="비밀번호" />
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">비밀번호 확인</div>
          <div class="inputBox">
            <input type="password" name="pwdCheck" class="input" value="<%=bean.getUserPwd() %>" placeholder="비밀번호 확인" />
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">성명</div>
          <div class="inputBox">
            <input type="text" name="userName" class="input" value="<%=bean.getUserName() %>" placeholder="성명" />
          </div>
        </div>
        <div id="JF_address">
          <div id="JFA_desc">
            주소
          </div>
          <div style="padding-top: 10px;">
            <div class="inputBox">

              <input type="text" id="sample4_roadAddress" placeholder="도로명주소" value="<%=bean.getUserAddress()%>" class="input" name="userAddress"/>
            </div>
		<input type="hidden" id="sample4_postcode" placeholder="지번/도로명" class="zipinput"/>
      	<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소"  class="zipinput"/>
      	<span id="guide" style="color: #999; display: none;"></span>
      	<input type="hidden" id="sample4_extraAddress" placeholder="참고항목"  class="zipinput"/>
      	<input type="hidden" id="sample4_detailAddress" placeholder="상세주소"  class="zipinput"/>
            <div class="inputBox" style="margin-top: 10px;">
              <input type="text" id="sample4_detailAddress" name="userAddress2" value="<%=bean.getUserAddress2() %>" placeholder="상세주소"  class="input"/>
            </div>
          </div>
          <div id="JFA_buttondiv">
               <input type="button" class="addressButton" onclick="sample4_execDaumPostcode()" value="검색"/>
            </button>
          </div>
        </div>

        <div class="joinFlex">
          <div class="inputDesc">전화번호</div>
          <div class="inputBox">
            <input type="text" name="userPhone" class="input" value="<%=bean.getUserPhone() %>" placeholder="전화번호" />
          </div>
        </div>

        <div class="joinFlex">
          <div class="inputDesc">이메일</div>
          <div class="inputBox">
            <input type="email" name="userEmail" class="input" value="<%=bean.getUserEmail() %>" placeholder="이메일" />
          </div>
        </div>

        <div class="joinFlex">
          <div class="inputDesc">생년월일</div>
          <div class="inputBox">
            <input type="text" name="userBirth" class="input" value="<%=bean.getUserBirth() %>" maxlength="8" placeholder="ex)19941218" numberOnly />
          </div>
        </div>

        <div class="joinFlex">
          <div class="inputDesc">성별</div>
          
          <%if(bean.getUserGender().equals("1")){ %>
          <div class="gender">남</div>
          <input type="radio" id="iradio" name="userGender" value="1" checked />
          <div class="gender">여</div>
          <input type="radio" id="iradio" name="userGender" value="2" /></div>
          <%}else{ %>
          <div class="gender">남</div>
          <input type="radio" id="iradio" name="userGender" value="1"/>
          <div class="gender">여</div>
          <input type="radio" id="iradio" name="userGender" value="2" checked /></div>
          <%} %>
      	<input type="hidden" name="userAddress" value=""> 
      </form>
      <div id="MemberButton1">
        <button class="MemberButton" onclick="inputCheck()">
         정보 수정 완료
        </button>
      </div>
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
