<%@page import="bean.ReportBean"%>
<%@page import="java.util.Vector"%>
<%@page import="mgr.UtilMgr"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="pMgr" class="mgr.RootReportMgr" />
<%
request.setCharacterEncoding("UTF-8");
	int totalRecord = 0;//총게시물수
	int numPerPage =15;//페이지당 레코드 개수(5,10,15,30)
	int pagePerBlock = 5;//블럭당 페이지 개수
	int totalPage = 0;//총 페이지 개수
	int totalBlock = 0;//총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭

	//검색에 필요한 변수
	int keyWord = 0;
	//검색일때
	if (request.getParameter("keyWord") != null) {
		keyWord = Integer.parseInt(request.getParameter("keyWord"));
	}

/* 	//검색 후에 다시 처음화면 요청
	if (request.getParameter("reload") != null && request.getParameter("reload").equals("true")) {
		keyWord = 0;
	}
 */
	totalRecord = pMgr.getTotalCount(keyWord);
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
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>과외커넥터 관리자페이지</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
<style>
* {
	box-sizing: border-box;
}

html, body {
	font-family: "Raleway", sans-serif;
	margin: 0;
}

#contentWrap {
	padding: 0 21vw;
	height: auto;
	margin-top: 50px;
	text-align: center;
}

p {
	margin-top: 5px;
	margin-right: 15px;
	font-size: 15px;
	font-weight: 800;
}

div.nickline {
	display: flex;
}

