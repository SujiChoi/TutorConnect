package mgr;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import bean.TeacherBean;

/**
 * Servlet implementation class TeacherUpdateServlet
 */
@WebServlet("/TeacherUpdate")
public class TeacherUpdateServlet extends HttpServlet {
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	
				request.setCharacterEncoding("UTF-8");
				response.setContentType("text/html; charset=UTF-8");
				HttpSession session = request.getSession();
				TeacherBean tbean = (TeacherBean)session.getAttribute("tbean");		
//				int userNum = Integer.parseInt(request.getParameter("userNum"));
				
				MultipartRequest multi = 
						new MultipartRequest(request,TeacherMgr.saveFolder,
								TeacherMgr.maxSize,TeacherMgr.ENCTYPE,
								new DefaultFileRenamePolicy());
				int userNum = Integer.parseInt(multi.getParameter("userNum"));
				TeacherMgr tmgr = new TeacherMgr();
				tmgr.teacherupdate(multi);
				
				
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out=response.getWriter();
				out.println("<script>");
				out.println("alert('선생님 수정 완료');");
				out.println("location.href='updateTeacher.jsp'");
				out.println("</script>");

				
		
	}

}