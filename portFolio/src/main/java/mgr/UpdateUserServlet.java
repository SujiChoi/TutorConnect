package mgr;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/UpdateUser")
public class UpdateUserServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		UserMgr mgr=new UserMgr();
		String msg="정보 수정 실패";
		String url="updateUser.jsp";
		if(mgr.updateUser(request)) {
			msg="정보 수정 성공";
		}
		PrintWriter out=response.getWriter();
		out.println("<script>");
		out.println("alert('"+msg+"');");
		out.println("location.href='"+url+"'");
		out.println("</script>");
	}

}
