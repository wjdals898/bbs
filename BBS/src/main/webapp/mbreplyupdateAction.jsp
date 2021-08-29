<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.Reply" %>
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
		int replyID = 0;
		if(request.getParameter("replyID") != null){
			replyID = Integer.parseInt(request.getParameter("replyID"));
		}
		if(replyID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다')");
			script.println("location.href = 'mbview.jsp?bbsID="+request.getParameter("bbsID")+"&replyID="+request.getParameter("replyID")+"'");
			script.println("</script>");
		}
		Reply reply = new ReplyDAO().getReply(replyID);
		if(!userID.equals(reply.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'mybbs.jsp'");
			script.println("</script>");
		} else {
			if(request.getParameter("replyContent") == null)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				ReplyDAO replyDAO = new ReplyDAO();
				int result = replyDAO.update(replyID, request.getParameter("replyContent"));
				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");	
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'mbview.jsp?bbsID="+request.getParameter("bbsID")+"&replyID="+request.getParameter("replyID")+"'");
					script.println("</script>");		
					}
			}
		}

	%>
</body>
</html>