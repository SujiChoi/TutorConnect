<%@page import="bean.UserBean"%>
<%@page import="bean.TeacherBean"%>
<%@page import="bean.SubjectBean"%>
<%@page import="mgr.UtilMgr"%>
<%@page import="bean.AreaBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
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
	String loc="contentWrap";
	//세션값의 유저넘버

		
	String area = "서울";
	if(request.getParameter("area")!=null){
		area = request.getParameter("area");
	}
	Vector<AreaBean> vlist;
	Vector<SubjectBean> vlistsub;
	
	if(request.getParameter("loc")!=null){
		loc = request.getParameter("loc");
	}
	


 	int totalRecord = 0;//총게시물수
 	int numPerPage = 10;//페이지당 레코드 개수(5,10,15,30)
 	int pagePerBlock = 5;//블럭당 페이지 개수
 	int totalPage = 0;//총 페이지 개수
 	int totalBlock = 0;//총 블럭 개수
 	int nowPage = 1;//현재 페이지
 	int nowBlock = 1;//현재 블럭
 	
 	//검색에 필요한 변수
 	String keyWord = ""; 

%>
<jsp:useBean id="tMgr" class="mgr.TsearchMgr"/>
<jsp:useBean id="tmgr" class="mgr.TeacherListMgr"/>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script type="text/javascript">  
    
    //페이징 처리 시작
      function listin() {

  		document.listFrm.action = "Tsearch.jsp?loc=tlist";
  		document.listFrm.submit();

      }
      function check() {
			if(document.searchFrm.keyWord.value==""){
				alert("검색어를 입력하세요.");
				document.searchFrm.keyWord.focus();
				return;
			}
			document.searchFrm.submit();
		}
      function pageing(page) {
			document.readFrm.nowPage.value = page;
			document.readFrm.submit();
		}
      function block(block) {
			document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
			document.readFrm.submit();
		}
      function reset(){
    	  
    	  
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
    //페이징 처리 끝
    </script>
    <script src="resources/js/includeHTML.js"></script>
    <script src="resources/js/area.js"></script>
    <script src="resources/js/subject.js"></script>
    <script src="resources/js/others.js"></script>
    <script type="text/javascript" src="resources/js/jquery-3.5.0.min.js"></script>
    <link href="resources/css/Tsearch.css" rel="stylesheet"/>
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
		border: 1px solid grey;
		background-color: white;
		height: 712px;
	}
	td {
		font-size: 15px;
	}
	.MemberButton {
        cursor: pointer;
        font-size:15px;
        background-color: rgb(88, 193, 137);
        width: 80px;
        height:40px;
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: 800;
 }
	/*유진이 css*/ 
      div.nickShearch {
        background-color: rgb(224, 224, 224);
        padding: 0.5vw;
        padding-top: 0.05vw;
      }
      p.nickShearch {
        font-weight: bold;
        font-size: 17px;
      }
      input.nickShearch[type="text"] {
        width: 50vw;
        height: 1.9vw;
        border-radius: 5px;
        border-color: rgb(224, 224, 224);
      }

      /*현승씨 코드*/
       .review {
        border-radius: 6px;
        width: 50%;
        height: 180px;
        padding: 15px;
      }
      .reviews {
        width: 100%;
        height: 100%;
        display: flex;
        border-radius: 6px;
      }
      .reviewImg {
        width: 150px;
        height: 150px;
        padding: 20px;
      }
      .reviewDescWrap {
        width: 170px;
        height: 170px;
        padding: 20px 0;
        padding-right: 20px;
      }
      .reviewDesc {
        width: 100%;
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
      }.s2i_content {
        padding: 0px 10px;
        font-size: 16px;
        width: 300px;
      }
      .s2i_name {
        font-weight: 400;
        font-size: 18px;
        height: 30px;
        color: #222222;
      }
      .s2i_profile {
      	width:170px;
        height: 24px;
        display: flex;
        font-weight: 400;
      }
      .s2i_svg {
        width: 24px;
        height: 24px;
      }
      .s2i_desc {
      	padding-top:2px;
        font-size: 14px;
        color: #666666;
        overflow: hidden;
  		text-overflow: ellipsis;
  		white-space: nowrap;
      }
     .tag1{
     /*우수 선생님(매칭률 높음)*/
      border: 1px solid black;
      width: 72px;
      height:20px;
      padding:2px;
      border-radius: 5px;
      background-color: rgb(231, 76, 60);
      color: white;
      font-weight: bold;
      font-size: 11px;
      text-align: center;
      border:rgb(231, 76, 60);
      margin-right:5px;
    }
     .tag2{
     /*동영상 공개*/
      border: 1px solid black;
      width: 72px;
      height:20px;
      padding:2px;
      border-radius: 5px;
      background-color: rgb(52, 152, 219);
      color: white;
      font-weight: bold;
      font-size: 11px;
      text-align: center;
      border:rgb(52, 152, 219);
      margin-right:5px;
    }
     .tag3{
     /*학생 추천 (댓글여부)*/
      border: 1px solid black;
      width: 60px;
      height:20px;
      padding:2px;
      border-radius: 5px;
      background-color: rgb(155, 89, 182);
      color: white;
      font-weight: bold;
      font-size: 11px;
      text-align: center;
      border:rgb(155, 89, 182);
      margin-right:5px;
    }
    .tag{
        display: flex;
    }
    input.keyWord {
	font-size: 15px;
	height: 30px;
	}

	input.isearch {
	background-color: rgb(88, 193, 137);
	border: 1px solid rgb(88, 193, 137);
	color: white;
	width: 4.5vw;
	height: 30px;
	border-radius: 5px;
	font-weight: bold;
	font-size: 17px;
	margin-left: 10px;
	}
	 .s2i_desc1 {
        overflow: hidden;
  		text-overflow: ellipsis;
  		white-space: nowrap;
      }
      .page a{
      color:black;
      }

      div.flex{
	display:flex;
	padding-left: 56%;
	}
	
	p.nickShearch {
	margin-top: 5px;
	margin-right: 15px;
	font-size: 15px;
	font-weight: 800;
	}      
      
      table.list {
      	border-collapse: collapse;
        border-top: solid;
        border-bottom: solid;
        border-width: 2px;
        border-color: gray;
        font-size: 14.5px;
      }
      
   a.up{
	color:darkgrey;
	}
	a.page .next{
	background-color: rgb(88, 193, 137);
	border: 1px solid rgb(88, 193, 137);
	color: white;
	border-radius: 5px;
	font-weight: bold;
	font-size: 15px;
	margin: 0px 3px;
	}
	
	.page .next{
	background-color: rgb(88, 193, 137);
	border: 1px solid rgb(88, 193, 137);
	color: white;
	border-radius: 5px;
	font-weight: bold;
	font-size: 15px;
	margin: 0px 3px;

}

    </style>
    <script type="text/javascript">
    function value_check(city) {
    	f = document.frm;
    	
    	f.btn.value = "";

        var check_count = document.getElementsByName("area").length;
        
        for (var i=0; i<check_count; i++) {
            if (document.getElementsByName("area")[i].checked == true) {
            	f.btn.value+=document.getElementsByName("area")[i].value+",";
            }
        }
        var a = f.btn.value;
        f.btn.value = a.substr(0,a.length-1);
    }
    function value_check2() {
    	f = document.frm;
    	f.subjectbtn.value = "";

        var check_count = document.getElementsByName("subject").length;
        
        for (var i=0; i<check_count; i++) {
            if (document.getElementsByName("subject")[i].checked == true) {
            	f.subjectbtn.value+=document.getElementsByName("subject")[i].value+",";
            }
        }
        var a = f.subjectbtn.value;
        f.subjectbtn.value = a.substr(0,a.length-1);
    }

    
    function inputCheck(){
		form=document.frm;
		
		var a = document.getElementsByName("area").length;
		var b = document.getElementsByName("subject").length;
		var j=0;
		var k=0;
		for(i=0; i<a; i++){
			if(document.getElementsByName("area")[i].checked==true){
				j =1;
				break;
			}
		}
		if(j==0){
			alert("희망 지역을 입력해 주세요");
		}
		for(i=0; i<b; i++){
			if(document.getElementsByName("subject")[i].checked==true){
				k=1;
				break;
			}
		}
		if(k==0){
			alert("희망 과목을 입력해 주세요");
		}
		if(j!=0&&k!=0){
			form.submit();
		}
	}
    
    
    function inputCheck2(){
		form=document.frm;
		
		var a = document.getElementsByName("subject").length;

        for (var i=0; i<a; i++) {
            if (document.getElementsByName("subject")[i].checked == true) {
            	form.submit();
            	return;
            }
        }
        alert("을 선택해주세요.");
	}
    function searchStudent(){
    	location.href="Ssearch.jsp";
    }
    </script>
  </head>
  <body>
    <header include-html="header.jsp"></header>
    <div id="contentWrap">
        <h2>선생님 찾기</h2>
    	<div id='searchv' class="search">
    	<div id ='area' class="area" >
  <form action="Tsearch.jsp" name="frm">
    	<!-- 지역 검색창 시작 -->
    		<table>
    		    <tr>
    				<td class="tdcitytitle"><h3>지역</h3></td>
    				<td colspan="8"><input name="btn" size="130" style="border-radius: 5px;" readonly></td>
    			</tr>
    		</table>
        <!-- 지역 검색창 끝 -->
 	    <!-- 지역 시 리스트 시작 -->
    		<table class="tablecity" style="margin : 0px 15px;">
    			<tr>		
	    			<td class="tdcity" id="seoul1" value='3' onclick="findarea(seoul,seoul1);" style="background-color: rgb(88, 193, 137); color:white;">서울</td>				
	    			<td class="tdcity" id="pusan1" onclick="findarea(pusan,pusan1);">부산</td>				
	    			<td class="tdcity" id="deagu1" onclick="findarea(deagu,deagu1);">대구</td>				
	    			<td class="tdcity" id="incheon1" onclick="findarea(incheon,incheon1);">인천</td>				
	    			<td class="tdcity" id="gwangju1" onclick="findarea(gwangju,gwangju1);">광주</td>				
	    			<td class="tdcity" id="daejeon1" onclick="findarea(daejeon,daejeon1);">대전</td>				
	    			<td class="tdcity" id="ulsan1" onclick="findarea(ulsan,ulsan1);">울산</td>				
	    			<td class="tdcity" id="sejong1" onclick="findarea(sejong,sejong1);">세종</td>				
	    			<td class="tdcity" id="gyeonggi1" onclick="findarea(gyeonggi,gyeonggi1);">경기</td>				
    			</tr>
    			<tr>		
	    			<td class="tdcity" id="gangwon1" onclick="findarea(gangwon,gangwon1);">강원</td>				
	    			<td class="tdcity" id="chungb1" onclick="findarea(chungb,chungb1);">충북</td>				
	    			<td class="tdcity" id="chungn1" onclick="findarea(chungn,chungn1);">충남</td>				
	    			<td class="tdcity" id="jeollab1" onclick="findarea(jeollab,jeollab1);">전북</td>				
	    			<td class="tdcity" id="jeollan1" onclick="findarea(jeollan,jeollan1);">전남</td>				
	    			<td class="tdcity" id="gyeongb1" onclick="findarea(gyeongb,gyeongb1);">경북</td>				
	    			<td class="tdcity" id="gyeongn1" onclick="findarea(gyeongn,gyeongn1);">경남</td>				
	    			<td class="tdcity" id="jeju1" onclick="findarea(jeju,jeju1);">제주</td>				
	    			<td class="tdcity" id="abroad1" onclick="findarea(abroad,abroad1);">해외</td>	
  			</tr>    			
    		</table>
