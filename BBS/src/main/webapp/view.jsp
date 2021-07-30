<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<%@ page import="reply.Reply" %>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="rereply.ReReply" %>
<%@ page import="rereply.ReReplyDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1" >
<link rel="stylesheet" href="css/bootstrap.css" >
<title>JSP 게시판 웹 사이트</title>

</head>

<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int bbsID = 0;
		if(request.getParameter("bbsID") != null){
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if(bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
	  	<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	  		<ul class="nav navbar-nav">
	  			<li><a href="main.jsp">메인</a></li>
	  			<li class="active"><a href="bbs.jsp">게시판</a></li>
	  		</ul>
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
	  					aria-expanded="false">회원관리<span class="caret"></span></a>
	  				<ul class="dropdown-menu">
	  					<li><a href="logoutAction.jsp">로그아웃</a></li>
	  				</ul>
	  			</li>
	  		</ul>
			<%
	  			}
			%>
	  	</div>
	</nav>
	<!-- 게시글 쓰기 화면 -->
	<div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd" >
				<thead>
					<tr>
						<th colspan="3" style="background-color : #eeeeee; text-align: center;">게시판 글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("\n", "<br>").replaceAll("<", "&lt;").replaceAll(">", "&gt;") %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13) + "시" + bbs.getBbsDate().substring(14, 16)+"분"  %></td>
					</tr>
					<tr>
					<td>추천수</td>
					<td colspan="2"><%= bbs.getBbsRecommend() %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("\n", "<br>") %></td>
					</tr>
				</tbody>
			</table>
			<a href="bbs.jsp" class="btn btn-primary">목록</a>
			<a onClick="return alert('추천하였습니다.')" href="recommendAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">추천</a>
			<a onClick="return alert('작성자 페이지로 이동했음 좋겠네')" href="moveAction.jsp?userID=<%= bbs.getUserID() %>" class="btn btn-primary">작성자 페이지 이동</a>
			<%
				if(userID != null && userID.equals(bbs.getUserID())) {
			%>
				<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
				<a onClick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;  margin-top:17px;" >
				<thead>
					<tr>
						<td style="width: 15%;">댓글 작성 아이디</td>
						<td style="width:8%;">추천수</td>
						<td colspan="5">댓글 내용</td>
					</tr>
				</thead>
				<tbody>
					<%
						ReplyDAO replyDAO = new ReplyDAO();
						ArrayList<Reply> list = replyDAO.getList();
						ReReplyDAO rereplyDAO = new ReReplyDAO();
						ArrayList<ReReply> reList = rereplyDAO.getList();
						for(int i=0; i<list.size(); i++){
							if(bbsID==list.get(i).getBbsID()) {
								if(userID != null && userID.equals(list.get(i).getUserID())) {
					%>
					<tr>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getReplyRecommend() %>
						<td id="replyContent<%=i %>" class="reply-button<%= i %>" style="text-align:left;">
							<%= list.get(i).getReplyContent().replaceAll(" ","&nbsp;").replaceAll("\n", "<br>").replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>
						</td>
						<td class="reply-button<%= i %>" style="width:3%; padding-left:0; padding-right:0;">
							<a style="font-size:12px;" href="replyRecommendAction.jsp?bbsID=<%= bbsID %>&replyID=<%= list.get(i).getReplyID() %>" class="btn btn-secondary">추천</a>
						</td>
						<td style="width:3%; padding-left:0; padding-right:0;">
							<a id="replyBtn<%=i %>" style="font-size:12px;" class="btn btn-secondary">답글</a>
						</td>
						<td style="width:3%; padding-left:0; padding-right:0;">
							<a style="font-size:12px;" id="replyUpdate<%= i %>" class="btn btn-secondary">수정</a>
						</td>
						<td style="width:3%; padding-left:0; padding-right:0;">
							<a style="font-size:12px;" onclick="return confirm('정말로 삭제하시겠습니까?')" href="replyDeleteAction.jsp?replyID=<%= list.get(i).getReplyID() %>&bbsID=<%= bbsID %>" class="btn btn-secondary">삭제</a>
						</td>
					</tr>
					<tr id="fixReply<%= i %>" style="display:none; visibility:hidden;">
						<td></td>
						<td></td>
						<td colspan="5">
							<div>
								<form method="post" action="replyUpdateAction.jsp?bbsID=<%=bbsID %>&replyID=<%=list.get(i).getReplyID() %>">
									<div>
										<textarea id="fixReplyContent<%=i %>" class="form-control" name="replyContent" maxlength="1024" style="height:80px;"></textarea>
									</div>
									<div>
										<a href="view.jsp?bbsID=<%= bbsID %>" class="btn btn-primary pull-right" style="margin:5px;">취소</a>
									</div>
									<div>
										<input type="submit" class="btn btn-primary pull-right" value="수정" style="margin:5px;">
									</div>
								</form>
							</div>
						</td>
					</tr>
					
					<%
								}
								else {
					%>
					<tr>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getReplyRecommend() %>
						<td colspan="3" style="text-align:left;">
							<%= list.get(i).getReplyContent().replaceAll(" ","&nbsp;").replaceAll("\n", "<br>").replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>
						</td>
						<td style="width:3%; padding-left:0; padding-right:0;">
							<a style="font-size:12px;" href="replyRecommendAction.jsp?bbsID=<%= bbsID %>&replyID=<%= list.get(i).getReplyID() %>" class="btn btn-secondary">추천</a>
						</td>
						<td style="width:3%; padding-left:0; padding-right:0;">
							<a style="font-size:12px;" id="replyBtn<%=i %>" class="btn btn-secondary">답글</a>
						</td>
					</tr>
					<%
								}
								for(int j=0; j<reList.size(); j++) {
									if(list.get(i).getReplyID()==reList.get(j).getReplyID()) {
										if(userID != null && userID.equals(reList.get(j).getUserID())) {
					%>
					<tr>
						<td></td>
						<td>
							<%=reList.get(j).getUserID() %>
						</td>
						<td colspan="3" style="text-align:left;">
							<%= reList.get(j).getRereplyContent().replaceAll(" ","&nbsp;").replaceAll("\n", "<br>").replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>
						</td>
						<td>
							<a id="reReplyUpdateBtn<%=j %>" style="font-size:12px;" class="btn btn-secondary">수정</a>
						</td>
						<td style="width:3%; padding-left:0; padding-right:0;">
							<a style="font-size:12px;" onclick="return confirm('정말로 삭제하시겠습니까?')" href="reReplyDeleteAction.jsp?rereplyID=<%= reList.get(j).getRereplyID() %>&bbsID=<%= bbsID %>" class="btn btn-secondary">삭제</a>
						</td>
					</tr>
					<tr id="reReplyUpdate<%=j %>" style="display:none; visibility:hidden;">
						<td></td>
						<td></td>
						<td colspan="5">
							<div>
								<form method="post" action="reReplyUpdateAction.jsp?bbsID=<%=bbsID %>&rereplyID=<%=reList.get(j).getRereplyID() %>">
									<div>
										<textarea id="fixReReplyContent<%=j %>" class="form-control" name="rereplyContent" maxlength="1024" style="height:80px;"></textarea>
									</div>
									<div>
										<a href="view.jsp?bbsID=<%= bbsID %>" class="btn btn-primary pull-right" style="margin:5px;">취소</a>
									</div>
									<div>
										<input type="submit" class="btn btn-primary pull-right" value="수정" style="margin:5px;">
									</div>
								</form>
							</div>
						</td>
					</tr>
					<%
									}
									else {
					%>
					<tr>
						<td></td>
						<td>
							<%=reList.get(j).getUserID() %>
						</td>
						<td colspan="5" style="text-align:left;">
							<%= reList.get(j).getRereplyContent().replaceAll(" ","&nbsp;").replaceAll("\n", "<br>").replaceAll("<", "&lt;").replaceAll(">", "&gt;") %>
						</td>
					</tr>
					
					<%
									}
								}
							}
					%>
					
					<tr id="rereplywrite<%=i %>" style="display:none; visibility:hidden;">
						<td></td>
						<td><%= userID %></td>
						<td colspan="5">
							<div>
								<form method="post" action="reReplyWriteAction.jsp?bbsID=<%=bbsID %>&replyID=<%=list.get(i).getReplyID() %>">
									<div>
										<textarea id="reReplyContent" class="form-control" name="rereplyContent" maxlength="1024" style="height:80px;"></textarea>
									</div>
									<div>
										<a href="view.jsp?bbsID=<%= bbsID %>" class="btn btn-primary pull-right" style="margin:5px;">취소</a>
									</div>
									<div>
										<input type="submit" class="btn btn-primary pull-right" value="완료" style="margin:5px;">
									</div>
								</form>
							</div>
						</td>
					</tr>
					<%			
							}
						}
					%>
				</tbody>	
			</table>
			
			
			<div class="container">
				<form method="post" action="replyWriteAction.jsp?bbsID=<%= bbsID %>">
					<div style="margin-bottom: 10px;">
					<textarea class="form-control" placeholder="댓글 내용" name="replyContent" maxlength="1024" style="height: 100px;"></textarea>
					</div>
					<div>
						<input type="submit" class="btn btn-primary pull-right" value="댓글쓰기"  style="margin-bottom:20px;">
					</div>
				</form>
			</div>
		</div>
	</div>
	<%
		for(int i=0;i<list.size();i++) {
			
	%>
	<script type="text/javascript">
		document.getElementById("testBtn").addEventListener('click', function(){
			alert("테스트");
		});
	</script>
	<script>
		
		document.getElementById("replyBtn<%=i%>").addEventListener('click', function(){
			document.getElementById("rereplywrite<%=i%>").style.display="";
			document.getElementById("rereplywrite<%=i%>").style.visibility="visible";
		});
		
	</script>
	<script>
		document.getElementById("replyUpdate<%= i %>").addEventListener('click', function(){
			document.getElementById("fixReply<%=i%>").style.display="";
			document.getElementById("fixReply<%=i%>").style.visibility="visible";
			document.getElementById("fixReplyContent<%=i %>").value="<%=list.get(i).getReplyContent()%>";
		});
	</script>
	
	<%
			for(int j=0;j<reList.size();j++){
	%>
	<script>
				document.getElementById("reReplyUpdateBtn<%=j%>").addEventListener('click', function(){
					document.getElementById("reReplyUpdate<%=j %>").style.display="";
					document.getElementById("reReplyUpdate<%=j%>").style.visibility="visible";
					document.getElementById("fixReReplyContent<%=j %>").value="<%=reList.get(j).getRereplyContent()%>";
				});
	</script>
	<%		
			}
		}
	%>

	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>