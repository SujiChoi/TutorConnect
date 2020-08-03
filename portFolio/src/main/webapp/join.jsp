<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
  <head>
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
        padding-left: 14vw;
        padding-right: 5vw;
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
      .idCheckButton{
      	margin-left:20px;
      	border:none;
      	background-color: rgb(88, 193, 137);
      	color:white;
      	border-radius:4px;
      	cursor:pointer;
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
    function inputCheck(){
    	form=document.joinFrm;
    	 if(form.userId.value==""){
    		alert("아이디를 입력하세요!");
    		form.userId.focus();
    	}
    	 else if(form.isExsistsFlag.value!="yes"){
     		alert("id체크를 진행해주세요.");
     	}
    	else if(form.userPwd.value==""){
    		alert("비밀번호를 입력하세요!");
    		form.userPwd.focus();
    	}
    	else if(form.pwdCheck.value==""){
    		alert("비밀번호 확인을 입력하세요!");
    		form.pwdCheck.focus();
    	}
    	else if(form.userPwd.value!=form.pwdCheck.value){
    		alert("입력하신 비밀번호가 다릅니다!");
    		form.pwdCheck.focus();
    	}
    	else if(form.userName.value==""){
    		alert("이름을 입력하세요!");
    		form.userName.focus();
    	}
    	else if(form.userAddress.value==""){
    		alert("주소를 입력하세요!");
    	}
    	else if(form.userPhone.value==""){
    		alert("전화번호를 입력하세요!");
    		form.userPhone.focus();
    	}
    	else if(form.userEmail.value==""){
    		alert("이메일을 입력하세요!");
    		form.userEmail.focus();
    	}
    	else if(form.userBirth.value.length<8){
     		alert("8자리의 생년월일을 입력해주세요!");
     		form.userBirth.focus();
     	}
    	else{
    		form.submit();
    	} 
    }
    function alreadyStudent(){
  		alert("이미 학생으로 등록되어 있습니다!");
  	}
  	function alreadyTeacher(){
  		alert("이미 선생님으로 등록되어 있습니다!");
  	}
  	function idCheck(){
  		var id=document.joinFrm.userId.value;
  		var _width = '300';
	    var _height = '150';
	    var _left = Math.ceil(( window.screen.width - _width )/2);
	    var _top = Math.ceil(( window.screen.width - _height )/4); 
	    if(id == ""){
			alert("아이디를 입력해주세요");
		}else{
			url="joinIdCheck.jsp?userId="+id;
			window.open(url,"check", 'width='+ _width +', height='+ _height +', left=' + _left + ', top='+ _top );
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
      <h1 id="title">회원가입</h1>
      <form method="post" name="joinFrm" action="joinProc.jsp">
      <input type="hidden" name="isExsistsFlag" value="0">
        <div class="joinFlex">
          <div class="inputDesc">아이디</div>
          <div class="inputBox">
            <input type="text" name="userId" class="input" value="" placeholder="아이디" />
          </div>
          <input type="button" class="idCheckButton" style="width:90px;" value="ID체크" onClick="idCheck()"/>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">비밀번호</div>
          <div class="inputBox">
            <input type="password" name="userPwd" class="input" value="" placeholder="비밀번호" />
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">비밀번호 확인</div>
          <div class="inputBox">
            <input type="password" name="pwdCheck" class="input" value="" placeholder="비밀번호 확인" />
          </div>
        </div>
        <div class="joinFlex">
          <div class="inputDesc">성명</div>
          <div class="inputBox">
            <input type="text" name="userName" class="input" value="" placeholder="성명" />
          </div>
        </div>
        <div id="JF_address">
          <div id="JFA_desc">
            주소
          </div>
          <div style="padding-top: 10px;">
            <div class="inputBox">

              <input type="text" id="sample4_roadAddress" placeholder="도로명주소"  class="input" name="userAddress"/>
            </div>
		<input type="hidden" id="sample4_postcode" placeholder="지번/도로명" class="zipinput"/>
      	<input type="hidden" id="sample4_jibunAddress" placeholder="지번주소"  class="zipinput"/>
      	<span id="guide" style="color: #999; display: none;"></span>
      	<input type="hidden" id="sample4_extraAddress" placeholder="참고항목"  class="zipinput"/>
      	<input type="hidden" id="sample4_detailAddress" placeholder="상세주소"  class="zipinput"/>
            <div class="inputBox" style="margin-top: 10px;">
              <input type="text" id="sample4_detailAddress" name="userAddress2" placeholder="상세주소"  class="input"/>
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
            <input type="text" name="userPhone" class="input" value="" placeholder="전화번호" />
          </div>
        </div>

        <div class="joinFlex">
          <div class="inputDesc">이메일</div>
          <div class="inputBox">
            <input type="email" name="userEmail" class="input" value="" placeholder="이메일" />
          </div>
        </div>

        <div class="joinFlex">
          <div class="inputDesc">생년월일</div>
          <div class="inputBox">
            <input type="text" name="userBirth" class="input" value="" maxlength="8" placeholder="ex)19941218" numberOnly />
          </div>
        </div>

        <div class="joinFlex">
          <div class="inputDesc">성별</div>
          
          <div class="gender">남</div>
          <input type="radio" id="iradio" name="userGender" value="1" checked />
          <div class="gender">여</div>
          <input type="radio" id="iradio" name="userGender" value="2" /></div>
      </form>
      <div id="MemberButton1">
        <button class="MemberButton" onclick="inputCheck()">
         회원가입 완료
        </button>
      </div>
      </div>
      <div include-html="footer1.jsp"></div>
    <script>
      includeHTML();
      $("input:text[numberOnly]").on("keyup", function() {
    	    $(this).val($(this).val().replace(/[^0-9]/g,""));
    	});
    </script>
  </body>
</html>