<!-- 지역 시 리스트 끝 -->
<!-- 지역 구 리스트 시작 (서울) -->
 	    <div id="seoul" style="display:block;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("서울");
									
									int no = vlist.size();
									int div = (int)Math.ceil((double)no/11);
									int j = 0;
									int start = 0;
									int end = 0;
									int startcity = 0;
									if(no <=11){
										start = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('서울')" name="area" value="<%="서울"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div><!-- 서울 -->
    		
  <!-- 지역 구 리스트 시작 (부산) -->
 	    <div id="pusan" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
					vlist = tMgr.TsearchArea("부산");
									
									no = vlist.size();
									div = (int)Math.ceil((double)no/11);
									j = 0;
									startcity = 0;
									end = 11;
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('부산')" name="area" value="<%="부산"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){//부산
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}
	    					    				%>
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div><!-- 부산 -->
  <!-- 지역 구 리스트 시작 (대구) -->
 	    <div id="deagu" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
					vlist = tMgr.TsearchArea("대구");
									
									no = vlist.size();
									div = (int)Math.ceil((double)no/11);
									j = 0;
									startcity = 0;
									end = no;
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('대구')" name="area" value="<%="대구"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>				
	    				<%
					    					}//for
					    				%>
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div><!-- 대구 -->
<!-- 지역 구 리스트 시작 (인천) -->
 	    <div id="incheon" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
					vlist = tMgr.TsearchArea("인천");
									
									no = vlist.size();
									div = (int)Math.ceil((double)no/11);
									j = 0;
									startcity = 0;
									end = 11;
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('인천')" name="area" value="<%="인천"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>				
	    				<%
					    					}//for
	    					if(j==11&div==2){//부산
	    						startcity = 11;
	    						end = no;
	    					}
					    				%>
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div><!-- 인천 -->
<!-- 지역 구 리스트 시작 (광주) -->
 	    <div id="gwangju" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
					vlist = tMgr.TsearchArea("광주");
									
									no = vlist.size();
									div = (int)Math.ceil((double)no/11);
									j = 0;
									startcity = 0;
									end = no;
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('광주')" name="area" value="<%="광주"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>				
	    				<%
					    					}//for
					    				%>
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div><!-- 광주 -->
<!-- 지역 구 리스트 시작 (대전) -->
 	    <div id="daejeon" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
					vlist = tMgr.TsearchArea("대전");
									
									no = vlist.size();
									div = (int)Math.ceil((double)no/11);
									j = 0;
									startcity = 0;
									end = no;
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('대전')" name="area" value="<%="대전"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>				
	    				<%
					    					}//for
					    				%>
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    	</div><!-- 대전 -->    			
<!-- 지역 구 리스트 시작 (울산) -->
 	    <div id="ulsan" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
					vlist = tMgr.TsearchArea("울산");
									
									no = vlist.size();
									div = (int)Math.ceil((double)no/11);
									j = 0;
									startcity = 0;
									end = no;
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('울산')" name="area" value="<%="울산"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>				
	    				<%
					    					}//for
					    				%>
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div><!-- 울산 -->
<!-- 지역 구 리스트 시작 (세종) -->
 	    <div id="sejong" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
					vlist = tMgr.TsearchArea("세종");
									
									no = vlist.size();
									div = (int)Math.ceil((double)no/11);
									j = 0;
									startcity = 0;
									end = no;
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('세종')" name="area" value="<%="세종"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>				
	    				<%
					    					}//for
					    				%>
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 세종 끝 -->    			
<!-- 지역 구 리스트 시작 (경기) -->
 	    <div id="gyeonggi" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("경기");
									
									no = vlist.size();
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j);
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('경기')" name="area" value="<%="경기"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 경기 -->    			
<!-- 지역 구 리스트 시작 (강원) -->
 	    <div id="gangwon" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("강원");
									
									no = vlist.size(); //vlist
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j); //vlist
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('강원')" name="area" value="<%="강원"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 강원 끝 -->
<!-- 지역 구 리스트 시작 (충북) -->
 	    <div id="chungb" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("충북");
									
									no = vlist.size(); //vlist
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j); //vlist
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('충북')" name="area" value="<%="충북"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 충북 끝 -->
<!-- 지역 구 리스트 시작 (충남) -->
 	    <div id="chungn" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("충남");
									
									no = vlist.size(); //vlist
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j); //vlist
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('충남')" name="area" value="<%="충남"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 충남 끝 -->
<!-- 지역 구 리스트 시작 (전북) -->
 	    <div id="jeollab" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("전북");
									
									no = vlist.size(); //vlist
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j); //vlist
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('전북')" name="area" value="<%="전북"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 전북 끝 -->
<!-- 지역 구 리스트 시작 (전남) -->
 	    <div id="jeollan" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("전남");
									
									no = vlist.size(); //vlist
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j); //vlist
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('전남')" name="area" value="<%="전남"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 전남 끝 -->
<!-- 지역 구 리스트 시작 (경북) -->
 	    <div id="gyeongb" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("경북");
									
									no = vlist.size(); //vlist
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j); //vlist
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('경북')" name="area" value="<%="경북"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 경북 끝 -->
<!-- 지역 구 리스트 시작 (경남) -->
 	    <div id="gyeongn" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("경남");
									
									no = vlist.size(); //vlist
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j); //vlist
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('경남')" name="area" value="<%="경남"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<%
	    					    					}//for
	    					    					    					if(j==11&div==2){
	    					    					    						startcity = 11;
	    					    					    						end = no;
	    					    					    					}else if(j==11&div==3){
	    					    					    						startcity = 11;
	    					    					    						end =22;
	    					    					    					}else if(j==22&div==3){
	    					    					    						startcity = 22;
	    					    					    						end =no;
	    					    					    					}
	    					    				%>
	
						</tr>	
	    			<%
		    				}//for
		    			%>
    				</table>
    				<br>
    			</div>
