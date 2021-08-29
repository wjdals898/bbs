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
		if( userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		if( userID == ""){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 아이디입니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
		User user = new UserDAO().getUser(userID);
		if(!userID.equals(user.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
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
	  			<li><a href="privacy.jsp">개인정보</a></li>
	  			<li class="active"><a href="privacyUpdate.jsp">개인정보 수정</a></li>
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
	  					<li><a href="privacy.jsp">개인정보</a></li>
	  					<li><a href="#">친구관리</a></li>
	  					<li><a href="search.jsp">친구검색</a>
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
					<form method="post" action="privacyUpdateAction.jsp?userID="<%= userID %>">
						<table class="table table-striped" style="text-align:centrt;">
							<thead>
								<tr>
									<th colspan="2" style="background-color : #eeeeee; text-align: center;">개인정보 수정 양식</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="width: 20%;">아이디</td>
									<td colspan="2"><%= user.getUserID() %></td>
								</tr>
								<tr>
									<td style="width: 20%;">비밀번호</td>
									<td colspan="2"><%= user.getUserPassword() %></td>
								</tr>
								<tr>
									<td style="width: 20%;">이름</td>
									<td colspan="2">
									<input type="text" class="form-control" placeholder="이름" name="userName" maxlength="20" value="<%= user.getUserName() %>" >
									</td>
								</tr>
								<tr>
									<td style="width: 20%;">성별</td>
									<td colspan="2">
									<!--  
									<input type="text" class="form-control" placeholder="성별" name="userGender" maxlength="20" value="<%= user.getUserGender() %>" >
									-->
										<div class="btn-group" data-toggle="buttons">
											<label class="btn btn-primary active">
												<input type="radio" name="userGender" autocomplete="off" value="남자">남자
											</label>
											<label class="btn btn-primary">
												<input type="radio" name="userGender" autocomplete="off" value="여자" >여자
											</label>
										</div>
									</td>
								</tr>
								<tr>
									<td style="width: 20%;">이메일</td>
									<td colspan="2">
									<input type="text" class="form-control" placeholder="이메일" name="userEmail" maxlength="20" value="<%= user.getUserEmail() %>" >
									</td>
								</tr>
								<tr>
									<td style="width: 20%;">전화번호</td>
									<td colspan="2">
									<input type="text" class="form-control" placeholder="전화번호" name="userPhone" maxlength="20" value="<%= user.getUserPhone() %>" >
									</td>
								</tr>
							</tbody>
						</table>
						<input type="submit" class="btn btn-primary pull-right" value="개인정보 수정">
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>