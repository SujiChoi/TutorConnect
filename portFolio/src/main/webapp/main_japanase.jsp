<%@page import="java.net.URLEncoder"%>
<%@page import="bean.TeacherBean"%>
<%@page import="java.util.Vector"%>
<%@page import="bean.UserBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.UserMgr"/>
<jsp:useBean id="tmgr" class="mgr.TeacherMgr"/>
<jsp:useBean id="mmgr" class="mgr.MessageMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
		int userNum=0;
		UserBean bean=new UserBean();
		int currentMsg=0;
		int userLastMessage=0;
		if(session.getAttribute("userNum")!=null){
			userNum=(Integer)session.getAttribute("userNum");
			bean=mgr.getUser(userNum);
			/* userLastMessage=bean.getUserLastMessage(); */
			currentMsg=mmgr.getCurrentMsgByFooter(userNum);
		}
		Vector<TeacherBean> todayTeachers=tmgr.todayTeachers();//랜덤으로 9명의 선생님 불러오기
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" type="text/css" href="resources/slick/slick/slick.css" />
    <link rel="stylesheet" type="text/css" href="resources/slick/slick/slick-theme.css" />
    <script src="resources/js/includeHTML.js"></script>
    <script type="text/javascript" src="resources/js/jquery-3.5.0.min.js"></script>
    <script type="text/javascript" src="resources/slick/slick/slick.js"></script>
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
        margin-top: 70px;
        font-family: "Spoqa Han Sans", "Spoqa Han Sans JP", "Sans-serif";
      }
      #mainSlider {
        width: 100%;
        height: 400px;
        border-radius: 6px;
        margin: 0;
      }
      .slideContent {
        width: 100%;
        height: 370px;
        background-size: cover;
        border-radius: 6px;
      }
      #SC1 {
        background-image:url("resources/img/e.png");
        background-size:100% 100%;
      }
      #SC2 {
        background-image:url("resources/img/b.png");
        background-size:100% 100%;
      }
      #SC3 {
        background-image:url("resources/img/h.png");
        background-size:100% 100%;
      }
      #slider-div2 {
        width: 100%;
        height: 300px;
      }
      .s2_content {
        background-color: white;
        padding: 30px 30px;
        width: 100%;
        height: 400px;
      }
      .s2_item {
        border-radius: 6px;
        width: 100%;
        height: 100%;
        border: 2px solid rgb(88, 193, 137);
        border-radius: 4px;
      }
      .s2i_img {
        width: 100%;
        height: 180px;
        border-radius: 4px 4px 0 0;
        padding: 20px;
      }
      .s2i_content {
        padding: 5px 20px;
        font-size: 16px;
      }
      .s2i_name {
        font-weight: 400;
        font-size: 18px;
        height: 30px;
        color: #222222;
      }
      .s2i_profile {
        height: 24px;
        margin-top: 2px;
        display: flex;
        font-weight: 400;
      }
      .s2i_svg {
        width: 24px;
        height: 24px;
      }
      .s2i_desc {
        font-size: 16px;
        color: #666666;
        overflow:hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
      }
      #mainReviews {
        width: 100%;
        height: 400px;
      }
      .reviewflex {
        display: flex;
        width: 100%;
        height: 200px;
      }
      .review {
        border-radius: 6px;
        width: 50%;
        height: 200px;
        padding: 15px;
      }
      .reviews {
        width: 100%;
        height: 100%;
        background-color: white;
        display: flex;
        border-radius: 6px;
        box-shadow: 3px 3px 4px #cccccc;
        border:1px solid #EEEEEE;
      }
      .reviewImg {
        width: 170px;
        height: 170px;
        padding: 20px;
      }
      .reviewDescWrap {
        width: 100%;
        height: 100%;
        padding: 20px 0;
        padding-right: 20px;
      }
      .reviewDesc {
        width: 100%;
        height: 100%;
      }
      .rdTitle {
        width: 100%;
        height: 40px;
        font-size: 20px;
        font-weight: 800;
        padding-top: 3px;
      }
      .rdContent {
        width: 100%;
        height: 88px;
        font-size: 14px;
        font-weight: 400;
        word-break: break-all;
      }
      .mainTitles {
        font-size: 22px;
        font-weight: 800;
        color: #666666;
        margin-top: 20px;
        text-align: center;
      }
      #graphImg {
        background-image: url("img/graph.jpg");
        background-size: cover;
        width: 100%;
        height: 800px;
      }
      .startdiv {
        text-align: center;
        height: 140px;
        margin-top: 30px;
      }
      .startbutton {
        padding: 0.75em 2em;
        text-align: center;
        text-decoration: none;
        color: rgb(88, 193, 137);
        border: 2px solid rgb(88, 193, 137);
        font-size: 24px;
        display: inline-block;
        border-radius: 0.3em;
        -webkit-transition: all 0.2s ease-in-out;
        transition: all 0.2s ease-in-out;
        position: relative;
        overflow: hidden;
      }
      .startbutton:before {
        content: "";
        background-color: rgba(255, 255, 255, 0.5);
        height: 100%;
        width: 3em;
        display: block;
        position: absolute;
        top: 0;
        left: -4.5em;
        -webkit-transform: skewX(-45deg) translateX(0);
        transform: skewX(-45deg) translateX(0);
        -webkit-transition: none;
        transition: none;
      }

      .startbutton:hover {
        background-color: rgb(88, 193, 137);
        color: #fff;
        border-bottom: 4px solid rgb(58, 163, 107);
      }

      .startbutton:hover:before {
        -webkit-transform: skewX(-45deg) translateX(13.5em);
        transform: skewX(-45deg) translateX(13.5em);
        -webkit-transition: all 0.5s ease-in-out;
        transition: all 0.5s ease-in-out;
      }
      #chart1_div{
      	margin-top: 100px;
      }
      #chart_div{
     	margin-top: 100px;
      }
     #chartflex{
     	 display: flex;
     }
     #chartDiv{
     	padding:0 15%;
     }
     #chartComment{
      	 border: 1px solid rgb(88, 193, 137);
	     border-radius: 4px;
	     width: 100%;
	     height:60px;
	     display:flex;
	     padding:0 10%;
	     justify-content:space-between;
     }
     .ccDiv{
     	display:flex;
     }
     .ccImg{
     	padding-top:20px;
     }
     .ccText{
     	padding-top:17px;
     	font-size:18px;
     	font-weight:400;
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
    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
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
<%-- 	var usm=<%=userLastMessage%>
	if(recentNum!=usm){
		goFlash=setInterval(flashChat(), 1000);
	} --%> //버그로 인해 사용불가.
	
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
	//openChatting, alreadyStudent, alreadyTeacher는 헤더와  푸터를 쓰는 모든 화면에 들어감.
    </script>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">
  google.load('visualization', '1.0', {'packages':['corechart']});
	google.setOnLoadCallback(drawChart);
  function drawChart() {
         var data = google.visualization.arrayToDataTable([
           ['Categegories', '学生' , '先生'  ],
           ['2018', 140,     140      ],
           ['2019', 210,  324   ],
           ['2020', 324,  532],
         ]);
         var options = {
           title: '新規登録グラフ',
           titleTextStyle: {
               fontSize: 20,
             },
           pointSize: 8,
           'width': 550,
           'height': 450,
           vAxis: {minValue:0, maxValue:100,gridlines:{count:10}},
         };
         var chart = new google.visualization.LineChart(document.getElementById('chart_div'));
         chart.draw(data, options);
       }
</script>
    <script type="text/javascript">
	// 어떤 그래프를 사용할지 지정 : Google Visualization 라이브러리 로드
	google.load('visualization', '1.0', {'packages':['corechart' ]});
	// 그래프 API 로드가 완료되면 실행할 수 있도록 이벤트 지정
	google.setOnLoadCallback(drawChart);
	function drawChart() {
		var data = new google.visualization.DataTable();
		data.addColumn('string', '科目');
		data.addColumn('number', '割合');
		data.addRows([
				['国語', 10],
				['数学', 24],
				['英語', 19],
				['理科', 13],
				['社会', 12],
				['外国語', 14],
				['専門資格', 10],
				['IT', 8]
		]);
		// 그래프의 옵션을 지정
		var opt = {
					  width: 500,
					  height: 450,
					  title: '担当科目の割合',
// 					  pieSliceText: 'label',
					is3D:true,
					  titleTextStyle: {  fontSize: 20 },
			 colors: ['rgb(240, 136, 136)', 'rgb(34, 212, 188)', 'rgb(184, 181, 18)', 
				 'rgb(76, 212, 34)', 'rgb(38, 131, 238)','rgb(139, 34, 224)','rgb(231, 40, 151)','rgb(194, 173, 173)']
		};
		var chart = new google.visualization.PieChart(
				document.getElementById('chart1_div'));
		chart.draw(data, opt);
	}
</script>
  </head>
  <body>
    <header include-html="J_header.jsp"></header>
    <div id="contentWrap">
      <div id="mainSlider">
        <div id="slider-div">
        <%if(userNum!=0){//세션이 존재할때 %>
        	<%if(mgr.isStudent(userNum)){//학생등록이 되어있을때 %>
        	<a href="javascript:alreadyStudent()"><div class="slideContent" id="SC1"></div></a>
        	<%}else{//세션이 존재하고 학생등록이 되어있지 않을때 %>
        	<a href="noservice_J.jsp"><div class="slideContent" id="SC1"></div></a>
        	<%} %>
        <%}else{//세션이 존재하지 않을때 %>
        <a href="noservice_J.jsp"><div class="slideContent" id="SC1"></div></a>
        <%} %>
         <%if(userNum!=0){ %>
        	<%if(mgr.isTeacher(userNum)){ %>
        	<a href="javascript:alreadyTeacher()"><div class="slideContent" id="SC2"></div></a>
        	<%}else{ %>
        	<a href="noservice_J.jsp"><div class="slideContent" id="SC2"></div></a>
        	<%} %>
        <%}else{ %>
        <a href="noservice_J.jsp"><div class="slideContent" id="SC2"></div></a>
        <%} %>
          <a href="javascript:openChatting('<%=userNum%>')"><div class="slideContent" id="SC3"></div></a>
        </div>
      </div>
      <div class="mainTitles">-　学生のコメント -</div>
      <div id="mainReviews">
        <div class="reviewflex">
          <div class="review">
            <div class="reviews">
              <div class="reviewImg">
                <img src="resources/img/exam1.png" style="border:1px solid #cccccc;" width="130px" height="130px" />
              </div>
              <div class="reviewDescWrap">
                <div class="reviewDesc">
                  <div class="rdTitle">テスト平均点が20点上がりました。</div>
                  <div class="rdContent">
					数学の成績がどうしても上がらなくて、3ヶ月間数学家の庭教師と勉強をしました。
					数学はもちろん、他の科目でもいい勉強方法を身に付けて、平均点が20点上がりました。
					<br>
                    -名古屋高校　2年生
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="review">
            <div class="reviews">
              <div class="reviewImg">
                <img src="resources/img/exam2.png" style="border:1px solid #cccccc;" width="130px" height="130px" />
              </div>
              <div class="reviewDescWrap">
                <div class="reviewDesc">
                  <div class="rdTitle">2ヶ月でTOEIC900点</div>
                  <div class="rdContent">
					ひとりで勉強しても700点が最高得点でした。
					このサイトで先生を見つけてTOEICの勉強しました。
					2ヶ月で200点が上がって、目標としていた点数を達成しました。<br>
                    -大阪大学　4年生
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="reviewflex">
          <div class="review">
            <div class="reviews">
              <div class="reviewImg">
                <img src="resources/img/exam3.png" style="border:1px solid #cccccc;" width="130px" height="130px" />
              </div>
              <div class="reviewDescWrap">
                <div class="reviewDesc">
                  <div class="rdTitle">友達のような先生</div>
                  <div class="rdContent">
                    	先生と家が近いのでたまに喫茶店でコーヒも
                    	飲みながら相談にのってもらっています。<br>
                    	ありがとうございます。<br><br>
                    -東京中学校　1年生
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="review">
            <div class="reviews">
              <div class="reviewImg">
                <img src="resources/img/exam4.png" style="border:1px solid #cccccc;" width="130px" height="130px" />
              </div>
              <div class="reviewDescWrap">
                <div class="reviewDesc">
                  <div class="rdTitle">javaのコデインが楽しいです</div>
                  <div class="rdContent">
                  	娘がマインクラフトのプラグインを開発するのに興味を持ち、
                  	javaでコデインする方法も学んでいます。
                  	娘もとても喜んでいますし、お世話になっています。<br>
                  	-福岡県福岡市のお父さん
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="mainTitles">- 今日のおすすめ教師 -</div>
      <div id="slider-div2">
      	<%for(int i=0; i<todayTeachers.size();i++){
      		TeacherBean teacher=todayTeachers.get(i);//랜덤한 9명의 선생님을 불러오는 메서드
      		UserBean tInfo=mgr.getUser(teacher.getUserNum());
      		String range="";
      		switch(teacher.gettRange()){
      		case 1:
      			range="小学生";
      			break;
      		case 2:
      			range="中学生";
      			break;
      		case 3:
      			range="高校生";
      			break;
      		case 4:
      			range="大学生";
      			break;
      		case 5:
      			range="社会人";
      			break;
      		case 6:
      			range="指定なし";
      			break;
      		}
      		String area=teacher.gettArea1().substring(0,2);//ex)부산부산진구로 데이터가 들어간 경우 부산만 가져오기 위함.
      		%>
      	<div class="s2_content">
          <a href="noservice_J.jsp">
            <div class="s2_item">
              <div class="s2i_img">
                <img src="resources/img/<%=URLEncoder.encode(teacher.gettImage(), "EUC-KR") %>" width="262px" height="160px" />
              </div>
              <div class="s2i_content">
                <%if(userNum==0){ %>
                <div class="s2i_name"><%=teacher.gettNickname()%></div>
                <%}else{ %>
                <div class="s2i_name"><%=tInfo.getUserName()%></div>
                <%} %>
                <div class="s2i_profile">
                  <div class="s2i_svg">
                    <img src="resources/img/study.png" width="24px" />
                  </div>
                  <div class="s2i_desc">学歴|<%=teacher.gettRecord()%></div>
                </div>
                <div class="s2i_profile">
                  <div class="s2i_svg">
                    <img src="resources/img/class.png" width="24px" />
                  </div>
                  <div class="s2i_desc">科目|<%=teacher.gettSubject1()%> 등</div>
                </div>
                <div class="s2i_profile">
                  <div class="s2i_svg">
                    <img src="resources/img/range.png" width="24px" />
                  </div>
                  <div class="s2i_desc">教える相手|<%=range%></div>
                </div>
                <div class="s2i_profile">
                  <div class="s2i_svg">
                    <img src="resources/img/location.png" width="24px" />
                  </div>
                  <div class="s2i_desc">地域|<%=area%></div>
                </div>
              </div>
            </div>
          </a>
        </div>
      	<%} %>
      </div>
      <div id ="chartflex">
      	<div id="chart1_div"></div>
      	<div id="chart_div"></div>
      </div>
      <div id="chartDiv">
      	<div id="chartComment">
	      	<div class="ccDiv">
		      	<div class="ccImg"><img src="resources/img/teacher.svg" style="margin-right: 10px;"/></div>
		      	<div class="ccText">新規登録先生 : 毎年150人以上 </div>
	      	</div>
	      	<div class="ccDiv">
	      		<div class="ccImg"><img src="resources/img/student.svg" style="margin-right: 10px;"/></div>
	      		<div class="ccText">新規登録学生: 毎年50人以上</div>
	      	</div>
      	</div>
      </div>
      <div class="startdiv">
        <%if(userNum!=0){ %>
        <a href="noservice_J.jsp" class="startbutton">利用開始</a>
        <%}else{ %>
        <a href="noservice_J.jsp" class="startbutton">利用開始</a>
        <%} %>
      </div>
    </div>
	<div include-html="footer.jsp"></div>
	<footer include-html="footer1.jsp"></footer>
    <script>
      includeHTML();
      $(function () {
        $("#slider-div").slick({
          slide: "div", //슬라이드 되어야 할 태그 ex) div, li
          infinite: true, //무한 반복 옵션
          slidesToShow: 1, // 한 화면에 보여질 컨텐츠 개수
          slidesToScroll: 1, //스크롤 한번에 움직일 컨텐츠 개수
          speed: 500, // 다음 버튼 누르고 다음 화면 뜨는데까지 걸리는 시간(ms)
          arrows: false, // 옆으로 이동하는 화살표 표시 여부
          dots: true, // 스크롤바 아래 점으로 페이지네이션 여부
          autoplay: true, // 자동 스크롤 사용 여부
          autoplaySpeed: 5000, // 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
          pauseOnHover: true, // 슬라이드 이동	시 마우스 호버하면 슬라이더 멈추게 설정
          vertical: false, // 세로 방향 슬라이드 옵션
          prevArrow:
            "<button type='button' class='slick-prev'>Previous</button>", // 이전 화살표 모양 설정
          nextArrow: "<button type='button' class='slick-next'>Next</button>", // 다음 화살표 모양 설정
          dotsClass: "slick-dots", //아래 나오는 페이지네이션(점) css class 지정
          draggable: true, //드래그 가능 여부
          fade: true,
          cssEase: "linear",
        });
        $("#slider-div2").slick({
          slide: "div",
          slidesToShow: 3,
          slidesToScroll: 1,
          autoplay: true, // 자동 스크롤 사용 여부
          autoplaySpeed: 2000, // 자동 스크롤 시 다음으로 넘어가는데 걸리는 시간 (ms)
          arrows: true,
        });
      });
    </script>
  </body>
</html>
