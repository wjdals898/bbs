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
			script.println("alert('�α����� �ϼ���.')");
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
			script.println("alert('��ȿ���� ���� ����Դϴ�')");
			script.println("location.href = 'view.jsp?bbsID="+bbsID+"'");
			script.println("</script>");
		}
		Reply reply = new ReplyDAO().getReply(replyID);
		ReplyDAO replyDAO = new ReplyDAO();
		int result = replyDAO.RecommendCountup(replyID);
		if(result == -1 ){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('��� ��õ�� �����߽��ϴ�')");
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