<!-- 경남 끝 -->
<!-- 지역 구 리스트 시작 (제주) -->
 	    <div id="jeju" style="display:none;">
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px">
				<%
					vlist = tMgr.TsearchArea("제주");
									
									no = vlist.size(); //vlist
									div = (int)Math.ceil((double)no/11);
									j = 0;
									end = 0;
									startcity = 0;
									if(no <=11){
										startcity = 0;
										end = no;
									}
									else if(no >11){
										startcity = 0;
										end =11;
									}
									
									for(int i=0;i<div;i++){
				%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
													AreaBean abean = vlist.get(j); //vlist
							%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check('제주')" name="area" value="<%="제주"+abean.getStreet()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getStreet()%></td>
	    				
	    				<% }//for
	    					if(j==11&div==2){
	    						startcity = 11;
	    						end = no;
	    					}else if(j==11&div==3){
	    						startcity = 11;
	    						end =22;
	    					}else if(j==22&div==3){
	    						startcity = 22;
	    						end =no;
	    					}%>
	
						</tr>	
	    			<%}//for %>
    				</table>
    				<br>
    			</div>
<!-- 제주 끝 -->
<!-- 지역 구 리스트 시작 (해외) -->
 	    <div id="abroad" style="display:none;">
 	        		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px"> 	    	
 	    				<td style="background-color: white;width: 1100px;">
 	    					<h1 style="text-align: center;"><span style="color:rgb(88, 193, 137);">오픈준비중</span><span style="color:rgb(230, 230, 230);">입니다.</span></h1>
    					</td>
    				</table>
    		<br>
    	</div>
<!-- 해외 끝 -->
	   			 			
    		</div><!-- area -->	
 	    <!-- 지역 구 리스트 끝 -->
 	    
<!-- 과목 시작-->
    <div id="sub" class="area" style="background-color: rgb(224, 224, 224);width: 500px;float: left; margin-right:0px; margin-top:0px;">
    			<table>
    		    <tr>
    				<td class="tdcitytitle"><h3>희망과목</h3></td>
    				<td><input size="50" name="subjectbtn" style="border-radius: 5px;" value="" readonly></td>
    			</tr>
    		</table>
    		<table class="tablecity" style="margin : 0px 15px;">
    			<tr>
 		   			<td class="tdcity" id="math1"  onclick="findsubject(math,math1);" style="background-color: rgb(88, 193, 137); color:white;">수학</td>				
	    			<td class="tdcity" id="english1" onclick="findsubject(english,english1);">영어</td>				
	    			<td class="tdcity" id="korean1" onclick="findsubject(korean,korean1);">국어</td>				
    				<td class="tdcity" id="science1" onclick="findsubject(science,science1);" >과학</td>					
    			</tr>
    			<tr>
 		   			<td class="tdcity" id="society1" onclick="findsubject(society,society1);">사회</td>				
	    			<td class="tdcity" id="test1" onclick="findsubject(test,test1);">공인인증</td>				
	    			<td class="tdcity" id="foreign1" onclick="findsubject(foreign,foreign1);">제2외국어</td>				
    				<td class="tdcity" id="it1" onclick="findsubject(it,it1);">IT/컴퓨터</td>					
    			</tr>
    		</table>
<!-- 수학 시작 -->
   	<div id="math" style="display:block;">				
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
							vlistsub= tMgr.Tsearchsub("수학");
							
							no = vlistsub.size(); //vlist
							div = (int)Math.ceil((double)no/3);
							j = 0;
							startcity = 0;
							end = 3;
							for(int i=0;i<div;i++){
							%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
								SubjectBean abean = vlistsub.get(j); //vlist
	    					%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check2()" name="subject" value="<%=abean.getMinor()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getMinor()%></td>
	    				
	    				<% }//for
	    					if(j==3&div==2){
	    						startcity = 3;
	    						end = no;
	    					}
	    					%>
						</tr>	
	    			<%}//for %>
    				</table>
 				<br>   				
    </div>
<!-- 수학 끝 -->
<!-- 영어 시작 -->
   	<div id="english" style="display:none;">				
    				<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
							vlistsub= tMgr.Tsearchsub("영어");
							
							no = vlistsub.size(); //vlist
							div = (int)Math.ceil((double)no/3);
							j = 0;
							startcity = 0;
							end = 3;
							for(int i=0;i<div;i++){
							%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
								SubjectBean abean = vlistsub.get(j); //vlist
	    					%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check2()" name="subject" value="<%=abean.getMinor()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getMinor()%></td>
	    				
	    				<% }//for
	    					if(j==3&div==2){
	    						startcity = 3;
	    						end = no;
	    					}%>
						</tr>	
	    			<%}//for %>
    				</table>
    				<br>
    	</div>
 <!-- 영어 끝 -->
 <!-- 국어 시작 -->
   	<div id="korean" style="display:none;">				
    				<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
							vlistsub= tMgr.Tsearchsub("국어");
							
							no = vlistsub.size(); //vlist
							div = (int)Math.ceil((double)no/3);
							j = 0;
							startcity = 0;
							end = 3;
							for(int i=0;i<div;i++){
							%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
									SubjectBean abean = vlistsub.get(j); //vlist
	    					%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check2()" name="subject" value="<%=abean.getMinor()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getMinor()%></td>
	    				
	    				<% }//for
	    					if(j==3&div==2){
	    						startcity = 3;
	    						end = no;
	    					}%>
						</tr>	
	    			<%}//for %>
    				</table>
    				<br>
    	</div>
 <!-- 국어 끝 -->
 <!-- 과학 시작 -->
   	<div id="science" style="display:none;">				
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
							vlistsub= tMgr.Tsearchsub("과학");
							
							no = vlistsub.size(); //vlist
							div = (int)Math.ceil((double)no/3);
							j = 0;
							startcity = 0;
							end = 3;
							for(int i=0;i<div;i++){
							%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
									SubjectBean abean = vlistsub.get(j); //vlist
	    					%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check2()" name="subject" value="<%=abean.getMinor()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getMinor()%></td>
	    				
	    				<% }//for
	    					if(j==3&div==4){
	    						startcity = 3;
	    						end = 6;
	    					}else if(j==6&div==4){
	    						startcity = 6;
	    						end = 9;
	    					}else if(j==9&div==4){
	    						startcity = 9;
	    						end = no;
	    					}%>
						</tr>	
	    			<%}//for %>
    				</table>
 				<br>   				
    </div>
