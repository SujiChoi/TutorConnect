<%@ page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<html>
  <head>
    <title>우편번호 검색</title>
    <link href="resources/style.css" rel="stylesheet" type="text/css" />
    <style>
      td {
        text-align: center;
      }
      .zipform {
        margin: 0 auto;
        width: 500px;
      }
      .SearchButton {
        cursor: pointer;
        font-size: 20px;
        background-color: rgb(88, 193, 137);
        width: 70px;
        height: 40px;
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: 800;
      }
      .aclose {

        text-decoration: none;
        color: black;
        padding-left: 50px;
        width: 50%;
        height: 100px;
        
      }
      #closeid{
        padding-top: 0px;
        margin: 10px;

      }
    </style>

    <!-- <script type="text/javascript">
      function loadSearch() {
        frm = document.zipFrm;
        if (frm.area3.value == "") {
          alert("도로명을 입력하세요.");
          return;
        }
        frm.action = "zipSearch.jsp";
        frm.submit();
      }
      function sendAdd(zipcode, adds) {
        //alert(zipcode+adds);
        opener.document.regFrm.zipcode.value = zipcode;
        opener.document.regFrm.address.value = adds;
        self.close();
      }
    </script> -->
  </head>
  <body>
    <table style="width: 800px;">
      <br />
      <form class="zipform" name="zipFrm" method="post">
        <tr>
          
          <th>
                  
            지번/도로명 : 
                  <input type="text" name="" size="30"  style="height:30px;">
                  <!-- <input type="button" value="검색" onclick="loadSearch()"> -->
                 
                    <button class="SearchButton" onclick="" name="">
                     검색
                    </button>
                    </td>
          </tr>
          <!-- 검색 결과 Start -->

          <tr>
            <td>
              <br /><p style="text-align: center;"></p> 
              
              지역구 이름을 입력하세요.예) 용산구, 은평구, 중구 <br>
              <!-- 도로명주소(새주소) :
              도로명을 입력하세요.예) 중앙로, 불정로432번길</p> -->
            </td>
          </tr>

          <tr>
            <td>
              <%-- <a href="#" onclick="sendAdd('<%=zipcode%>','<%=adds%>')"> </a> --%>
            </td>
          </tr>

          <!-- 검색 결과 End -->
          <tr>
            <td>
              <br />
              <a href="#" class="aclose" onClick="self.close()"><p id="closeid">닫기</p></a>
            </td>
          </tr>
        </table>
        <input type="hidden" name="search" value="y" />
      </form>
    </div>
  </body>
</html>
