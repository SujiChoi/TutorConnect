<%@page contentType="application; charset=UTF-8"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="mgr.RootReportMgr"%>
<%
		request.setCharacterEncoding("UTF-8");
		try{
			String filename = request.getParameter("reportImage");
			File file = new File(RootReportMgr.SAVEFOLDER+
					File.separator+filename);
			byte b[] = new byte[(int)file.length()];
			
			response.setHeader("Accept-Ranges", "bytes");
			String strClient = request.getHeader("User-Agent");
			if (strClient.indexOf("Trident") > 0 || strClient.indexOf("MSIE") > 0) {
				response.setContentType("application/smnet;charset=UTF-8");
				response.setHeader("Content-Disposition", "filename="
				+ new String(filename.getBytes("UTF-8"),"8859_1") + ";");
			} else {
				response.setContentType("application/smnet;charset=UTF-8");
				response.setHeader("Content-Disposition",
						"attachment;filename=" 
				+ new String(filename.getBytes("UTF-8"),"ISO-8859-1") + ";");
			}
			out.clear();
			if (file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(
						new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(
						response.getOutputStream());
				int read = 0;
				while ((read = fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}
				outs.close();
				fin.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
%>