<!-- 과학 끝 -->
 <!-- 사회 시작 -->
  <div id="society" style="display:none;">				
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
							vlistsub= tMgr.Tsearchsub("사회");
							
							no = vlistsub.size(); //vlist
							div = (int)Math.ceil((double)no/3);
							j = 0;
							startcity = 0;
							end = 3;
							for(int i=0;i<div;i++){
							%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
									SubjectBean abean = vlistsub.get(j); //vlist
	    					%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check2()" name="subject" value="<%=abean.getMinor()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getMinor()%></td>
	    				
	    				<% }//for
	    					if(j==3&div==5){
	    						startcity = 3;
	    						end = 6;
	    					}else if(j==6&div==5){
	    						startcity = 6;
	    						end = 9;
	    					}else if(j==9&div==5){
	    						startcity = 9;
	    						end = 12;
	    					}else if(j==12&div==5){
	    						startcity = 12;
	    						end = no;
	    					}%>
						</tr>	
	    			<%}//for %>
    				</table>
 				<br>   				
    </div>
<!-- 사회 끝 -->
<!-- 시험 시작 -->
  <div id="test" style="display:none;">				
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
							vlistsub= tMgr.Tsearchsub("공인인증외국어");
							
							no = vlistsub.size(); //vlist
							div = (int)Math.ceil((double)no/3);
							j = 0;
							startcity = 0;
							end = 3;
							for(int i=0;i<div;i++){
							%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
									SubjectBean abean = vlistsub.get(j); //vlist
	    					%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check2()" name="subject" value="<%=abean.getMinor()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getMinor()%></td>
	    				
	    				<% }//for
	    					if(j==3&div==4){
	    						startcity = 3;
	    						end = 6;
	    					}else if(j==6&div==4){
	    						startcity = 6;
	    						end = 9;
	    					}else if(j==9&div==4){
	    						startcity = 9;
	    						end = no;
	    					}%>
						</tr>	
	    			<%}//for %>
    				</table>
 				<br>   				
    </div>
<!-- 시험 끝 -->
<!-- 시험 시작 -->
  <div id="foreign" style="display:none;">				
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
							vlistsub= tMgr.Tsearchsub("제2외국어");
							
							no = vlistsub.size(); //vlist
							div = (int)Math.ceil((double)no/3);
							j = 0;
							startcity = 0;
							end = 3;
							for(int i=0;i<div;i++){
							%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
									SubjectBean abean = vlistsub.get(j); //vlist
	    					%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check2()" name="subject" value="<%=abean.getMinor()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getMinor()%></td>
	    				
	    				<% }//for
	    					if(j==3&div==3){
	    						startcity = 3;
	    						end = 6;
	    					}else if(j==6&div==3){
	    						startcity = 6;
	    						end = no;
	    					}%>
						</tr>	
	    			<%}//for %>
    				</table>
 				<br>   				
    </div>
<!-- 시험 끝 -->
<!-- 시험 시작 -->
  <div id="it" style="display:none;">				
    		<table class="tablecity" style="background-color:white;border-collapse:collapse;margin : 0px 15px;display:block;padding-bottom: 0px;">
				<%
							vlistsub= tMgr.Tsearchsub("IT/컴퓨터");
							
							no = vlistsub.size(); //vlist
							div = (int)Math.ceil((double)no/3);
							j = 0;
							startcity = 0;
							end = 3;
							for(int i=0;i<div;i++){
							%>
								<tr>
							<%
								for(j = startcity;j<end;j++){ 
									SubjectBean abean = vlistsub.get(j); //vlist
	    					%>
	    				<td style="background-color: white;"><input type="checkbox" onclick="value_check2()" name="subject" value="<%=abean.getMinor()%>"/></td>
	    				<td class="tdcity" style="text-align: left;"><%=abean.getMinor()%></td>
	    				
	    				<% }//for
	    					if(j==3&div==3){
	    						startcity = 3;
	    						end = 6;
	    					}else if(j==6&div==3){
	    						startcity = 6;
	    						end = no;
	    					}%>
						</tr>	
	    			<%}//for %>
    				</table>
 				<br>   				
    </div>
<!-- 시험 끝 -->
	<div style="background-color: white;height: 10px;">
	<br> &nbsp;
	</div>

<!-- 희망횟수 시작-->			
	    <div class="tday" style="float : left;margin:0px;">
    			<table>
    		    <tr>
    				<td class="tdcitytitle"><h3>희망횟수</h3></td>
    				<td colspan="8"><input size="50" name='dbtn' style="border-radius: 5px;"value="협의" readonly></td>
    			</tr>
    		</table>
    		<table class="tablecity" style="margin : 0px 15px;">
    			<tr>
 		   			<td class="tdcity" id='ju2' onclick="tday('ju2');">주2회</td>				
 		   			<td class="tdcity" id='ju3' onclick="tday('ju3');">주3회</td>
 		   			<td class="tdcity" id='ju5' onclick="tday('ju5');">주5회</td>				
 		   			<td class="tdcity" id='jua' onclick="tday('jua');" style="background-color: rgb(88, 193, 137); color:white;">협의</td>				 		   						
				</tr>
    		</table>
		</div>
<!-- 희망횟수 끝-->

	<div style="background-color: white;height: 103px;">
	<br> &nbsp;
	</div>
	
<!-- 성별 시작-->			
		<div class="tGender" style="float : left;margin:0px;">
     			<table>
    		    <tr>
    				<td class="tdcitytitle"><h3>성별</h3></td>
    				<td colspan="8"><input size="50" name='gbtn'  style="border-radius: 5px;" value="전체" readonly></td>
    			</tr>
    		</table>
    		<table class="tablecity" style="margin : 0px 15px;">
    			<tr>
 		   			<td class="tdcity" id='man' onclick="tGender('man');">남자</td>				
	    			<td class="tdcity" id='woman' onclick="tGender('woman');">여자</td>				
	    			<td class="tdcity" id='human' onclick="tGender('human');" style="background-color: rgb(88, 193, 137); color:white;">전체</td>				
    			</tr>  			
    		</table>
			</div>
<!-- 성별 끝-->
</div>
		
<!-- 과외 금액 시작-->	
	<div id="tfee" class="tfee" style="float :right;">
    	 <table>
    	    <tr>
    			<td class="tdcitytitle" ><h3>과외비</h3></td>
    			<td colspan="8"><input size="50" name='fbtn' style="border-radius: 5px;" value="협의" readonly></td>
    		</tr>
    	</table>
    	<table class="tablecity" style="margin : 0px 15px;">
    		<tr>
 	   			<td class="tdcity" id='f30' onclick="tfee('f30');">30만원 이하</td>				
	   			<td class="tdcity" id='f40' onclick="tfee('f40');">40만원 이하</td>				
	   			<td class="tdcity" id='f50' onclick="tfee('f50');">50만원 이하</td>				
    		</tr>
    		<tr>		
	   			<td class="tdcity" id='f60' onclick="tfee('f60');">60만원 이하</td>				
	   			<td class="tdcity" id='f70' onclick="tfee('f70');">70만원 이하</td>				
    			<td class="tdcity" id='fa' onclick="tfee('fa');" style="background-color: rgb(88, 193, 137); color:white;">협의</td>					
   			</tr>    			
   		</table>
	</div>
