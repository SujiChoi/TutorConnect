<%@page import="bean.UserBean"%>
<%@page import="bean.TeacherBean"%>
<%@page import="mgr.UtilMgr"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.UsesStatement"%>
<%@ include file="M_header.jsp" %> 
<%@ page contentType="text/html; charset=UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
	
	userNum = Integer.parseInt(request.getParameter("userNum"));
	
%>
<jsp:useBean id="tMgr" class="mgr.TsearchMgr"/>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>과외커넥터 관리자페이지</title>
    <script src="../resources/js/includeHTML.js"></script>
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
        margin-top: 50px;
        text-align: center;
      }
      h2{
      margin-left:50px;
      text-align:left;
      }
      span{
      font-size:20px;
      font-weight:800;
      margin-top:200px;
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
        width:120px;
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
  </head>
  <body>
    <div id="contentWrap">
    	<h2>선생님 상세 페이지</h2>
    	
    		<div id='searchv' class="search">
    			<%
    				TeacherBean bean = tMgr.Tpage(userNum);
    				UserBean ubean = tMgr.Tinfopage(userNum);
    			    
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
    				String tgender = "d";
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
    			<form method="post" name="uu"/>
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
				                
				             <!-- 희망 과목 -->
				              <div class="profile">
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
					            
				                <div class="content">				                				                
						                  <div class="s2i_desc">등급</div>					                  
						                  <div class="s2i_name"><input style="width: 100px;" name="tGrade" value="<%=bean.gettGrade()%>"></div>
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
	 			  <div class="reviews" style="margin:20px 0 0 0;">  			
	    				<div class="content">
						       <div class="s2i_desc" >동영상</div>
						        <div class="s2i_name"> 
				        </div>
    				</div>
    				
		          <div class="content" style="width:100%;padding-top: 10px;">				
						<video src="./video/<%=bean.gettFile() %>" style="margin:auto;padding-top: 10px;" width="640" controls>브라우저가 지원하지 못할 시 표시할 내용</video>
    				</div>
	    		</div>	
 <!-- 동영상 소개 끝 -->   			    			    				
   		          </div><!-- reviews 끝 -->
    		</div><!-- search -->
    		<div class="content" style="justify-content: flex-end;width: 100%;">
				<div class="s2i_desc"><a href="javascript:ttupdate()">수정완료</div>
				<div class="s2i_desc"><a href="javascript:history.back()">뒤로</div>
		</div>
		<input type=hidden name="userNum" value="<%=ubean.getUserNum()%>">
		<input type=hidden name="fromNum" value="<%=ubean.getUserNum()%>">
		</form>
		</div>
    
    <script>
    function ttupdate(){
    	document.uu.action="M_teacherProc.jsp?flag=update";
		document.uu.submit();
    	
    }
    
    </script>
  </body>
</html>