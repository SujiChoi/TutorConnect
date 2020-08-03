<%@page import="mgr.UtilMgr"%>
<%@page import="bean.StudentBean"%>
<%@page import="bean.UserBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="rMgr" class="mgr.RootMemberMgr" />

<%
request.setCharacterEncoding("UTF-8");
	int totalRecord = 0;//총게시물수
	int numPerPage = 15;//페이지당 레코드 개수(5,10,15,30)
	int pagePerBlock = 5;//블럭당 페이지 개수
	int totalPage = 0;//총 페이지 개수
	int totalBlock = 0;//총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭
	
	int teacherNum=0;

	//검색에 필요한 변수
	String keyWord = "";
	//검색일때
	if (request.getParameter("keyWord") != null) {
		keyWord = request.getParameter("keyWord");
	}

	//검색 후에 다시 처음화면 요청
	if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
		keyWord = "";
	}

	totalRecord = rMgr.getTotalCount(keyWord);
	//out.print("totalRecord : " + totalRecord);

	//nowPage 요청 처리
	if (request.getParameter("nowPage") != null) {
		nowPage = UtilMgr.parseInt(request, "nowPage");
	}

	//sql문에 들어가는 start, cnt 선언
	int start = (nowPage * numPerPage) - numPerPage;
	int cnt = numPerPage;

	//전체페이지 개수
	totalPage = (int) Math.ceil((double) totalRecord / numPerPage);
	//전체블럭 개수
	totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock);
	//현재블럭
	nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock);
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>과외커넥터 관리자페이지</title>
<style>
* {
	box-sizing: border-box;
}

html, body {
	font-family: "Raleway", sans-serif;
	margin: 0;
}

#contentWrap {
	padding: 0 15vw;
	height: auto;
	margin-top: 50px;
	text-align: center;
	
}

div.nickline {
	
	display:flex;
}
div.flex{
	display:flex;
	padding-left: 650px;
}
p {
	margin-top: 5px;
	margin-right: 15px;
	font-size: 15px;
	font-weight: 800;
}

