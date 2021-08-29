<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="reply" class="reply.Reply" scope="page" />
<jsp:setProperty name="reply" property="replyContent" />



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
		} else {
			if(reply.getReplyContent() == null)
			{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('내용을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>");
			} else{
				ReplyDAO replyDAO = new ReplyDAO();
				int result = replyDAO.write(Integer.parseInt(request.getParameter("bbsID")), userID, reply.getReplyContent());
				if(result == -1 ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");	
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'mbview.jsp?bbsID="+request.getParameter("bbsID")+"'");
					script.println("</script>");		
					}
			}
		}

	%>
</body>
</html>