<!-- 과외 금액 시작-->
<!-- 과외 시간 시작-->
	    	<div id="ttime1" class="ttime">
    			<table>
    		    <tr>
    				<td class="tdcitytitle"><h3>과외시간</h3></td>
    				<td colspan="8"><input size="50" name='tbtn' style="border-radius: 5px;"value="시간무관" readonly></td>
    			</tr>
    		</table>
    		<table class="tablecity" style="margin : 0px 15px;">
    			<tr>
 		   			<td class="tdcity" id='tmornig' onclick="ttime('tmornig');">오전</td>				
	    			<td class="tdcity" id='tafternoon' onclick="ttime('tafternoon');">오후</td>				
	    			<td class="tdcity" id='tevening' onclick="ttime('tevening');">저녁</td>
	    			<td class="tdcity" id='tall' onclick="ttime('tall');" style="background-color: rgb(88, 193, 137); color:white;">시간무관</td>			
    			</tr>  			
    		</table>
			</div>
<!-- 과외 시간 끝-->
<!-- 교습 대상 시작-->			
	    <div id="ttime2" class="ttime">
    			<table>
    		    <tr>
    				<td class="tdcitytitle"><h3>교습대상</h3></td>
    				<td colspan="8"><input size="50" name="tobj" style="border-radius: 5px;"value="전체" readonly></td>
    			</tr>
    		</table>
    		<table class="tablecity" style="margin : 0px 15px;">
    			<tr>
 		   			<td class="tdcity" id='obj1' onclick="tobj('obj1');">초등학생</td>				
	    			<td class="tdcity" id='obj2' onclick="tobj('obj2');">중학생</td>				
	    			<td class="tdcity" id='obj3' onclick="tobj('obj3');">고등학생</td>				
    			</tr>
    			<tr>		
	    			<td class="tdcity" id='obj4' onclick="tobj('obj4');">대학생</td>				
	    			<td class="tdcity" id='obj5' onclick="tobj('obj5');">성인</td>				
    				<td class="tdcity" id='obj6' onclick="tobj('obj6');" style="background-color: rgb(88, 193, 137); color:white;">전체</td>		
    			</tr>    			
    		</table>
			</div>
<!-- 교습 대상 끝-->

<!-- 연령대 시작-->			
	    <div id="tAge" class="tAge">
    			<table>
    		    <tr>
    				<td class="tdcitytitle" style="width: 150px;text-align: left;"><h3 style="text-align: left;">연령대</h3></td>
    				<td><input size="10" name="Astart" style="border-radius: 5px;text-align: center;" value="20"></td>
    				<td>세 ~</td>
    				<td><input size="10" name="Aend" style="border-radius: 5px;text-align: center;" value="80"></td>
    				<td>세</td>
    			</tr>
    		</table>
		</div>
	</div>
	<!-- search -->
<!-- 연령대 끝-->
</form>

<!-- style="display: flex; -->
	    <div style="display: flex;justify-content:flex-end;margin-top: 15px;">
		    <div>
		 			<input type="hidden" name="loc" value="tlist"/>
		     		<input class='MemberButton' type="submit" value="제출하기" onclick="inputCheck()"/>
	    	</div>
		    <div>
		     		<input style="margin-left: 450px;" type="reset" value="초기화" onclick="reset()"/>	
		    </div>
    	</div>
    	
  <!-- 버튼 끝 -->
    <!--닉네임으로 검색 Start-->
    <div class="nickShearch" style="display:none;">
      <h3 style="text-align: left;padding: 10px;">선생님 닉네임으로 검색</h3>
      	<table>
      		<tr>
	      		<td>
	      			<input class="nickShearch" type="text" value="" placeholder=" 검색할 선생님의 닉네임을 입력해주세요."/>
	      		</td>
	      		<td>
	      			<input type="submit" value="검색" class='MemberButton'/>
	      		</td>
      		</tr>
      	</table>
    </div>
     
    <!--닉네임으로 검색 End-->
    <br />
    <!--포토리스트 Start-->
<%  Vector<TeacherBean> tpvlist = tMgr.TphotoList();
			
			int grade = 0;
			TeacherBean abean;
			
			abean = tpvlist.get(0);
			
			grade = abean.gettRange();
			String tgrade = "교습대상 | ";
			if(grade==1){tgrade += "초등학생";}
			else if(grade==2){tgrade += "중학생";}
			else if(grade==3){tgrade += "고등학생";}
			else if(grade==4){tgrade += "대학생";}
			else if(grade==5){tgrade += "성인";}
			else if(grade==6){tgrade += "전체";}
			
			int teacherNum = abean.getUserNum();


%>
    <div class="photolist" style="width: 100%; height: 400px;">
	      <div style="background-color: rgb(149, 227, 187); border-color: rgb(88, 193, 137); float: left; width: 32%; margin-right: 2%; ">
		<!-- 리뷰1 시작 -->
			<a href="Tpage.jsp?userNum=<%=userNum%>&teacherNum=<%=teacherNum%>">			 				
				
			      <div class="review">
		            <div class="reviews">

		                <img src="resources/img/<%=abean.gettImage()%>" width="100%" height="100%" />
			
		                <div class="reviewDesc">
		          		
				              <div class="s2i_content">
				                <div class="s2i_name"><b><%=abean.gettNickname() %></b></div>
				    <!-- 최고선생님 이런거 붙이는곳 -->
				    			<div class="tag">
				    			<!-- 매칭률 높음 -->
            						<div class="tag1" >우수 선생님</div>
				                <!-- 동영상 등록여부 -->	
				                	<div class="tag2" style="display:none;">동영상공개</div>
				                <!-- 댓글여부 -->	
				                	<div class="tag3">학생추천</div>
				                </div>
				                
				            <!-- 학교, 전공 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/study.png" width="24px" /></div>					                  
					                  <div class="s2i_desc"><%=abean.gettRecord() %></div>
				                </div>
				                
				             <!-- 희망 과목 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/class.png" width="24px" /></div>				                		
				                	<div class="s2i_desc">
					                  <%=abean.gettSubject1()%>
					                  <%if(abean.gettSubject2()!=null){ %>
					                  <%=","+abean.gettSubject2()%>
					                  <%} %>
					                  <%if(abean.gettSubject3()!=null){ %>
					                  <%=","+abean.gettSubject3() %>
					                  <%} %></div> 			                
				                </div>
				                
				             <!-- 교습 대상 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/range.png" width="24px" /></div>
					                  <div class="s2i_desc"><%=tgrade%></div>
				                </div>
				                
				             <!-- 희망 지역 -->
				                <div class="s2i_profile">
				                  <div class="s2i_svg"><img src="resources/img/location.png" width="24px" /></div>
				                  <div class="s2i_desc"><%=abean.gettArea1()%>
				                  <%if(abean.gettArea2()!=null){ %>
					                  <%=","+abean.gettArea2()%>
					                  <%} %>
					                  <%if(abean.gettArea3()!=null){ %>
					                  <%=","+abean.gettArea3() %>
					                  <%} %></div>
				                </div>			              
				              </div>
				              <!-- s2i_content 끝 -->
		                </div>
		                <!-- reviewDesc 끝-->
		            </div>
		            <!-- reviews 끝 -->
		          </div>
		          <!-- review 끝 -->
		          </a>
		       <!-- 리뷰1 끝 -->
	      </div>
	      <%
	      
	      abean = tpvlist.get(1);
	      
			grade = abean.gettRange();
			tgrade = "교습대상 | ";
			if(grade==1){tgrade += "초등학생";}
			else if(grade==2){tgrade += "중학생";}
			else if(grade==3){tgrade += "고등학생";}
			else if(grade==4){tgrade += "대학생";}
			else if(grade==5){tgrade += "성인";}
			else if(grade==6){tgrade += "전체";}
			
			teacherNum = abean.getUserNum();

			
	      %>
	      <div style=" background-color: rgb(232, 232, 232);border-color: rgb(224, 224, 224);float: left;width: 32%;">
		<!-- 리뷰2 시작 -->
				<a href="Tpage.jsp?userNum=<%=userNum%>&teacherNum=<%=teacherNum%>">			 								
			       <div class="review">
		            <div class="reviews">

		                <img src="resources/img/<%=abean.gettImage()%>" width="100%" height="100%" />
			
		                <div class="reviewDesc">
		          		
				              <div class="s2i_content">
				                <div class="s2i_name"><b><%=abean.gettNickname()%></b></div>
				    <!-- 최고선생님 이런거 붙이는곳 -->
				    			<div class="tag">
				    			<!-- 매칭률 높음 -->
            						<div class="tag1" style="display:none;">우수 선생님</div>
				                <!-- 동영상 등록여부 -->	
				                	<div class="tag2" style="display:none;">동영상공개</div>
				                <!-- 댓글여부 -->	
				                	<div class="tag3" style="display:none;">학생추천</div>
				                </div>
				                
				            <!-- 학교, 전공 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/study.png" width="24px" /></div>					                  
					                  <div class="s2i_desc"><%=abean.gettRecord() %></div>
				                </div>
				                
				             <!-- 희망 과목 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/class.png" width="24px" /></div>				                		
				                	<div class="s2i_desc">
					                  <%=abean.gettSubject1()%>
					                  <%if(abean.gettSubject2()!=null){ %>
					                  <%=","+abean.gettSubject2()%>
					                  <%} %>
					                  <%if(abean.gettSubject3()!=null){ %>
					                  <%=","+abean.gettSubject3() %>
					                  <%} %></div> 			                
				                </div>
				                
				             <!-- 교습 대상 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/range.png" width="24px" /></div>
					                  <div class="s2i_desc"><%=tgrade%></div>
				                </div>
				                
				             <!-- 희망 지역 -->
				                <div class="s2i_profile">
				                  <div class="s2i_svg"><img src="resources/img/location.png" width="24px" /></div>
				                  <div class="s2i_desc"><%=abean.gettArea1()%>
				                  <%if(abean.gettArea2()!=null){ %>
					                  <%=","+abean.gettArea2()%>
					                  <%} %>
					                  <%if(abean.gettArea3()!=null){ %>
					                  <%=","+abean.gettArea3() %>
					                  <%} %></div>
				                </div>			              
				              </div>
				              <!-- s2i_content 끝 -->
		                </div>
		                <!-- reviewDesc 끝-->
		            </div>
		            <!-- reviews 끝 -->
		          </div>
		          <!-- review 끝 -->
		          </a>
		       <!-- 리뷰2 끝 -->
	      </div>
	      
