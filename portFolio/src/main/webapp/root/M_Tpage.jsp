<%@page import="java.util.Vector"%>
<%@page import="bean.TeacherBean"%>
<%@page import="bean.UserBean"%>
<%@page import="bean.ReviewBean"%>
<%@page import="bean.StudentBean"%>
<%@page import="mgr.UtilMgr"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.UsesStatement"%>
<%@ include file="M_header.jsp"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="tsMgr" class="mgr.TsearchMgr"/>
<jsp:useBean id="tMgr" class="mgr.TeacherMgr"/>
<jsp:useBean id="rMgr" class="mgr.RootReviewMgr"/>
<jsp:useBean id="sMgr" class="mgr.StudentMgr"/>

<%
	request.setCharacterEncoding("UTF-8");

	int totalRecord = 0;//총게시물수
	int numPerPage = 3;//페이지당 레코드 개수(5,10,15,30)
	int pagePerBlock = 5;//블럭당 페이지 개수
	int totalPage = 0;//총 페이지 개수
	int totalBlock = 0;//총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭


	String keyWord = "";

	//검색일때
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
	}
	
	//검색 후에 다시 처음화면 요청
	if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
		keyWord = "";
	}
	//nowPage 요청 처리
	if(request.getParameter("nowPage")!=null){
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}

	//sql문에 들어가는 start, cnt 선언
			int start = (nowPage*numPerPage)-numPerPage;
			int cnt = numPerPage;
	
	userNum = Integer.parseInt(request.getParameter("userNum"));
	//int teacherNum = Integer.parseInt(request.getParameter("teacherNum"));
			
	// 현재 toNum에 작성된 총 리뷰 수 
	totalRecord = rMgr.getTotalRecord(userNum,keyWord);
	//전체페이지 개수
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	//전체블럭 개수
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	//현재블럭
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);


	

%>


<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <script src="../resources/js/includeHTML.js"></script>
    <script type="text/javascript" src="../resources/js/jquery-3.5.0.min.js"></script>
    <script>
    function alreadyStudent(){
		alert("이미 학생으로 등록되어 있습니다!");
	}
	function alreadyTeacher(){
		alert("이미 선생님으로 등록되어 있습니다!");
	}
    </script>
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
      .pretag1{
      	width:600px;
      	white-space: pre-wrap; /* CSS3*/
		white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
		white-space: -pre-wrap; /* Opera 4-6 */
		white-space: -o-pre-wrap; /* Opera 7 */
		word-wrap: break-all; /* Internet Explorer 5.5+ */ 
      }
      
 /*후기 내용*/
div.comment {
	margin-left: 20px;
	width: 100%;
}

div.comment2 {
	padding-top: 5px;
	padding-bottom: 10px;
	width: 100%;
	height: 110px;
}

div.nickline {
	display: flex;
}

.keyWord {
	font-size: 15px;
	height: 30px;
}

div.flex {
	display: flex;
	padding-left: 500px;
	padding-bottom: 5px;
}
.isearch {
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
.isearch:hover{
	background-color: rgb(88, 193, 137);
	border: 2px solid white;
	cursor:pointer;
	color: white;
	width: 4.5vw;
	height: 30px;
	border-radius: 5px;
	font-weight: bold;
	font-size: 17px;
	margin-left: 10px;
}
.flex .nickSearch {
	margin: 5px 10px 0px 0px;
	font-size: 15px;
	font-weight: 800;
}
/*별점*/
#star_grade a {
	text-decoration: none;
	color: gray;
}

#star_grade a.on {
	color: red;
}

.page a {
	color: black;
}

table.page1 {
	width: 100%;
}

a.up {
	color: darkgrey;
}

