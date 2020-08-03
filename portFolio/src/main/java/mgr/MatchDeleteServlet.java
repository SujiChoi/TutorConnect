package mgr;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/MatchDelete")
public class MatchDeleteServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		MatchMgr mgr=new MatchMgr();
		int userNum1=Integer.parseInt(request.getParameter("fromNum"));
		int userNum2=Integer.parseInt(request.getParameter("toNum"));
		if(mgr.isMatched(userNum1, userNum2)) {
			mgr.matchCancle(userNum2, userNum1); 
		}
		mgr.matchCancle(userNum1, userNum2);
		PrintWriter out=response.getWriter();
		out.println("<script>");
		out.println("alert('삭제 완료');");
		out.println("location.href='wishList.jsp'");
		out.println("</script>");
	}

}
