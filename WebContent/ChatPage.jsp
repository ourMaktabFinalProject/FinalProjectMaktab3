<%@ page language="java" contentType="text/html; charset=windows-1256"
	pageEncoding="windows-1256"%>
<%@ page import="java.util.*"%>
<%@ page import="ChatClasses.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.0/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		var reloadData = 0;
		loadData();
	});
	function loadData() {
		$('#load_me').load('samp.jsp', function() {
			if (reloadData != 0)
				window.clearTimeout(reloadData);
			reloadData = window.setTimeout(loadData, 10000)
		}).fadeIn("slow");
	}
</script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
	integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
	crossorigin="anonymous">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

<meta http-equiv="Content-Type"
	content="text/html; charset=windows-1256">
<title>Insert title here</title>
</head>
<body>

	<%
		EntityManager entityManager = new EntityManager();

		if (request.getParameter("formCheck").equals("sendMsg") == true) {
			ArrayList<ChatGroup> chatGroupArraye = entityManager
					.listChatGrupReq(String.valueOf(session.getAttribute("id")));
			entityManager.addMsg(request.getParameter("inputMassage"), String.valueOf(session.getAttribute("id")),
					String.valueOf(session.getAttribute("chatGroupNameSession")));
		} else if (request.getParameter("formCheck").equals("newChatForm") == true) {
			session.setAttribute("chatGroupNameSession", request.getParameter("chatGroupName"));

			entityManager.updateFreeUser(String.valueOf(session.getAttribute("id")), 0);
			entityManager.addUserGroup(String.valueOf(session.getAttribute("id")),
					String.valueOf(session.getAttribute("chatGroupNameSession")), 1);
			String[] usersGroupArraye = request.getParameterValues("freeUsersCheckbox");
			if (usersGroupArraye[0].equals("checkboxExitFalse") == false) {
				for (int index = 0; index < usersGroupArraye.length; index++) {
					entityManager.addUserGroup(usersGroupArraye[index],
							String.valueOf(session.getAttribute("chatGroupNameSession")), 0); //usersGroupMap.put(usersGroupArraye[index], false);
				}
			}
		} else if (request.getParameter("formCheck").equals("acceptChatGroupForm")) {
			session.setAttribute("chatGroupNameSession", request.getParameter("chatGroupRequest"));
			entityManager.updateFreeUser(String.valueOf(session.getAttribute("id")), 0);
			entityManager.upadateUserGroupStatus(String.valueOf(session.getAttribute("id")),
					String.valueOf(session.getAttribute("chatGroupNameSession")), 1);
		}
	%>


	<div class="row">
		<div class="col-md-12">
			<br> <br> <br>
		</div>
	</div>
	<div class="row">
		<div class="col-md-3"></div>
		<div class="col-md-6">

			<form class="form-horizontal" action="ChatPage.jsp" method="post">
				<div class="form-group">
					<label for="MsgContainer" class="col-sm-2 control-label">Chat
						Massages:</label>
					<div id="load_me" class="col-sm-4">
						<textarea class="noresize" name="inputMassage1" rows="10"
							cols="55"><%
													ArrayList<Msg> msgArray = entityManager
															.listMsg(String.valueOf(session.getAttribute("chatGroupNameSession")));
													for (int index = (msgArray.size() - 1); index >= 0; index--) {
												%>
									<%=msgArray.get(index).getUser()%>:
									<%=msgArray.get(index).getMsg()%>									
									<%}%></textarea>
					</div>
				</div>

				<div class="form-group">
					<label for="inputMassage" class="col-sm-2 control-label">Your
						Massage:</label>
					<div class="col-sm-4">
						<textarea class="noresize" name="inputMassage" id="msg" rows="5" cols="55"></textarea>
						<br>
						<div onclick="$('#msg').val($('#msg').val() + '&#128516;');"
							id="emoji" class="btn btn-default">&#128516;</div>
						<div onclick="$('#msg').val($('#msg').val() + '&#128521;');"
							id="emoji" class="btn btn-default">&#128521;</div>
						<div onclick="$('#msg').val($('#msg').val() + '&#128525;');"
							id="emoji" class="btn btn-default">&#128525;</div>
						<div onclick="$('#msg').val($('#msg').val() + '&#128530;');"
							id="emoji" class="btn btn-default">&#128530;</div>


					</div>
				</div>

				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<input type='hidden' name='formCheck' value='sendMsg'>
						<button type="submit" class="btn btn-default">SEND</button>
					</div>
				</div>

			</form>


			<div class="col-sm-offset-2 col-sm-10">
				<form action="testlogout.jsp" method="get">
					<input type='hidden' name='formCheck' value='exitChatPage'>
					<button type="submit" class="btn btn-default">EXIT</button>
				</form>
			</div>


		</div>
		<div class="col-md-3"></div>
	</div>

</body>
</html>