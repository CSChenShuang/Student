<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Update</title>
</head>
<body>
	<center>
	<h3><font color="red">学生信息修改</font></h3>
	<form action="UpdateServlet" method="get">
		<table border="1">
		<tr align="center">
			<td><b>ID</b></td>
			<td><b>Name</b></td>
			<td><b>BirthDay</b></td>
			<td><b>AvgScore</b></td>
			<td><b>Description</b></td>
		</tr>
		<tr>
			<td><input id="id" type="text" name="id" value="${param.id}" readonly="readonly"></td>
			<td><input id="name" type="text" name="name" value="${param.name}"></td>
			<td><input id="birthday" type="text" name="birthday" value="${param.birthday}"></td>
			<td><input id="avgscore" type="text" name="avgscore" value="${param.avgscore}"></td>
			<td><input id="description" type="text" name="description" value="${param.description}"></td>
		</tr>
		</table>
		<br><br>
		<input type="reset" name="reset" value="重置" onclick="update.jsp">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="submit" name="update" value="提交">
	</form>
	</center>
</body>
</html>