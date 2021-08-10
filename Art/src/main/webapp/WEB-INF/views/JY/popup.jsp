<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>삭제 확인 페이지</title>
<style type="text/css">
.background{
	width : 100%;
	height : 100%;
	background-color: black;
	opacity: 0.4;
	position: absolute;
	left : 0;
	top : 0;
}
.main{
	width : 400px;
	height: 300px;
	background-color: #E0E7E9;
	position: absolute;
	left : 50%;
	top: 50%;
	margin-left : -180px;
	margin-top : -190px;
	font-size: 15pt;
	border-radius: 7px;
}
.topBlank{
	height: 90px;
	width: 100%;
	background-color: RGBA;
}
.middleBlank{
	width : 100%;
	height: 250px;
	background-color: Rgba;
	margin : 0 auto;
	text-align: center;
}
input{
	width : 250px;
	height : 30px;
	padding : 5px;
}
.title{
	width : 100%;
	height: 50px;
	font-size: 15pt;
	text-align: center;
	margin-bottom: 70px;
}

button{
	width:150px;
	height: 45px;
	border-radius: 9px;
	font-size: 15pt;
	font-weight: bold;
	cursor: pointer;
	border: none;
}
button:hover{
	background-color: #ffad33;
	color: white;
}

</style>
</head>
<body>
<div class = "background"></div>
<div class = "main">
	<div class = "topBlank"></div>
		<div class = "middleBlank">
			<div class = "title">탈퇴하시겠습니까?<br/>변경사항이 저장되지 않을 수 있습니다.</div>
			<button class ="a1">cancel</button>
			<button class ="a2">ok</button>
		</div>
</div>
</body>
</html>