<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="reply.Reply" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
		int bbsID=Integer.parseInt(request.getParameter("bbsID"));
		if(request.getParameter("replyID") != null){
			replyID = Integer.parseInt(request.getParameter("replyID"));
		}
		if(replyID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다')");
			script.println("location.href = 'view.jsp?bbsID="+bbsID+"'");
			script.println("</script>");
		}
		Reply reply = new ReplyDAO().getReply(replyID);
		ReplyDAO replyDAO = new ReplyDAO();
		int result = replyDAO.RecommendCountup(replyID);
		if(result == -1 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글 추천에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");	
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'view.jsp?bbsID="+request.getParameter("bbsID")+"'");
			script.println("</script>");		
			}
	%>
</body>
</html>