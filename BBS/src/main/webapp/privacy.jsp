<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >
<link rel="stylesheet" href="css/bootstrap.css" >
<link rel="stylesheet" href="css/custom.css" >
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if( userID == ""){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 아이디입니다')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		User user = new UserDAO().getUser(userID);
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
	  		<button type="button" class="navbar-toggle collapsed"
	  			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
	  			aria-expanded="false">
	  			<span class="icon-bar"></span>
	  			<span class="icon-bar"></span>
	  			<span class="icon-bar"></span>
	  		</button>
	  		<a class="navbar-brand" href="main.jsp">JSP 게시판 웹 사이트</a>
	  	</div>
	  	<%
	  		if(userID == null) {
	  	%>
	  	
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  		<ul class="nav navbar-nav">
	  			<li class="active"><a href="main.jsp">메인</a></li>
	  			<li><a href="bbs.jsp">전체 게시판</a></li>
	  		</ul>
	  	<%
	  		} else {
	  	%>
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  		<ul class="nav navbar-nav">
	  			<li><a href="main.jsp">메인</a></li>
	  			<li class="active"><a href="privacy.jsp">개인정보</a></li>
	  			<li><a href="bbs.jsp">전체 게시판</a></li>
	  			<li><a href="mybbs.jsp">마이 게시판</a></li> <!-- 개인 게시판 Mybbs.jsp예정 -->
	  			<li><a href="HOTbbs.jsp">핫 게시판</a></li> <!-- 핫 게시판 HOTbbs.jsp예정 -->
	  		</ul>
	  	<% 
	  		}
	  	%>
	  		<%
	  			if(userID == null) {
	  		%>
	  		<ul class="nav navbar-nav navbar-right">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  					data-toggle="dropdown" role="button" aria-haspopup="true"
	  					aria-expanded="false">접속하기<span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="login.jsp">로그인</a></li>
	  					<li><a href="join.jsp">회원가입</a></li>
	  				</ul>
	  			</li>
	  		</ul>
	  		<%
	  			} else {
	  				
			%>
			<ul class="nav navbar-nav navbar-right">
	  			<li class="dropdown">
	  				<a href="#" class="dropdown-toggle"
	  					data-toggle="dropdown" role="button" aria-haspopup="true"
	  					aria-expanded="false"><%= userID %>님의 회원관리<span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="logoutAction.jsp">로그아웃</a></li>
	  					<li class="active"><a href="privacy.jsp">개인정보</a></li>
	  					<li><a href="friendlist.jsp">친구관리</a></li>
	  					<li><a href="findFriend.jsp">친구검색</a>
	  				</ul>
	  			</li>
	  		</ul>
			<%
	  			}
			%>
	  	</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>개인정보</h1>
				<!-- 
				아이디 / 비번 / 성별 / 이메일 / 전화번호 -->
				<div class="row">
					<table class="table table-striped" style="text-align:center;">
						<tbody>
							<tr>
								<td style="width: 20%;">아이디</td>
								<td colspan="2"><%= user.getUserID() %></td>
							</tr>
							<tr>
								<td style="width: 20%;">비밀번호</td>
								<td colspan="2">********</td>
							</tr>
							<tr>
								<td style="width: 20%;">이름</td>
								<td colspan="2"><%= user.getUserName() %></td>
							</tr>
							<tr>
								<td style="width: 20%;">성별</td>
								<td colsapn="2"><%= user.getUserGender() %></td>
							</tr>
							<tr>
								<td style="width: 20%;">이메일</td>
								<td colspan="2"><%= user.getUserEmail() %></td>
							</tr>
							<tr>
								<td style="width: 20%;">전화번호</td>
								<td colspan="2"><%= user.getUserPhone() %></td>
							</tr>
						</tbody>
					</table>
				</div>
				<p>
					<a class="btn btn-primary btn-pull" href="privacyUpdate.jsp" role="button" onClick="alert('<%= userID %>님의 정보수정')">개인정보 수정</a>
					<a class="btn btn-primary btn-pull" role="button" onclick="return confirm('정말로 삭제하시겠습니까?')" href="privacyDeleteAction.jsp?userID=<%= userID %>">회원탈퇴</a>
				</p>
			</div>
		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>