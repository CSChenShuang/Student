<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Student info</title>
<script type="text/javascript">
	function del(r){
		var ele = r.parentNode.parentNode;		
		var id = ele.cells[1].innerHTML ;
		var r = confirm("确定删除？") ;
		if (r == true){
			location.href = "DeleteServlet?id=" + id ;
		}else{
			alert("已经取消删除！") ;
		}
	}
	function update(r){
		var ele = r.parentNode.parentNode ;
		var id = ele.cells[1].innerHTML ;
		var name = ele.cells[2].innerHTML ;
		var birthday = ele.cells[3].innerHTML ;
		var avgscore = ele.cells[4].innerHTML ;
		var description = ele.cells[5].innerHTML ;
		location.href = "update.jsp?id=" + id + "&name=" + name + "&birthday=" + birthday 
				+ "&avgscore=" + avgscore + "&description=" + description ;
	}
</script>
<script type="text/javascript">
	$(function(){
		$("#delete").hover{
			$("#delete").css("background-color","red");
		}
	});
</script>
</head>
<body>
	<center>
		<h3>学生信息</h3>
		<a href="create.jsp"><input id="create" type="button" name="create" value="添加"></a>
		<br><br>
		<table border="0" bgcolor="lightsteelblue" width="80%" cellpadding="0" cellspacing="0" >
			<tr>
				<td width="5%"><h4>NO.</h4></td>			
				<td width="10%"><h4>ID</h4></td>
				<td width="15%"><h4>Name</h4></td>
				<td width="15%"><h4>Birthday</h4></td>
				<td width="10%"><h4>Avgscore</h4></td>
				<td width="35%"><h4>Description</h4></td>
				<td width="10%"><h4>Options</h4></td>
			</tr>
		</table>
		
		<c:if test="${empty requestScope['list']}">
			<script>
				location.href = "SelectServlet?flag=" ;
			</script>
		</c:if>
		<table id="list" border="1" width="80%" cellpadding="0" cellspacing="0">

			<c:forEach items="${requestScope['list']}" var="student" varStatus="status">		
			<tr> 
				<td id="no" width="5%">${status.count + (requestScope['targetPage']-1)*10}</td>
				<td id="id" width="10%">${student.getId()}</td>
				<td id="name" width="15%">${student.getName()}</td>
				<td id="birthday" width="15%">${student.getBirthday()}</td>
				<td id="avgscore" width="10%">${student.getAvgscore()}</td>
				<td id="description" width="35%">${student.getDescription()}</td>
				<td width="5%"><input id="update" type="button" value="编辑" onclick="update(this)"></td>
				<td width="5%"><input id="delete" type="button" value="删除" onclick="del(this)"></td>
			</tr>
			</c:forEach>			
		</table>
		
		<p>
		<a href="SelectServlet?indexPage=1&targetPage=1">首页</a>&nbsp;&nbsp;
		<c:if test="${requestScope['targetPage']>1}">
			<a href="SelectServlet?indexPage=${requestScope['indexPage']}&targetPage=${requestScope['indexPage']-1}">上一页</a>&nbsp;&nbsp;
		</c:if>
		
		<c:forEach begin="${requestScope['indexPage']}" end="${requestScope['pageNumber']}" varStatus="loop">
			<c:if test="${loop.count<6}">
				<a href="SelectServlet?indexPage=${requestScope['indexPage']}&targetPage=${(loop.count+requestScope['indexPage']-1)}">${loop.count+requestScope['indexPage']-1}</a>&nbsp;
			</c:if>
		</c:forEach>
		<c:if test="${requestScope['indexPage'] < requestScope['pageNumber']}">
			&nbsp;&nbsp;
			<a href="SelectServlet?indexPage=${requestScope['indexPage']}&targetPage=${requestScope['indexPage']+1}">下一页</a>
		</c:if>
		&nbsp;&nbsp;
		<a href="SelectServlet?indexPage=${indexPage}&targetPage=${pageNumber}">尾页</a>
		</p>
	</center>
</body>
</html>