div.flex {
	display: flex;
	padding-left: 750px;
}
.keyWord {
	font-size: 15px;
	height: 30px;
	width:100px;
}
.number{
	color: black;
	font-weight:bold;
	font-size:15px;
	
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
.page{
	text-align: center;
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
.hidden {
	border-bottom: 2px solid rgb(224, 224, 224);
	background-color: white;
	font-size: 13px;
}
.flex1{
	display: flex;
}
.flex2{
	display: flex;
	padding:5px;
}
.tt{
	text-align: left;
	width: 350px;
	
}
.tt span{
	font-weight: bold;
	font-family: "Raleway", sans-serif;
	font-size: 15px;
	border-radius: 4px;
	color: white;
	background:rgb(88, 193, 137);	
	border:1px solid rgb(88, 193, 137);
	padding: 4px;
	
}
.tt .aa{
	padding:10px;
	font-size: 15px;
	font-weight:bold;
}
.tt .qq{
	padding:10px;
	font-size: 15px;
	height:auto;

}
.bb{
	padding-left:600px;
	padding-top:2px;
}
	
.file span{
	font-weight: bold;
	font-family: "Raleway", sans-serif;
	font-size: 15px;
	border-radius: 4px;
	color: white;
	background:rgb(88, 193, 137);	
	border:1px solid rgb(88, 193, 137);
	padding: 4px;
	
}
.file{
	margin-left:5px;
	width:400px;
	text-align:left;
}
.file a{
	color:blue;
	font-size: 15px;
	font-weight: bold;
	text-decoration: underline;
}
.zz{
display:inline;
background-color: rgb(88, 193, 137);
color:white;
border: 1px solid white;
padding:5px;}

.zz:hover {
	display:inline;
	background-color: green;
	color:white;
	border: 1px solid white;
	padding:5px;
}

</style>
</head>
<body>
	<header><%@ include file="M_header.jsp"%>
	</header>
	<div id="contentWrap">
		<div class="nickline">
			<div class="number" align="left">
				TOTAL :
				<%=totalRecord%>(<font color="red"><%=nowPage + "/" + totalPage%>Page</font>)
			</div>
			<form name="npFrm" method="post">
				<div class="flex">
					<p class="state">처리상태</p>
					<select name="keyWord" class="keyWord" onchange="numPerFn()">
						<option value="0" >전체</option>
						<option value="1" >대기</option>
						<option value="2">처리완료</option>
					</select> 
				</div>
			</form>
			<script>document.npFrm.keyWord.value=<%=keyWord%></script> 
		</div>
		
		<div class="list">
			
			<table class="list" width="100%">
			<tr>
				<td>
			<%
				Vector<ReportBean> vlist = pMgr.getReportList(keyWord, start, cnt);
				int listSize = vlist.size();//브라우저 화면에 표시될 게시물 번호
				if(vlist.isEmpty()){
				out.println("등록된 신고가 없습니다.");
				}else{
			%>
			<table>
				<tr class="trth">
					<td width="5%">NUM</td>
					<td width="10%">신고자</td>
					<td width="10%">신고대상자</td>
					<td width="30%">신고내용</td>
					<td width="20%">등록시간</td>
					<td width="5%">파일</td>
					<td width="15%">처리상태</td>
					<td width= "5%"></td>
				</tr>
				<%
					
				for (int i = 0; i < numPerPage; i++) {
					if(i==listSize) break;	
					ReportBean pBean = vlist.get(i);
					
				%>
				<tr class="trtd">
					<td><%=pBean.getReportNum()%></td>
					<td><%=pBean.getFromId()%></td>
					<td><%=pBean.getToId()%></td>
					<td style="text-align: left;">&nbsp;&nbsp;<%=pBean.getReportContent()%></td>
					<td><%=pBean.getReportDate()%></td>
					<td><%=pBean.getReportImage()%></td><% 
						int wait=pBean.getReportCheck();
						String ww="";
						if(wait==1){
							ww="대기";
							%><td style="color:red;font-weight: bold;"><%=ww%></td><%
						}else{
							ww="처리완료";
							%><td><%=ww%></td><%
						}
						
					%>
					<td><input id="button<%=pBean.getReportNum() %>" type="button" value="보이기" onclick="seeTr(<%=pBean.getReportNum()%>)" /></td>
				</tr>
				<tr id="hidden<%=pBean.getReportNum()%>" class="hidden" style="display:none;">
				<td colspan="8">
				<div class="flex1">
				<div class="tt">
				<div class="aa"><span> 신 고 자</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=pBean.getFromId()%>
				
				</div>
				<hr style="width:340px;">
				<div class="aa"><span>신고대상</span>&nbsp;&nbsp;<%=pBean.getToId()%></div>
				<hr style="width:340px;">
				<div class="qq"><span>신고사유</span>
					<div style="padding-top:10px;width:300px;"><%=pBean.getReportContent()%></div>
				</div>
				<hr style="width:1100px;">
				</div>
				
				<div><img src="../resources/img/<%=pBean.getReportImage()%>" alt="이미지 없음" width="730" height="180"></div>
				</div>
				<div class="flex2">
				<div class="file"><span>첨부파일</span>&nbsp;&nbsp;<%if(pBean.getReportImage()!=null&&!pBean.getReportImage().equals("")){%>
    		<a href="javascript:down('<%=pBean.getReportImage()%>')"><%=pBean.getReportImage()%></a>
    		
    	<%}else{out.println("첨부된 파일이 없습니다.");}%></div>
				<div class="bb">
				<%if(pBean.getReportCheck()==1){
					
				%>
				<input class="zz"type="button" value="처리완료" onclick="chTr(<%=pBean.getReportNum() %>)"/>
				
				<%}else{ %>
				<input style="display:none;"type="button" value="처리완료" />
				<%} %>
				</div>
				<input type="hidden" name="reportNum" value="<%=pBean.getReportNum() %>"/>
				</div>
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
<form name="listFrm" method="post">
		<input type="hidden" name="reload" value="true"> 
		<input type="hidden" name="nowPage" value="1">
	</form>

	<form name="readFrm">
		<input type="hidden" name="nowPage" value="<%=nowPage%>"> 
		<input type="hidden" name="numPerPage" value="<%=numPerPage%>"> 
		<input type="hidden" name="keyWord" value="<%=keyWord%>"> 
	</form>
	<form method="post" name="downFrm" action="M_download.jsp">
	<input type="hidden" name="reportImage">
</form>
	<script>
	function pageing(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	function numPerFn() {
		if(document.npFrm.keyWord.value=="0"){
			location.href="M_reportList.jsp?nowPage=1&numPerPage=<%=numPerPage%>&keyWord=0";
		}else if(document.npFrm.keyWord.value=="1"){
			location.href="M_reportList.jsp?nowPage=1&numPerPage=<%=numPerPage%>&keyWord=1";
		}else if(document.npFrm.keyWord.value=="2"){
			location.href="M_reportList.jsp?nowPage=1&numPerPage=<%=numPerPage%>&keyWord=2";
		}
/* 		document.npFrm.submit(); */
	}
	function seeTr(a) {
		status = $("#hidden"+a).css('display');
		//dh = $("#dh"+a).css('display');
		
		if(status=="none"){
			$("#hidden"+a).css('display','');
			document.getElementById('button'+a).value="감추기";
			
		}else{
			$("#hidden"+a).css('display','none');
			document.getElementById('button'+a).value="보이기";
			
		}

	}
	function down(reportImage) {
		document.downFrm.reportImage.value=reportImage;
		document.downFrm.submit();
	}
	function chTr(a){
		
		location.href="M_reportUpdateProc.jsp?reportNum="+a;
	}
	
	</script>
</body>
</html>
