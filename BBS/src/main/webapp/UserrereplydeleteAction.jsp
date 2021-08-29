<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="rereply.ReReply" %>
<%@ page import="rereply.ReReplyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if( userID == null ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int rereplyID = 0;
		if(request.getParameter("rereplyID") != null){
			rereplyID = Integer.parseInt(request.getParameter("rereplyID"));
		}
		if(rereplyID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href = 'Userview.jsp?bbsID="+request.getParameter("bbsID")+"'");
			script.println("</script>");
		}
		ReReply rereply = new ReReplyDAO().getReReply(rereplyID);
		if(!userID.equals(rereply.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'Userview.jsp?bbsID="+request.getParameter("bbsID")+"'");
			script.println("</script>");
		} else {
				ReReplyDAO rereplyDAO = new ReReplyDAO();
				int result = rereplyDAO.delete(rereplyID);
				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 삭제에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");	
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'Userview.jsp?bbsID="+request.getParameter("bbsID")+"'");
					script.println("</script>");		
					}
		}
		

	%>
</body>
</html>