<%
	      
			abean = tpvlist.get(2);
	      
			grade = abean.gettRange();
			tgrade = "교습대상 | ";
			if(grade==1){tgrade += "초등학생";}
			else if(grade==2){tgrade += "중학생";}
			else if(grade==3){tgrade += "고등학생";}
			else if(grade==4){tgrade += "대학생";}
			else if(grade==5){tgrade += "성인";}
			else if(grade==6){tgrade += "전체";}
			
			teacherNum = abean.getUserNum();

			
	      %>
	      <div style="background-color: rgb(149, 227, 187);border-color: rgb(88, 193, 137);float: left;width: 32%;margin-left: 2%;">
				<!-- 리뷰3 시작 -->
					<a href="Tpage.jsp?userNum=<%=userNum%>&teacherNum=<%=teacherNum%>">			 				
					
				 <div class="review">
		            <div class="reviews">

		                <img src="resources/img/<%=abean.gettImage()%>" width="100%" height="100%" />
			
		                <div class="reviewDesc">
		          		
				              <div class="s2i_content">
				                <div class="s2i_name"><b><%=abean.gettNickname() %></b></div>
				    <!-- 최고선생님 이런거 붙이는곳 -->
				    			<div class="tag">
				    			<!-- 매칭률 높음 -->
            						<div class="tag1" style="display:none;">우수 선생님</div>
				                <!-- 동영상 등록여부 -->	
				                	<div class="tag2" style="display:none;">동영상공개</div>
				                <!-- 댓글여부 -->	
				                	<div class="tag3" style="display:none;">학생추천</div>
				                </div>
				                
				            <!-- 학교, 전공 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/study.png" width="24px" /></div>					                  
					                  <div class="s2i_desc"><%=abean.gettRecord() %></div>
				                </div>
				                
				             <!-- 희망 과목 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/class.png" width="24px" /></div>				                		
				                	<div class="s2i_desc">
					                  <%=abean.gettSubject1()%>
					                  <%if(abean.gettSubject2()!=null){ %>
					                  <%=","+abean.gettSubject2()%>
					                  <%} %>
					                  <%if(abean.gettSubject3()!=null){ %>
					                  <%=","+abean.gettSubject3() %>
					                  <%} %></div> 			                
				                </div>
				                
				             <!-- 교습 대상 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/range.png" width="24px" /></div>
					                  <div class="s2i_desc"><%=tgrade%></div>
				                </div>
				                
				             <!-- 희망 지역 -->
				                <div class="s2i_profile">
				                  <div class="s2i_svg"><img src="resources/img/location.png" width="24px" /></div>
				                  <div class="s2i_desc"><%=abean.gettArea1()%>
				                  <%if(abean.gettArea2()!=null){ %>
					                  <%=","+abean.gettArea2()%>
					                  <%} %>
					                  <%if(abean.gettArea3()!=null){ %>
					                  <%=","+abean.gettArea3() %>
					                  <%} %></div>
				                </div>			              
				              </div>
				              <!-- s2i_content 끝 -->
		                </div>
		                <!-- reviewDesc 끝-->
		            </div>
		            <!-- reviews 끝 -->
		          </div>
		          <!-- review 끝 -->
		          </a>
		       <!-- 리뷰3 끝 -->
	      </div>
	      <%
	      
	      abean = tpvlist.get(3);
	      
			grade = abean.gettRange();
			tgrade = "교습대상 | ";
			if(grade==1){tgrade += "초등학생";}
			else if(grade==2){tgrade += "중학생";}
			else if(grade==3){tgrade += "고등학생";}
			else if(grade==4){tgrade += "대학생";}
			else if(grade==5){tgrade += "성인";}
			else if(grade==6){tgrade += "전체";}
			
			teacherNum = abean.getUserNum();

			
	      %>	      
	      <div style="background-color: rgb(232, 232, 232);border-color: rgb(224, 224, 224);float: left;width: 32%;margin-right: 2%;margin-top: 2%;">
	<!-- 리뷰4 시작 -->
			<a href="Tpage.jsp?userNum=<%=userNum%>&teacherNum=<%=teacherNum%>">			 				
			       <div class="review">
		            <div class="reviews">

		                <img src="resources/img/<%=abean.gettImage()%>" width="100%" height="100%" />
			
		                <div class="reviewDesc">
		          		
				              <div class="s2i_content">
				                <div class="s2i_name"><b><%=abean.gettNickname() %></b></div>
				    <!-- 최고선생님 이런거 붙이는곳 -->
				    			<div class="tag">
				    			<!-- 매칭률 높음 -->
            						<div class="tag1" style="display:none;">우수 선생님</div>
				                <!-- 동영상 등록여부 -->	
				                	<div class="tag2" style="display:none;">동영상공개</div>
				                <!-- 댓글여부 -->	
				                	<div class="tag3" style="display:none;">학생추천</div>
				                </div>
				                
				            <!-- 학교, 전공 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/study.png" width="24px" /></div>					                  
					                  <div class="s2i_desc"><%=abean.gettRecord() %></div>
				                </div>
				                
				             <!-- 희망 과목 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/class.png" width="24px" /></div>				                		
				                	<div class="s2i_desc">
					                  <%=abean.gettSubject1()%>
					                  <%if(abean.gettSubject2()!=null){ %>
					                  <%=","+abean.gettSubject2()%>
					                  <%} %>
					                  <%if(abean.gettSubject3()!=null){ %>
					                  <%=","+abean.gettSubject3() %>
					                  <%} %></div> 			                
				                </div>
				                
				             <!-- 교습 대상 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/range.png" width="24px" /></div>
					                  <div class="s2i_desc"><%=tgrade%></div>
				                </div>
				                
				             <!-- 희망 지역 -->
				                <div class="s2i_profile">
				                  <div class="s2i_svg"><img src="resources/img/location.png" width="24px" /></div>
				                  <div class="s2i_desc"><%=abean.gettArea1()%>
				                  <%if(abean.gettArea2()!=null){ %>
					                  <%=","+abean.gettArea2()%>
					                  <%} %>
					                  <%if(abean.gettArea3()!=null){ %>
					                  <%=","+abean.gettArea3() %>
					                  <%} %></div>
				                </div>			              
				              </div>
				              <!-- s2i_content 끝 -->
		                </div>
		                <!-- reviewDesc 끝-->
		            </div>
		            <!-- reviews 끝 -->
		          </div>
		          <!-- review 끝 -->
		        </a>  
		       <!-- 리뷰4 끝 -->
	      </div>
	      <%
	      
	      abean = tpvlist.get(4);
	      
			grade = abean.gettRange();
			tgrade = "교습대상 | ";
			if(grade==1){tgrade += "초등학생";}
			else if(grade==2){tgrade += "중학생";}
			else if(grade==3){tgrade += "고등학생";}
			else if(grade==4){tgrade += "대학생";}
			else if(grade==5){tgrade += "성인";}
			else if(grade==6){tgrade += "전체";}

			teacherNum = abean.getUserNum();

			
	      %>	      
	      <div style="background-color: rgb(149, 227, 187);border-color: rgb(88, 193, 137);float: left;width: 32%;margin-top: 2%;">
	      	<!-- 리뷰5 시작 -->
	      	<a href="Tpage.jsp?userNum=<%=userNum%>&teacherNum=<%=teacherNum%>">
	      	
				 <div class="review">
		            <div class="reviews">

		                <img src="resources/img/<%=abean.gettImage()%>" width="100%" height="100%" />
			
		                <div class="reviewDesc">
		          		
				              <div class="s2i_content">
				                <!--<div class="s2i_name"><b><a href="Tpage.jsp?userNum=<%=abean.getUserNum()%>"><%=abean.gettNickname() %></a></b></div>-->
				                <div class="s2i_name"><b><%=abean.gettNickname() %></b></div>
				    			
				    <!-- 최고선생님 이런거 붙이는곳 -->
				    			<div class="tag">
				    			<!-- 매칭률 높음 -->
            						<div class="tag1" style="display:none;">우수 선생님</div>
				                <!-- 동영상 등록여부 -->	
				                	<div class="tag2" style="display:none;">동영상공개</div>
				                <!-- 댓글여부 -->	
				                	<div class="tag3" style="display:none;">학생추천</div>
				                </div>
				                
				            <!-- 학교, 전공 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/study.png" width="24px" /></div>					                  
					                  <div class="s2i_desc"><%=abean.gettRecord() %></div>
				                </div>
				                
				             <!-- 희망 과목 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/class.png" width="24px" /></div>				                		
				                	<div class="s2i_desc">
					                  <%=abean.gettSubject1()%>
					                  <%if(abean.gettSubject2()!=null){ %>
					                  <%=","+abean.gettSubject2()%>
					                  <%} %>
					                  <%if(abean.gettSubject3()!=null){ %>
					                  <%=","+abean.gettSubject3() %>
					                  <%} %></div> 			                
				                </div>
				                
				             <!-- 교습 대상 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/range.png" width="24px" /></div>
					                  <div class="s2i_desc"><%=tgrade%></div>
				                </div>
				                
				             <!-- 희망 지역 -->
				                <div class="s2i_profile">
				                  <div class="s2i_svg"><img src="resources/img/location.png" width="24px" /></div>
				                  <div class="s2i_desc"><%=abean.gettArea1()%>
				                  <%if(abean.gettArea2()!=null){ %>
					                  <%=","+abean.gettArea2()%>
					                  <%} %>
					                  <%if(abean.gettArea3()!=null){ %>
					                  <%=","+abean.gettArea3() %>
					                  <%} %></div>
				                </div>			              
				              </div>
				              <!-- s2i_content 끝 -->
		                </div>
		                <!-- reviewDesc 끝-->
		            </div>
		            <!-- reviews 끝 -->
		          </div>
		          <!-- review 끝 -->
		       <!-- 리뷰5 끝 -->
		       </a>
	      </div>
	      <%
	      
	      abean = tpvlist.get(5);
	      
			grade = abean.gettRange();
			tgrade = "교습대상 | ";
			if(grade==1){tgrade += "초등학생";}
			else if(grade==2){tgrade += "중학생";}
			else if(grade==3){tgrade += "고등학생";}
			else if(grade==4){tgrade += "대학생";}
			else if(grade==5){tgrade += "성인";}
			else if(grade==6){tgrade += "전체";}
			
			teacherNum = abean.getUserNum();

			
	      %>	      
	      <div style="background-color: rgb(232, 232, 232);border-color: rgb(224, 224, 224);float: left;width: 32%;margin-left: 2%;margin-top: 2%;">
		<!-- 리뷰6 시작 -->				 
			<a href="Tpage.jsp?userNum=<%= userNum %>&teacherNum=<%=teacherNum%>">			 
				 <div class="review">
		            <div class="reviews">

		                <img src="resources/img/<%=abean.gettImage()%>" width="100%" height="100%" />
			
		                <div class="reviewDesc">
		          		
				              <div class="s2i_content">
				                <div class="s2i_name"><b><%=abean.gettNickname() %></b></div>
				    <!-- 최고선생님 이런거 붙이는곳 -->
				    			<div class="tag">
				    			<!-- 매칭률 높음 -->
            						<div class="tag1" style="display:none;">우수 선생님</div>
				                <!-- 동영상 등록여부 -->	
				                	<div class="tag2" style="display:none;">동영상공개</div>
				                <!-- 댓글여부 -->	
				                	<div class="tag3" style="display:none;">학생추천</div>
				                </div>
				                
				            <!-- 학교, 전공 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/study.png" width="24px" /></div>					                  
					                  <div class="s2i_desc"><%=abean.gettRecord() %></div>
				                </div>
				                
				             <!-- 희망 과목 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/class.png" width="24px" /></div>				                		
				                	<div class="s2i_desc">
					                  <%=abean.gettSubject1()%>
					                  <%if(abean.gettSubject2()!=null){ %>
					                  <%=","+abean.gettSubject2()%>
					                  <%} %>
					                  <%if(abean.gettSubject3()!=null){ %>
					                  <%=","+abean.gettSubject3() %>
					                  <%} %></div> 			                
				                </div>
				                
				             <!-- 교습 대상 -->
				                <div class="s2i_profile">
					                  <div class="s2i_svg"><img src="resources/img/range.png" width="24px" /></div>
					                  <div class="s2i_desc"><%=tgrade%></div>
				                </div>
				                
				             <!-- 희망 지역 -->
				                <div class="s2i_profile">
				                  <div class="s2i_svg"><img src="resources/img/location.png" width="24px" /></div>
				                  <div class="s2i_desc"><%=abean.gettArea1()%>
				                  <%if(abean.gettArea2()!=null){ %>
					                  <%=","+abean.gettArea2()%>
					                  <%} %>
					                  <%if(abean.gettArea3()!=null){ %>
					                  <%=","+abean.gettArea3() %>
					                  <%} %></div>
				                </div>			              
				              </div>
				              <!-- s2i_content 끝 -->
		                </div>
		                <!-- reviewDesc 끝-->
		            </div>
		            <!-- reviews 끝 -->
		          </div>
		          <!-- review 끝 -->
		          </a>
		       <!-- 리뷰6 끝 -->
			</div>
    </div>
    <!--포토리스트 End-->
    <br />
    <!--리스트 Start-->
 <div id="tlist">
  <form name="searchFrm" method="get">
    <div class="flex">
			<p class="nickShearch">닉네임 검색</p>
			<input name="keyWord" type="text" placeholder="닉네임" value=""/> 
			<input class="isearch" type="button" value="검색" onClick="javascript:check()"/>
			<input class="isearch" type="button" value="리셋" onClick="javascript:listin()"/>
			<input type="hidden" name="nowPage" value="1"/>
			<input type="hidden" name="loc" value="tlist"/>
	</div>