a.page .next {
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
    </style>
  </head>
  <body>
    	<div id="contentWrap">
    		<h2>선생님 상세 페이지</h2>
    		<div id='searchv' class="search">
    			<%
    				TeacherBean bean = tsMgr.Tpage(userNum);
    				UserBean ubean = tsMgr.Tinfopage(userNum);
    			    
    				//교습대상 변경
    				int grade = bean.gettRange();
    				String tgrade = "";
    				if(grade==1){tgrade += "초등학생";}
    				else if(grade==2){tgrade += "중학생";}
    				else if(grade==3){tgrade += "고등학생";}
    				else if(grade==4){tgrade += "대학생";}
    				else if(grade==5){tgrade += "성인";}
    				else if(grade==6){tgrade += "전체";}
    				
    				//성별 변경
    				String gender = ubean.getUserGender();
    				String tgender = "";
    				if(gender.equals("1")){tgender="남자";}
    				else if(gender.equals("2")){tgender="여자";}
    				
    				//생년월일 계산
    				String birth = ubean.getUserBirth();
					int year = Integer.parseInt(birth.substring(0,4));
					//올해 빼기 - year
					
					SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy");
					Date time = new Date();
					int thisyear = Integer.parseInt(format1.format(time));
    				
					year = thisyear-year;
					//생년월일 계산끝
					
					int fee = bean.gettFee();
					String money;
					if(fee==0){
						money="협의";
					}else{
						money=fee+"만원 이하";
					}
					
    			%>
    			<div class="review">
		            <div class="reviews" style="display: flex;justify-content:center;">
						<div class="reviewImg">
		                <img src="../resources/img/<%=bean.gettImage()%>" style="border-radius: 5px;" width="100%" height="100%" />
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
						                		<div class="s2i_name"><%=bean.gettNickname() %></div>
				                		</div>
									</div>
				            <!-- 학교, 전공 -->
				                <div class="profile">
						              <div class="content">
						                	<div class="s2i_desc">나이 / 성별</div>
						                	<div class="s2i_name"><%= year +"세 / "+tgender%></div>
					                	</div>
						                <div class="content">
							                  <div class="s2i_desc" >횟수 / 시간</div>					                  
							                  <div class="s2i_name"><%=bean.gettDay()+" / "+ bean.gettTime()%></div>
					               		</div>
				                </div>
				             <!-- 교습 대상 -->
				                <div class="profile">
						              <div class="content">				                	
						                  <div class="s2i_desc">교습 대상</div>
						                  <div class="s2i_name"><%=tgrade%></div>
					                  </div>					              
				                	<div class="content">				                				                
						                  <div class="s2i_desc">희망 과외 비용</div>					                  
						                  <div class="s2i_name"><%=money%></div>
				               		</div>
				                </div>
				                
				           <div class="profile">				                
				             							<!-- 희망 과목 -->
				                <div class="content">
					                  <div class="s2i_desc">수업 가능 과목</div>
					                  <div class="s2i_name">
					                  <%=bean.gettSubject1()%>
					                  <%if(bean.gettSubject2()!=null){ %>
					                  <%=", "+bean.gettSubject2()%>
					                  <%} %>
					                  <%if(bean.gettSubject3()!=null){ %>
					                  <%=", "+bean.gettSubject3() %>
					                  <%} %></div>      
				                </div>
				                
				                <div class="content" >
									<div class="s2i_desc">등급</div>
									<div class="s2i_name"><%=bean.gettGrade()%></div>
								</div>
							</div>
				                
				             <!-- 희망 지역 -->
				                <div class="content" style="width:100%;">
				                  <div class="s2i_desc">희망 지역</div>
				                  <div class="s2i_name"><%=bean.gettArea1()%>
				                  <%if(bean.gettArea2()!=null){ %>
					                  <%=", "+bean.gettArea2()%>
					                  <%} %>
					                  <%if(bean.gettArea3()!=null){ %>
					                  <%=", "+bean.gettArea3() %>
					                  <%} %></div>
				                </div>
				              
				              </div>
				              <!-- s2i_content 끝 -->
		                </div>
		                <!-- reviewDesc 끝-->
		                
		            </div>
			            <!-- 자기소개 -->
			           <div class="reviews" style="margin:20px 0 0 0;">
					           <div class="content">
							       <div class="s2i_desc">자기소개</div>
							        <div class="s2i_name"> </div>
			    				</div>    				
					          <div class="content" style="width:100%;">
					          			<div class="s2i_name" style="margin:10px;"><pre class="pretag"><%=bean.gettPR() %></pre></div>
			    				</div>
	    				</div>
	    			<!-- 자기소개 끝-->
<!-- 동영상 소개 -->

				<%
					String File = bean.gettFile(); 
				
					if(File==null) {
				%>	    			
	 			  <div class="reviews" style="margin:20px 0 0 0;display:none" >  			
	    				<div class="content">
						       <div class="s2i_desc" >동영상</div>
						        <div class="s2i_name"> 
				        </div>
    				</div>
    			<%	} else {%>
    				<div class="reviews" style="margin:20px 0 0 0;" >  			
	    				<div class="content">
						       <div class="s2i_desc" >동영상</div>
						        <div class="s2i_name"> 
				        </div>
    				</div>
    			<%}%>
    				
		          <div class="content" style="width:100%;padding-top: 10px;">				
						<video src="./video/<%=bean.gettFile() %>" style="margin:auto;padding-top: 10px;" width="640" controls>브라우저가 지원하지 못할 시 표시할 내용</video>
    				</div>
	    		</div>	
 <!-- 동영상 소개 끝 -->   			    			    				
   		          </div><!-- reviews 끝 -->
    		</div>
    				<!-- search -->
		<div class="content" style="justify-content: flex-end; width: 100%;">
			<div class="s2i_desc">
				<a href="javascript:tupdate('<%=ubean.getUserNum()%>')">수정</a>
			</div>
			<div class="s2i_desc">
				<a href="javascript:tdelete('<%=ubean.getUserNum()%>')">삭제</a>
			</div>
			<div class="s2i_desc">
				<a href="javascript:location.href='M_memberMgr.jsp'">뒤로</a>
			</div>
		</div>

		<form name="update" method="post" action="M_teacherUpdate.jsp">
			<input type=hidden name=userNum>
		</form>
		<form name="del" method="post" action="M_teacherProc.jsp?flag=delete">
			<input type=hidden name=userNum>
		</form>
		<form name="del1" method="post" action="M_teacherProc.jsp?flag=update1">
			<input type=hidden name=fromNum>
			<input type=hidden name=toNum>
			<input type=hidden name=userNum>
		</form>
		
		
		<div class="nickline">
			<form name="searchFrm">
				<h2>선생님 후기</h2>
				<div class="flex">
					<p class="nickSearch">닉네임 검색</p>
					<input class="keyWord" name="keyWord" type="text" placeholder="번호" />
					<input class="isearch" type="button" value="검색"
						onClick="javascript:check()" /> <input class="isearch"
						type="button" value="리셋" onClick="javascript:location.href='Tpage.jsp?userNum=<%=userNum%>'" /> <input
						type="hidden" name="nowPage" value="1">
					<input type="hidden" name="userNum" value="<%=userNum%>">
						
				</div>
			</form>
		</div>
			
				 <div>
				 <%
		        	Vector<ReviewBean> rlist = rMgr.getReviewList2(start, cnt, userNum, keyWord);
		         	int listSize = rlist.size(); 
		        	if(rlist.isEmpty()){
		        		%><div class="review" style="background:rgb(243, 243, 243); margin:0px 10%;">
		        				<td colspan="9"><h1 style="text-align: center;">
	        						<span style="color:gray;">등록된</span>
	        						<span style="color:rgb(88, 193, 137);">후기가 </span>
	        						<span style="color:gray;">없습니다.</span>
	        					</h1></td>
	        			  </div>
	        			</br>
		        	<%}else{
		        		
		        for(int i=0;i<numPerPage;i++){
		        	if(i==listSize) break;
		        	ReviewBean rbean = rlist.get(i);
		        	int num = rbean.getNum();
					int fromNum = rbean.getFromNum(); //보낸 사람
					int toNum = rbean.getToNum(); //받는 사람
					int ReviewAvailable = rbean.getReviewAvailable(); //삭제 여부
					String ReviewContent = rbean.getReviewContent(); //리뷰 내용
					int ReviewRate = rbean.getReviewRate(); //별점
					String Ip = rbean.getIp(); //ip수집
					StudentBean sbean=sMgr.getStudentInfo(fromNum);
					String tImage=tMgr.getImage(fromNum);
		        %>
		        <div class="rlist">
					<div class="review" style="background:rgb(243, 243, 243); margin:0px 10%;  display: flex;">
						<div style="width:100px;">
							<p align="center" style="margin:1px;">
							
								<%if(tImage == null) {%>
								<img src="../resources/img/anonymous.jpg" width="50px" height="50px" style="border-radius:500px; display:block;">
								<%}else {%>
								<img src="../resources/img/<%=tImage%>" width="50px" height="50px" style="border-radius:500px; display:block;">
							<%}%>
							</p>
							<p align="center" style="margin:1px;"><%=sbean.getsNickname()%></p>
							<!-- 별점 -->
							<p align="center" style="margin:1px;">
							    <%
							        switch (ReviewRate) {
							        case 1:
							        	%><a style="color:red;">★</a><a style="color:gray;">★★★★</a><%;
							            break;
							        case 2:
							        	%><a style="color:red;">★★</a><a style="color:gray;">★★★</a><%;
							            break;
							        case 3:
							        	%><a style="color:red;">★★★</a><a style="color:gray;">★★</a><%;
							            break;
							        case 4:
							        	%><a style="color:red;">★★★★</a><a style="color:gray;">★</a><%;
							            break;
							        case 5:
							        	%><a style="color:red;">★★★★★</a><%;
							            break;
							        default:
							        	%><a style="color:gray;">★★★★★</a><%;
							            break;
							        } %></p>
						</div>
						
						<div class="comment">
							<div  class="comment2" style="background:white; border-radius:5px;">
								<div style="margin:10px;"><pre class="pretag1"><%=ReviewContent%></pre></div>								
							</div>
								<div align="right"><input class="isearch" type="button" value="삭제" onClick="javascript:aa(<%=userNum%>,<%=fromNum%>,<%=toNum%>)"/></div>
						</div>
					</div>
				</div>
				</br>
				<%}//---for1%>
       <%}//---if-else%>
				<!-- 후기 끝-->
				
    	</div>
    	
    	<table class="page1">
			<tr>
				<td class="page" align="center" width="100%">
				<!-- 후기 페이징 및 블럭 Start -->
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
				<!-- 후기 페이징 및 블럭 End -->
				</td>
				</tr>
		</table>
				
		<form name="listFrm" method="post">
			<input type="hidden" name="reload" value="true"> 
			<input type="hidden" name="nowPage" value="1">
		
		</form>
    	
		<form name="readFrm">
			<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
			<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
			<input type="hidden" name="keyWord" value="<%=keyWord%>">
			<input type="hidden" name="userNum" value="<%=userNum%>">		
		</form>	
		
				<!-- 댓글 달기 끝-->
				
		<div class="content" style="justify-content: flex-end;width: 100%;">
		</div>
		
		
    	</div>
    	<br>

     <script>
      includeHTML();
      

      function pageing(page) {
			document.readFrm.nowPage.value = page;
			document.readFrm.submit();
		}
    
    function block(block) {
			document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
			document.readFrm.submit();
		}
    function check(){
		if (document.searchFrm.keyWord.value == "") {
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
	function tdelete(userNum) {
		document.del.userNum.value = userNum;
		if (confirm("정말 삭제하시겠습니까?") == true) {
			document.del.submit();
		} else {
			return false;
		}

	}

	function tupdate(userNum) {
		document.update.userNum.value = userNum;
		document.update.submit();
	}
	
	function aa(userNum, fromNum, toNum){
		document.del1.userNum.value= userNum;
		document.del1.fromNum.value = fromNum;
		document.del1.toNum.value = toNum;
		if (confirm("정말 삭제하시겠습니까?") == true) {
			document.del1.submit();
		} else {
			return false;
		}
		
	}
    </script>
  </body>
</html>