.keyWord {
	font-size: 15px;
	height: 30px;
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

table {
	border-collapse: collapse;
}

.list td {
	padding: 5px;
}

.trth {
	background-color: rgb(224, 224, 224);
	text-align: center;
	font-weight: 800;
}

.trtd {
	border-bottom: 2px solid rgb(224, 224, 224);
	background-color: white;
	text-align: center;
	font-size: 13px;
}

.trtd a {
	font-family: "Raleway", sans-serif;
	font-size: 13px;
	border-radius: 4px;
	background: #BDBCBC;
	color: white;
	padding: 2px;
}


.up{
	color:darkgrey;
	
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
.number{
	color: black;
	font-weight:bold;
	font-size:15px;
	
}
</style>
</head>
<body>
	<header>
	<%@ include file="M_header.jsp"%>
	</header>
	<div id="contentWrap">
		<div class="nickline">
		<div class="number" align="left">
		TOTAL : <%=totalRecord%>(<font color="red"><%=nowPage+"/"+totalPage%>Page</font>)
		</div>
		<form  name="searchFrm">
		<div class="flex">
			<p class="nickSearch">아이디 검색</p>
			<input class="keyWord" name="keyWord" type="text" placeholder="아이디" /> 
			<input class="isearch" type="button" value="검색" onClick="javascript:check()"/>
			<input class="isearch" type="button" value="리셋" onClick="javascript:listin()"/>
			<input type="hidden" name="nowPage" value="1">
		</div>	
		</form>
		</div>
		<div class="list">
			
			<table class="list" width="100%">
			<tr>
				<td>
			<%
				Vector<UserBean> vlist = rMgr.getUserList(keyWord, start, cnt);
				int listSize = vlist.size();//브라우저 화면에 표시될 게시물 번호
				if(vlist.isEmpty()){
				out.println("등록된 회원이 없습니다.");
				}else{
			%>
			<table>
				<tr class="trth">
					<td width="5%">NUM</td>
					<td width="9%">ID</td>
					<td width="8%">PWD</td>
					<td width="8%">NAME</td>
					<td width="22%">ADDERESS</td>
					<td width="10%">PHONE</td>
					<td width="14%">EMAIL</td>
					<td width="6%">BIRTH</td>
					<td width="5%">GENDER</td>
					<td width="13%">상세정보</td>
				</tr>
				<%
					
				for (int i = 0; i < numPerPage; i++) {
					if(i==listSize) break;	
					UserBean uBean = vlist.get(i);
					
				%>
				<tr class="trtd">
					<td><%=uBean.getUserNum()%></td>
					<td><%=uBean.getUserId()%></td>
					<td><%=uBean.getUserPwd()%></td>
					<td><%=uBean.getUserName()%></td>
					<td class="address" style="text-align: left;"><%=uBean.getUserAddress()%></td>
					<td><%=uBean.getUserPhone()%></td>
					<td><%=uBean.getUserEmail()%></td>
					<td><%=uBean.getUserBirth()%></td>
					<td><%=uBean.getUserGender()%></td>
					<td>
						<%	
						
							String background = "#BDBCBC";
							String background1 ="#BDBCBC";
							String border="1px solid #BDBCBC";
							String border1="1px solid #BDBCBC";
							int studentuser = uBean.getUserNum();
							boolean flag =rMgr.studentCheck(studentuser);
							if(flag){
							background="rgb(88, 193, 137)";	
							border="1px solid rgb(88, 193, 137)";
							}
								
						%> 
						<%if(flag){ %>
						<a  href="javascript:supdate('<%=uBean.getUserNum()%>')"
						style="background:<%=background%>;border:<%=border%>">학생정보</a>
						<%}else{ %>
						<a  href="javascript:none()"
						style="background:<%=background%>;border:<%=border%>">학생정보</a>
						<%} %>
						
						 <%
						 	teacherNum = uBean.getUserNum();	
							boolean flag1 =rMgr.teacherCheck(teacherNum);
								if(flag1){
								background1="rgb(88, 193, 137)";
								border1="1px solid rgb(88, 193, 137)";
								} 
						%> 
						<%if(flag1){ %>
						<a  href="javascript:tupdate('<%=uBean.getUserNum()%>')" 
						style="background:<%=background1%>; border:<%=border1%>">선생정보</a>
						<%}else{ %>
						<a  href="javascript:none()"
						style="background:<%=background1%>;border:<%=border1%>">선생정보</a>
						<%} %>
						 
					</td>

				</tr>
				<%}//for%>
				</table>
		<%}//---if-else%>	
			</td>
		</tr>
		<tr>
		<td colspan="2"><br></td>
	</tr>
	<tr>
		<td class="page">
		<!-- 페이징 및 블럭 Start -->
			<%if(totalPage>0){%>
			<!-- 이전 블럭 -->
			<%if(nowBlock>1){ %>
				<a class="next" href="javascript:block('<%=nowBlock-1%>')">이전</a>
			<%} %>
			<!-- 페이징 -->
			<%
					int pageStart = (nowBlock-1)*pagePerBlock+1;
					int pageEnd = (pageStart+pagePerBlock)<=totalPage?pageStart+pagePerBlock:totalPage+1;
					for(;pageStart<pageEnd;pageStart++){
			%>

				<a class="up"href="javascript:pageing('<%=pageStart%>')">
				<%if(nowPage==pageStart){%><font color="#00CC66"><%}%>
					<%=pageStart%>
				<%if(nowPage==pageStart){%></font><%}%>
				</a>
			<%}//---for%>
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


	</div>
	<form name="supdate" method="post" action="M_Spage.jsp">
		<input type=hidden name="userNum">
	</form>
	<form name="tupdate" method="post" action="M_Tpage.jsp">
		<input type=hidden name="userNum">
	</form>
	<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>

	<form name="readFrm">
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>">
	</form>
	<script >
		function supdate(userNum) {
			
			document.supdate.userNum.value = userNum;
			document.supdate.submit();
			
		}
		function tupdate(userNum) {
			document.tupdate.userNum.value = userNum;
			document.tupdate.submit();
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
		function listin() {
			document.listFrm.action = "M_memberMgr.jsp";
			document.listFrm.submit();
		}
		function none(){
			alert("정보가 없습니다.");
		}
	</script>
</body>
</html>
