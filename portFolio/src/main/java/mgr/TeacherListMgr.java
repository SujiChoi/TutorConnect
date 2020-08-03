package mgr;

import java.sql.Connection;
import java.util.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Vector;
import javax.servlet.http.HttpServletRequest;
import bean.TeacherBean;
import bean.UserBean;

public class TeacherListMgr { 
	
	private DBConnectionMgr pool;
	
	public TeacherListMgr() {
		pool = DBConnectionMgr.getInstance(); 
	}
	 
	//Teacher List : 페이지당 보여줄 갯수만 리턴, 검색 포함.
	//keyField : 선택옵션(name, subject, content)
	//keyWord : 검색어
	//start : 시작번호, cnt : 한 페이지당 가져올 게시물 개수 
	
	
		//Teacher List : 페이지당 보여줄 갯수만 리턴, 검색 포함.
		//keyField : 선택옵션(name, subject, content)
		//keyWord : 검색어
		//start : 시작번호, cnt : 한 페이지당 가져올 게시물 개수 
		
		public Vector<TeacherBean> getTeacherList1(HttpServletRequest req,String keyWord,int start, int cnt){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			
			Vector<TeacherBean> tlist = new Vector<TeacherBean>();
			
			try {
				con = pool.getConnection();
				
				boolean flag=true;
				
				// 첫페이지, 닉네임 검색
				if(req.getParameterValues("area")==null) {
					flag = false;
				}
				
				//조건 검색 
				if(flag==true) {
				//request 요구조건
					
					String[] area = req.getParameterValues("area");
					String area1 = "";
					
					String checkall = area[0].substring(2);
					String checkarea = area[0].substring(0,2);
					if(checkall.equals("전체")) {
						for(int i =0; i<area.length;i++){
							area1 += "tArea1 like '%" + checkarea+"%' or tArea2 like '%"+checkarea + "%' or tArea3 like '%" + checkarea+"%'"+" or ";
						}
					}else {
					
						for(int i =0; i<area.length;i++){
							area1 += "tArea1 like '%" + area[i]+"%' or tArea2 like '%"+area[i] + "%' or tArea3 like '%" + area[i]+"%'"+" or ";
						}
					}
					area1 = area1.substring(0, area1.length()-4);

					//tArea1=서울용산구 or tArea2=서울용산구 or tArea3=서울용산구 or tArea1=서울마포구 or tArea2=서울마포구 or tArea3=서울마포구

					//희망과목
					String[] subject = req.getParameterValues("subject");
					String subject1 ="";
										
					for(int i =0; i<subject.length;i++){
						subject1 += "tSubject1 like '%"+subject[i]+"%' or tSubject2 like '%"+subject[i]+"%' or tSubject3 like '%"+subject[i]+"%' or " ;}
					
					subject1 = subject1.substring(0, subject1.length()-4);

					//과외비 불러오기
					
					String fbtn = req.getParameter("fbtn").substring(0, 2);
					String tfee = "";
					if(!fbtn.equals("협의")) tfee =" and t2.tFee<="+fbtn;
					
					//and t2.tFee<=30
					
					//성별 불러오기
					String gbtn = req.getParameter("gbtn");
					if(gbtn.equals("남자")) gbtn=" and t1.userGender=1";
					else if(gbtn.equals("여자")) gbtn=" and t1.userGender=2";
					else if(gbtn.equals("전체")) gbtn="";

					//and t1.userGender=1			
					
					//희망횟수
					
					String dbtn = req.getParameter("dbtn");
					String dcount ="";
					if(!dbtn.equals("협의")) dcount = " and t2.tDay='"+dbtn+"'"; 
					// t2.tDay='주2회'
					
					//과외시간
					String tbtn = req.getParameter("tbtn");
					String tbtn1 ="";
					if(!tbtn.equals("시간무관")) tbtn1=" and t2.tTime='"+tbtn+"'";
					
					//교습 대상
					String tobj = req.getParameter("tobj");
					String tgrade = "";
					if(tobj=="초등학생"){tgrade = " and t2.tRange=1";}
					else if(tobj=="중학생"){tgrade = " and t2.tRange=2";}
					else if(tobj=="고등학생"){tgrade = " and t2.tRange=3";}
					else if(tobj=="대학생"){tgrade = " and t2.tRange=4";}
					else if(tobj=="성인"){tgrade = " and t2.tRange=5";}
					else if(tobj=="전체"){tgrade = " and t2.tRange=6";}
					
					//연령 19910327 20
					
					SimpleDateFormat format = new SimpleDateFormat ( "yyyy");
					Date time = new Date();
					int now = Integer.parseInt(format.format(time));
					
					int Astart = Integer.parseInt(req.getParameter("Astart"));

					int Aend = Integer.parseInt(req.getParameter("Aend"));
					
					Astart = now -Astart;
					Aend = now-Aend;
					
					//성별 불러오기

					//and t1.userGender=1
					
					sql = "SELECT t1.userNum,t3.tImage, t3.tNickname, userGender, userBirth, t3.tRecord, t3.tSubject1, t3.tSubject2, t3.tSubject3, t3.tDay, t3.tTime, t3.tArea1, t3.tArea2, t3.tArea3"
							+ " from tbluser t1 ,"
							+ " (select * from tblteacher where "+ area1+") t2,"
							+ " (select * from tblteacher where "+ subject1+") t3 "
							+ " WHERE t1.userNum=t2.userNum AND t1.userNum=t3.userNum "
							+tfee+ gbtn+dcount+tbtn1+tgrade + " AND CAST(SUBSTRING(t1.userBirth,1,4) AS SIGNED integer) BETWEEN " + Aend+ " AND " + Astart + " limit ?,?";
							
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);

				
				//검색하기
				}//if
				
				//처음 접속했을때 페이지
				else if(keyWord.trim().equals("")||keyWord==null) {
					//검색이 아닌경우
					sql = "select tbluser.userNum,tImage, tNickname, userGender, tRecord, tSubject1, tSubject2, tSubject3, tDay, tTime, tArea1, tArea2, tArea3 from tblteacher,tbluser where tblteacher.userNum = tbluser.userNum limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);
					}
				
				//닉네임으로 검색할때
				else if(flag == false){
						//검색인 경우
						sql = "select tbluser.userNum,tImage, tNickname, userGender, tRecord, tSubject1, tSubject2, tSubject3, tDay, tTime, tArea1, tArea2, tArea3 from tblteacher,tbluser where tblteacher.userNum = tbluser.userNum and tNickname like ? limit ?,?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, "%"+keyWord+"%");
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					}
				
				rs = pstmt.executeQuery();
				while(rs.next()) {
					TeacherBean tbean = new TeacherBean();
					
					tbean.setUserNum(rs.getInt("userNum"));
					tbean.settImage(rs.getString("tImage"));
					tbean.settNickname(rs.getString("tNickname"));
					tbean.settRecord(rs.getString("tRecord"));
					tbean.settSubject1(rs.getString("tSubject1"));
					tbean.settSubject2(rs.getString("tSubject2"));
					tbean.settSubject3(rs.getString("tSubject3"));
					tbean.settDay(rs.getString("tDay"));
					tbean.settTime(rs.getString("tTime"));
					tbean.settArea1(rs.getString("tArea1"));
					tbean.settArea2(rs.getString("tArea2"));
					tbean.settArea3(rs.getString("tArea3"));
					
					tlist.addElement(tbean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return tlist;
		}	
	
	
		public int getTotalCount1(Vector<TeacherBean> tlist) {
			return tlist.size();
		}
	
//회원 Total Count : 총 회원수
			public int getTotalCount(HttpServletRequest req,String keyWord) {
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				int totalCount = 0;
				
				//수정시작
				
				Vector<TeacherBean> tlist = new Vector<TeacherBean>();
				try {
					con = pool.getConnection();
					
					boolean flag=true;

					if(req.getParameterValues("area")==null) {
						flag = false;
					}
					if(flag==true) {
						//request 요구조건
						String[] area = req.getParameterValues("area");
						String area1 = "where";
						String area11 = area[0].substring(2, area[0].length());
						String area12 = area[0].substring(0, 2);

						if(area11.equals("전체")) {
							area1 += " tArea1 like '%"+area12+"%'";
						}else {
							for(int i =0; i<area.length;i++){			
								area1 += " tArea1='"+area[i]+"' or "+"tArea2='"+area[i]+ "' or "+"tArea3='"+area[i] +"' or ";
							}
							area1 = area1.substring(0, area1.length()-4);
						}
						


						//tArea1=서울용산구 or tArea2=서울용산구 or tArea3=서울용산구 or tArea1=서울마포구 or tArea2=서울마포구 or tArea3=서울마포구
						
						//희망과목
						String[] subject = req.getParameterValues("subject");
						String subject1 ="";
											
						for(int i =0; i<subject.length;i++){
							subject1 += " tSubject1='"+subject[i]+"' or "+"tSubject2='"+subject[i]+"' or "+"tSubject3='"+subject[i]+"' or " ;}
						
						subject1 = subject1.substring(0, subject1.length()-4);

						//과외비 불러오기
						
						String fbtn = req.getParameter("fbtn").substring(0, 2);
						String tfee = "";
						if(!fbtn.equals("협의")) tfee =" and t2.tFee<="+fbtn;
						
						//and t2.tFee<=30
						
						//성별 불러오기
						String gbtn = req.getParameter("gbtn");
						if(gbtn.equals("남자")) gbtn=" and t1.userGender=1";
						else if(gbtn.equals("여자")) gbtn=" and t1.userGender=2";
						else if(gbtn.equals("전체")) gbtn="";

						//and t1.userGender=1			
						
						//희망횟수
						
						String dbtn = req.getParameter("dbtn");
						String dcount ="";
						if(!dbtn.equals("협의")) dcount = " and t2.tDay='"+dbtn+"'"; 
						// t2.tDay='주2회'
						
						//과외시간
						String tbtn = req.getParameter("tbtn");
						String tbtn1 ="";
						if(!tbtn.equals("시간무관")) tbtn1=" and t2.tTime='"+tbtn+"'";
						
						//교습 대상
						String tobj = req.getParameter("tobj");
						String tgrade = "";
						if(tobj=="초등학생"){tgrade = " and t2.tRange=1";}
						else if(tobj=="중학생"){tgrade = " and t2.tRange=2";}
						else if(tobj=="고등학생"){tgrade = " and t2.tRange=3";}
						else if(tobj=="대학생"){tgrade = " and t2.tRange=4";}
						else if(tobj=="성인"){tgrade = " and t2.tRange=5";}
						else if(tobj=="전체"){tgrade = " and t2.tRange=6";}
						
						SimpleDateFormat format = new SimpleDateFormat ( "yyyy");
						Date time = new Date();
						int now = Integer.parseInt(format.format(time));
						
						int Astart = Integer.parseInt(req.getParameter("Astart"));

						int Aend = Integer.parseInt(req.getParameter("Aend"));
						
						Astart = now -Astart;
						Aend = now-Aend;
						
						//성별 불러오기

						//and t1.userGender=1
						
						sql = "SELECT count(*) "
								+ " from tbluser t1 ,(select * from tblteacher "+ area1+") t2,"
								+ " (select * from tblteacher where "+ subject1+") t3 "
								+ " WHERE t1.userNum=t2.userNum AND t1.userNum=t3.userNum "
								+tfee+ gbtn+dcount+tbtn1+tgrade + " AND CAST(SUBSTRING(t1.userBirth,1,4) AS SIGNED integer) BETWEEN " + Aend+ " AND " + Astart;
						
						
						//수정끝

		
						pstmt = con.prepareStatement(sql);

					//검색하기
					}//if
					else if(keyWord.trim().equals("")||keyWord==null) {
						//검색이 아닌경우
						sql = "select count(*) from tblteacher,tbluser where tblteacher.userNum = tbluser.userNum";
						pstmt = con.prepareStatement(sql);

						}else if(flag == false){
							//검색인 경우
							sql = "select count(*) from tblteacher,tbluser where tblteacher.userNum = tbluser.userNum and tNickname like ?";
							pstmt = con.prepareStatement(sql);
							pstmt.setString(1, "%"+keyWord+"%");

						}
	
					rs = pstmt.executeQuery();
					if(rs.next()) totalCount = rs.getInt(1);
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return totalCount;
			}
		
	
		
		public Vector<UserBean> getUserList(HttpServletRequest req,String keyWord,int start, int cnt){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<UserBean> ulist = new Vector<UserBean>();
			
			try {
				con = pool.getConnection();
				
				boolean flag=true;
				
				// 첫페이지, 닉네임 검색
				if(req.getParameterValues("area")==null) {
					flag = false;
				}
				
				//조건 검색 
				if(flag==true) {
				//request 요구조건
					
					String[] area = req.getParameterValues("area");
					String area1 = "";
					String checkall = area[0].substring(2);
					String checkarea = area[0].substring(0,2);
					if(checkall.equals("전체")) {
						for(int i =0; i<area.length;i++){
							area1 += "tArea1 like '%" + checkarea+"%' or tArea2 like '%"+checkarea + "%' or tArea3 like '%" + checkarea+"%'"+" or ";
						}
					}else {
					
						for(int i =0; i<area.length;i++){
							area1 += "tArea1 like '%" + area[i]+"%' or tArea2 like '%"+area[i] + "%' or tArea3 like '%" + area[i]+"%'"+" or ";
						}
					}
					area1 = area1.substring(0, area1.length()-4);

					//tArea1=서울용산구 or tArea2=서울용산구 or tArea3=서울용산구 or tArea1=서울마포구 or tArea2=서울마포구 or tArea3=서울마포구

					//희망과목
					String[] subject = req.getParameterValues("subject");
					String subject1 ="";
										
					for(int i =0; i<subject.length;i++){
						subject1 += "tSubject1 like '%"+subject[i]+"%' or tSubject2 like '%"+subject[i]+"%' or tSubject3 like '%"+subject[i]+"%' or " ;}
					
					subject1 = subject1.substring(0, subject1.length()-4);

					//과외비 불러오기
					
					String fbtn = req.getParameter("fbtn").substring(0, 2);
					String tfee = "";
					if(!fbtn.equals("협의")) tfee =" and t2.tFee<="+fbtn;
					
					//and t2.tFee<=30
					
					//성별 불러오기
					String gbtn = req.getParameter("gbtn");
					if(gbtn.equals("남자")) gbtn=" and t1.userGender=1";
					else if(gbtn.equals("여자")) gbtn=" and t1.userGender=2";
					else if(gbtn.equals("전체")) gbtn="";

					//and t1.userGender=1			
					
					//희망횟수
					
					String dbtn = req.getParameter("dbtn");
					String dcount ="";
					if(!dbtn.equals("협의")) dcount = " and t2.tDay='"+dbtn+"'"; 
					// t2.tDay='주2회'
					
					//과외시간
					String tbtn = req.getParameter("tbtn");
					String tbtn1 ="";
					if(!tbtn.equals("시간무관")) tbtn1=" and t2.tTime='"+tbtn+"'";
					
					//교습 대상
					String tobj = req.getParameter("tobj");
					String tgrade = "";
					if(tobj=="초등학생"){tgrade = " and t2.tRange=1";}
					else if(tobj=="중학생"){tgrade = " and t2.tRange=2";}
					else if(tobj=="고등학생"){tgrade = " and t2.tRange=3";}
					else if(tobj=="대학생"){tgrade = " and t2.tRange=4";}
					else if(tobj=="성인"){tgrade = " and t2.tRange=5";}
					else if(tobj=="전체"){tgrade = " and t2.tRange=6";}
					
					//연령 19910327 20
					
					SimpleDateFormat format = new SimpleDateFormat ( "yyyy");
					Date time = new Date();
					int now = Integer.parseInt(format.format(time));
					
					int Astart = Integer.parseInt(req.getParameter("Astart"));

					int Aend = Integer.parseInt(req.getParameter("Aend"));
					
					Astart = now -Astart;
					Aend = now-Aend;
					
					//성별 불러오기

					//and t1.userGender=1
					
					sql = "SELECT t1.userNum,t3.tImage, t3.tNickname, userGender, userBirth, t3.tRecord, t3.tSubject1, t3.tSubject2, t3.tSubject3, t3.tDay, t3.tTime, t3.tArea1, t3.tArea2, t3.tArea3"
							+ " from tbluser t1 ,"
							+ " (select * from tblteacher where "+ area1+") t2,"
							+ " (select * from tblteacher where "+ subject1+") t3 "
							+ " WHERE t1.userNum=t2.userNum AND t1.userNum=t3.userNum "
							+tfee+ gbtn+dcount+tbtn1+tgrade + " AND CAST(SUBSTRING(t1.userBirth,1,4) AS SIGNED integer) BETWEEN " + Aend+ " AND " + Astart + " limit ?,?";
							
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);

				
				//검색하기
				}//if
				
				//처음 접속했을때 페이지
				else if(keyWord.trim().equals("")||keyWord==null) {
					//검색이 아닌경우
					sql = "select tbluser.userNum,tImage, tNickname, userGender, tRecord, tSubject1, tSubject2, tSubject3, tDay, tTime, tArea1, tArea2, tArea3 from tblteacher,tbluser where tblteacher.userNum = tbluser.userNum limit ?,?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, start);
					pstmt.setInt(2, cnt);
					}
				
				//닉네임으로 검색할때
				else if(flag == false){
						//검색인 경우
						sql = "select tbluser.userNum,tImage, tNickname, userGender, tRecord, tSubject1, tSubject2, tSubject3, tDay, tTime, tArea1, tArea2, tArea3 from tblteacher,tbluser where tblteacher.userNum = tbluser.userNum and tNickname like ? limit ?,?";
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, "%"+keyWord+"%");
						pstmt.setInt(2, start);
						pstmt.setInt(3, cnt);
					}
				rs = pstmt.executeQuery();
				while(rs.next()) {
					UserBean ubean = new UserBean();
					
					ubean.setUserNum(rs.getInt("userNum"));
					ubean.setUserGender(rs.getString("userGender"));
					
					ulist.addElement(ubean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return ulist;
		}
		
}
