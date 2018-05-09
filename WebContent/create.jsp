<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Create</title>
<script type="text/javascript" src="js/jquery-3.2.1.min.js"></script>
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script>
<script type="text/javascript">
	$(function() {
	  $("#createForm").validate({
	    rules: {
	      id: {
	        required: true,
	        maxlength: 40
	      },
	      name: {
	        required: true,
	        maxlength: 40
	      },
	      birthday: {
	        required: true,
	        dateISO: true,
	      },
	      avgscore: {
	        required: true,
	        digits: true
	      },
	      description: {
	    	required: true,
	        maxlength: 255
	      }
	    },
	    messages: {
	      id: {
	        required: "",
	        maxlength: "不超过40个字"
	      },
	      name: {
	        required: "",
	        maxlength: "不超过40个字"
	      },
	      birthday: {
	        required: "",
	        dateISO: "输入正确日期格式",
	      },
	      avgscore: {
	    	required:"",
	    	digits:"输入整数"
	      },
	      description:{
	    	required:"",
	    	maxlength:"最多255个字"
	      }
	     }
	    })
	});
</script>

<script type="text/javascript">
	$(function(){
		$("#id").blur(function(){
		    var newId = $(this).val();  
		    $.ajax({
		        url:"IdExistServlet",       //要处理的页面
		        data:{u:newId},              //要传过去的数据
		        type:"POST",               //提交方式
		        dataType:"TEXT",          //返回的数据类型，TEXT字符串 JSON返回JSON XML返回XML；dataType中T要大写！！
		        success:function(data){          //回调函数，data为形参，是从IdExistServlet页面返回的值
		            if(data.trim()=="0")           //trim()去空格，因为会返回全部内容，包括空格回车等
		            {
		            	$("#submit").show() ;
		                $("#idCheck").html("此用户名可以注册！");
		                $("#idCheck").css("color","blue");
		            }
		            else
		            {
		            	$("#submit").hide() ;
		                $("#idCheck").html("此用户名已被注册！");
		                $("#idCheck").css("color","red");
		            }            
		        }
		    });
		});
		$("#id").focus(function(){
			$("#id").val("") ;
			$("#idCheck").empty() ;
			$("#submit").show() ;
		});
	});
</script>

</head>
<body>
	<center>
	<h3><font color="red">学生信息添加</font></h3>
	<form id="createForm" action="CreateServlet" method="get">
		<table border="1">
		<tr align="center">
			<td><b>ID</b></td>
			<td><b>Name</b></td>
			<td><b>BirthDay</b></td>
			<td><b>AvgScore</b></td>
			<td><b>Description</b></td>
		</tr>
		<tr>
			<td><input id="id" type="text" name="id"></td>
			<td><input id="name" type="text" name="name"></td>
			<td><input id="birthday" type="text" name="birthday"></td>
			<td><input id="avgscore" type="text" name="avgscore"></td>
			<td><input id="description" type="text" name="description"></td>
		</tr>
		</table>
		<span id="idCheck"></span>
		<br><br>
		<input id="submit" type="submit"  name="confirm" value="确定">
	</form>
	
</center>
</body>
</html>