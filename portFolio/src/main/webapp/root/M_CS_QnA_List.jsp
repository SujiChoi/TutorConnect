<!-- UtilMgr 임포트 teamproject에서는 안됨!!!!! -->
<%@page import="bean.QNABean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mgr" class="mgr.QnaMgr"/>
<%
	request.setCharacterEncoding("UTF-8");
		
	int totalRecord = 0;
	int numPerPage = 15;//페이지당 레코드 개수
	int pagePerBlock = 15;//블럭당 페이지 개수
	int totalPage = 0;//총 페이지 개수
	int totalBlock = 0;//총 블럭 개수
	int nowPage = 1;//현재 페이지
	int nowBlock = 1;//현재 블럭
	
	//검색에 필요한 변수
	String keyField = "", keyWord = "";
	//검색일때
	if(request.getParameter("keyWord")!=null){
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	
	totalRecord = mgr.getTotalCount(keyField, keyWord);
	
	if(request.getParameter("nowPage")!=null){
		nowPage = Integer.parseInt(request.getParameter("nowPage"));
	}
	
	int start = (nowPage*numPerPage)-numPerPage;
	
	totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
	totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
	nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>QnA 리스트</title>
    <script src="resources/js/includeHTML.js">
    
    </script>
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

      .menus2 {
        text-align: left;
        width: 150px;
        margin-top: 20px;
      }
      .menus2 > a {
        font-size: 30px;
        font-weight: 800;
        color: black;
      }
      .menus3 {
        text-align: left;
        width: 150px;
        margin-top: 20px;
      }
      .menus3 > a {
        font-size: 30px;
        font-weight: 800;
        color: black;
      }
      #myPageMenu2 {
        width: 180px;
        height: 600px;
      }
      #myPageContents {
        width: 920px;
        height: 600px;
      }
      table {
      	margin: 0px 0px 20px 0px;
      }
      table, td {
      	border-collapse: collapse; 
      	
      }
      #btn {
      	display: inline-block;
	    padding: .5em .75em;
	    color: #fff;
	    font-size: inherit;
	    line-height: normal;
	    vertical-align: middle;
	    background-color: #58c189;
	    cursor: pointer;
	    border: 1px solid #ebebeb;
	    border-bottom-color: #e2e2e2;
	    border-radius: .25em;
      }
      #btn1 {
      	display: inline-block;
	    padding: .3em .5em;
	    color: #fff;
	    font-size: small;
	    line-height: normal;
	    vertical-align: middle;
	    background-color: #58c189;
	    cursor: pointer;
	    border: 1px solid #ebebeb;
	    border-bottom-color: #e2e2e2;
	    border-radius: .25em;
      }
      #inqtitle {
      	color: black;
      	font-size: 16px;
      }
      th {
      	background-color: #dbdbdb;
      	text-align: center;
      }
       a.up{
		color:darkgrey;
		}
       .review {
        border-radius: 6px;
        padding: 20px;        
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
    </style>
    <script>
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
	function paging(page) {
		document.readFrm.nowPage.value = page;
		document.readFrm.submit();
	}
	function block(block) {
		document.readFrm.nowPage.value = <%=pagePerBlock%>*(block-1)+1;
		document.readFrm.submit();
	}
	function qnaDetail(inqNum) {
		document.detail.inqNum.value=inqNum;
		document.detail.submit();
		}
	function showQnA(inqNum, fromNum, secret, depth) {
		userNum = document.detail.userNum.value;
		if(secret=="1"&&depth==1&&fromNum!=userNum) alert("비밀글은 작성자만 열람 가능");  
		else if(depth==1) location.href='M_CS_QnA_Show.jsp?inqNum='+inqNum;
		else if(secret=="1"&&fromNum!=userNum) alert("비밀글은 작성자만 열람 가능");  
		else if(fromNum==userNum) location.href='M_CS_QnA_Show.jsp?inqNum='+inqNum;
		else location.href='M_CS_QnA_Show.jsp?inqNum='+inqNum;  
	}
	/* function updateQnA(inqNum, fromNum , secret, depth) { 
		userNum = document.detail.userNum.value;
		if(depth==1) location.href='CS_QnA_Read.jsp?inqNum='+inqNum;
		else if(secret=="1"&&fromNum!=userNum) alert("비밀글은 작성자만 열람 가능");  
		else if(fromNum==userNum) location.href='CS_QnA_Update.jsp?inqNum='+inqNum;
		else location.href='CS_QnA_Read.jsp?inqNum='+inqNum;  
	} */
	function check() {
		if(document.searchFrm.keyWord.value==""){
			alert("검색어를 입력하세요.");
			document.searchFrm.keyWord.focus();
			return;
		}
		document.searchFrm.submit();
	}
    </script>
  </head>
  <body>
    <header><%@ include file="M_header.jsp" %></header>
    <div id="contentWrap">
      <div id="myPageMids" align="center">
        <div id="myPageContents">
          <div id="myPageContent">
			<h2 align="left" style="margin:0px;">Q&A</h2>
				<br>
				
<!-- 게시물 번호 Start -->
<%
	Vector<QNABean> vlist = mgr.getQnaList(keyField, keyWord, start);
	int listSize = vlist.size();
	if(vlist.isEmpty()){
		%>
		 <div align="center" class="review" style="background:rgb(243, 243, 243); margin:0px 10%;">
     			<h1 style="text-align: center;">
					<span style="color:gray;">등록된</span>
					<span style="color:rgb(88, 193, 137);">Q&A가</span>
					<span style="color:gray;">없습니다.</span>
    			</h1>
 		</div> 
		<br>

		<%
	}else{
%>
<table>
	<tr class="trth">
		<th width="300px">작성일</th>
		<th width="70%">제목</th>
		<th width="10%">작성자</th>
	</tr>
	<%
		for(int i=0;i<numPerPage;i++){
			if(i==listSize) break;
			QNABean bean = vlist.get(i);
			String inqDate = bean.getInqDate();
			String inqTitle = bean.getInqTitle();
			int fromNum = bean.getFromNum();
			int InqNum = bean.getInqNum();
			int depth = bean.getDepth();
	%>
	<tr class="trtd" height="30px">
		<td style="text-align: center;"><%=inqDate %></td>
		<td style="padding-left: 20px;text-align:left">
		<%for(int j=0;j<depth;j++){out.println("&nbsp;&nbsp;&nbsp;&nbsp;>>");} %>
		<a id="inqtitle" href="javascript:showQnA('<%=bean.getInqNum() %>','<%=bean.getFromNum()%>','<%=bean.getSecret()%>', '<%=bean.getDepth()%>')">
		<%=inqTitle %></a></td> <!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
		<td style="text-align: center;"><%=fromNum %></td>
	</tr>
	<%} //for %> 
</table>
<!-- 게시물 번호 End>
<!-- 페이징 및 블럭 Start -->
<table>
<tr>
	<td>
	<%if(totalPage>0){ %>
	<!-- 이전 블럭 -->
	<%if(nowBlock>1){ %>
		<a href="javascript:block('<%=nowBlock-1%>')">PREV</a>
	<%} %>
	<!-- 페이지 -->
	<%
		int pageStart = (nowBlock-1)*pagePerBlock+1;
		int pageEnd = (pageStart+pagePerBlock)<totalPage?pageStart+pagePerBlock:totalPage+1;
		for(;pageStart<pageEnd;pageStart++){
	%>
		<a class="up" href="javascript:paging('<%=pageStart%>')">
		<%if(nowPage==pageStart){%><font color="#00CC66"><%}%>
		<%=pageStart%>
		<%if(nowPage==pageStart){%></font><%}%>
		</a>
	<%		
		}
	%>
	<!-- 다음 블럭 -->
	<%if(totalBlock>nowBlock){ %>
		<a href="javascript:block('<%=nowBlock+1%>')">NEXT</a>
	<%} %>
	<%} %> <!-- if(totalPage>0) -->
	</td>
</tr>
</table>
<%} //if-else %>
<!-- 페이징 및 블럭 End -->
				<form  name="searchFrm">
					<table  width="600" cellpadding="4" cellspacing="0">
				 		<tr>
				  			<td align="center" valign="bottom">
				   				<select style="height: 23px" name="keyField" size="1" >
				    				<option value="fromNum"> 작성자</option>
				    				<option value="inqTitle"> 제목</option>
				   				</select>
				   				<input style="height: 23px" size="16" name="keyWord">
				   				<input id="btn1" type="button"  value="찾기" onClick="javascript:check()">
				   				<input id="btn1" type="button"  value="리셋" onClick="javascript:location.href='M_CS_QnA_List.jsp'">
				   				<input type="hidden" name="nowPage" value="1">
				  			</td>
				 		</tr>
					</table>
				</form>
				<form name="readFrm">
					<input type="hidden" name="totalRecord" value="<%=totalRecord%>">
					<input type="hidden" name="nowPage" value="<%=nowPage%>">
					<input type="hidden" name="keyField" value="<%=keyField%>">
					<input type="hidden" name="keyWord" value="<%=keyWord%>">
				</form>
				<form name="detail" method="post">
					<input type="hidden" name="userNum" value="<%=userNum%>">
				</form>
				<br>
			</div>
        </div>
      </div>
    </div><!-- id="contentWrap" -->
  </body>
</html>
