<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="rereply.ReReplyDAO" %>
<%@ page import="rereply.ReReply" %>
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
			script.println("alert('유효하지 않은 댓글입니다')");
			script.println("location.href = 'Userview.jsp?bbsID="+request.getParameter("bbsID")+"&rereplyID="+request.getParameter("rereplyID")+"'");
			script.println("</script>");
		}
		ReReply rereply = new ReReplyDAO().getReReply(rereplyID);
		if(!userID.equals(rereply.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'Userbbs.jsp'");
			script.println("</script>");
		} else {
			if(request.getParameter("rereplyContent") == null)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				ReReplyDAO rereplyDAO = new ReReplyDAO();
				int result = rereplyDAO.update(rereplyID, request.getParameter("rereplyContent"));
				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('대댓글 수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");	
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'Userview.jsp?bbsID="+request.getParameter("bbsID")+"'");
					script.println("</script>");		
					}
			}
		}

	%>
</body>
</html>