</form>
</div>
	<!-- 닉네임으로 검색 End -->	
	
    <!--리스트 Start-->
    <div class="list">
      <table class="list" width="100%">
        <tr
          align="center"
          style="
            border-top: solid;
            border-bottom: solid;
            background-color: rgb(224, 224, 224);
            border-width: 1px;
            border-color: gray;
            height: 30px;
            font-size: 17px;"
        >
       
        
          <th width="8%">사진</th>
          <th width="5%">성별</th>
          <th width="17.75%">닉네임</th>
          <th width="29.75%">학력</th>
          <th width="9%">과목</th>
          <th width="9.8%">가능 요일</th>
          <th width="9.8%">가능 시간</th>
          <th width="10.75%">지역</th>
        </tr>
   
         <% 
     	
      	//nowPage 요청 처리
 			if(request.getParameter("nowPage")!=null){
 				nowPage = UtilMgr.parseInt(request, "nowPage");
 			}
         
      	//sql문에 들어가는 start, cnt 선언
  		start = (nowPage*numPerPage)-numPerPage;
  		int cnt = numPerPage;
  		
     	//검색일때
     		if (request.getParameter("keyWord") != null) {
     			keyWord = request.getParameter("keyWord");
     		}

     	//검색 후에 다시 처음화면 요청
     	if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
     		keyWord = "";
     	}
     	
     	
    	Vector<TeacherBean> tlist = tmgr.getTeacherList1(request,keyWord, start, cnt);
		Vector<UserBean>ulist = tmgr.getUserList(request,keyWord, start, cnt);
     	
     	totalRecord = tmgr.getTotalCount(request,keyWord);

     	
     			
     	
     	//전체페이지 개수
     		totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
     	//전체블럭 개수
     		totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
     	//현재블럭
     		nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
     	
     	
			String gen ="";//성별 
			
        	int listSize = tlist.size();
        	if(tlist.isEmpty()){
        		%><tr align="center"><td colspan="9" ><h1 style="text-align: center;">
        		<span style="color:rgb(88, 193, 137);">검색조건에</span>
        		<span style="color:rgb(230, 230, 230);">맞는</span>
        		<span style="color:rgb(88, 193, 137);">선생님이</span>
        		<span style="color:rgb(230, 230, 230);">없습니다.</span></h1></td></tr>
        	<%}else{
        		
        for(int i=0;i<numPerPage;i++){
        	if(i==listSize) break;
        	TeacherBean tbean = tlist.get(i);
        	UserBean ubean = ulist.get(i);
        	
			teacherNum = tbean.getUserNum();
			
			if(ubean.getUserGender().equals("1"))
				gen ="male.svg";
			else if(ubean.getUserGender().equals("2"))
				gen ="female.svg";
			
			String tImage = tbean.gettImage();//사진
			String tNickname = tbean.gettNickname();//닉네임
			String tRecord = tbean.gettRecord();//최종 학력
			String tSubject1 = tbean.gettSubject1();//교습 과목1
			String tSubject2 = tbean.gettSubject2();//교습 과목2
			String tSubject3 = tbean.gettSubject3();//교습 과목3
			String tDay = tbean.gettDay();//희망 요일
			String tTime = tbean.gettTime();//희망 시간
			String tArea1 = tbean.gettArea1();//희망 지역1
			String tArea2 = tbean.gettArea2();//희망 지역2
			String tArea3 = tbean.gettArea3();//희망 지역3
			 
			String area1 = tArea1.substring(0, 2); //지역
        %>
		<tr align="center" 
			style="border-top: solid;
				   border-color: gray;
				   border-width: 1px;" 
				   onclick="javascript:location.href='Tpage.jsp?userNum=<%= userNum %>&teacherNum=<%=teacherNum%>'">
			<td><img style="border-radius:100px;" class="profile1" src="resources/img/<%=tbean.gettImage()%>"
						width="40" height="40" ></td>
				<td><img src="resources/img/<%=gen %>" width="20px" height="20px"/></td>
			<td align="left">
				 <div class="tag">
				 <!-- 매칭률 높음 -->
            	 <div class="tag1" style="display:none;">우수 선생님</div>
				 <!-- 동영상 등록여부 -->	
				 <div class="tag2" style="display:none;">동영상공개</div>
				 <!-- 댓글여부 -->	
				 <div class="tag3" style="display:none;">학생추천</div>
				 </div>
				<div><%=tNickname%></div>
			</td>
			<td align="left"><div class="s2i_desc"><%=tRecord%></div></td>
			<td><%=tSubject1%> 등</td>
			<td><%=tDay%></td>
			<td><%=tTime%></td>
			<td><%=area1%>지역</td>
		</tr>
        <%}//---for1%>
       <%}//---if-else%>
       
    </table>
       <tr>
		<td colspan="2"><br><br></td>
	</tr>
	<table class="page1" align="center">
	<tr>
		<td class="page" align="center" width="100%">
		<!-- 페이징 및 블럭 Start -->
		<%if(totalPage>0){%>
			<!-- 이전 블럭 -->
			<%if(nowBlock>1){ %>
				<a class="next" href="javascript:block('<%=nowBlock-1%>')">이전</a>
			<%}%>
			<!-- 페이징 -->
			<%
				int pageStart = (nowBlock-1)*pagePerBlock+1;
				int pageEnd = (pageStart+pagePerBlock)<=totalPage?pageStart+pagePerBlock:totalPage+1;
				for(;pageStart<pageEnd;pageStart++){
			%>
			<a class="up" href="javascript:pageing('<%=pageStart%>')">
				<%if(nowPage==pageStart){%><font color="#00CC66"><%}%>
				<%=pageStart%>
				<%if(nowPage==pageStart){%></font><%}%>
				</a>
			<%}//--for%>
			<!-- 다음 블럭 -->
			<%if(totalBlock>nowBlock){ %>
					<a class="next" href="javascript:block('<%=nowBlock+1%>')">다음</a>
			<%} %>
		<%}//---if1%>
		<!-- 페이징 및 블럭 End -->
		</td>
		</tr>
	</table>
     
    </div>
    <form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>
	
	<form name="readFrm" method="get">
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
		<%
		if(request.getParameter("area")!=null){
			String[] areas = request.getParameterValues("area");
			
			for(int i =0; i<areas.length;i++){
			%>		
				<input type="hidden" name="area" value="<%=areas[i]%>">		
		<%}}%>
		<%
		if(request.getParameter("subject")!=null){
			String[] subjects = request.getParameterValues("subject");
			
			for(int i =0; i<subjects.length;i++){
			%>		
				<input type="hidden" name="subject" value="<%=subjects[i]%>">		
		<%}}%>
		
		<input type="hidden" name="fbtn" value="<%=request.getParameter("fbtn")%>">
		<input type="hidden" name="gbtn" value="<%=request.getParameter("gbtn")%>">
		<input type="hidden" name="dbtn" value="<%=request.getParameter("dbtn")%>">
		<input type="hidden" name="tbtn" value="<%=request.getParameter("tbtn")%>">
		<input type="hidden" name="tobj" value="<%=request.getParameter("tobj")%>">
		<input type="hidden" name="gbtn" value="<%=request.getParameter("gbtn")%>">
		<input type="hidden" name="Astart" value="<%=request.getParameter("Astart")%>">
		<input type="hidden" name="Aend" value="<%=request.getParameter("Aend")%>">
		
	</form>
    	
    </div><!-- contentWrap -->
  <br>
	<div include-html="footer.jsp"></div>
    <footer include-html="footer1.jsp"></footer>
    <script>
      includeHTML();
      
      $(document).ready(function () {
          $('html, body').animate({
              scrollTop: $('#contentWrap').offset().top
          }, 'fast'); //slow
      });
      
    </script>
  </body>
  
</html>