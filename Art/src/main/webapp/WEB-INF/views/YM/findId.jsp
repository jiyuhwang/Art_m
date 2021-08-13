<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-sacle = 1.0, user-scalable=no" />
<title>아이디</title>
<style type="text/css">
body {
	margin: 0;
}
.wrap {
	width:100%;
	height: 500px;
}

.top2 {
	background-color: #ffad33;
	height: 80px;
	padding-top: 50px;
}


.tabs {
	display: block;
	width: 80%;
	margin: 50px auto;
	font-size: 16px;
}

.tabs input:nth-of-type(1), .tabs input:nth-of-type(1) ~ div:nth-of-type(1), .tabs input:nth-of-type(2), .tabs input:nth-of-type(2) ~ div:nth-of-type(2) {
    display:none;
    
}
.tabs input:nth-of-type(1):checked ~ div:nth-of-type(1), .tabs input:nth-of-type(2):checked ~ div:nth-of-type(2) {
    display: inline-block;
}
.tabs > label:nth-of-type(1) {
	/* float: left; */
    width: 120px;
    padding: 30px 0 6px 0;
    margin-right: 6px;
    font-size: 24px;
    color: #666;
    margin-top: 14px;
}

.tabs > label:nth-of-type(2) {
	/* float: left; */
    width: 150px;
    padding: 30px 0 6px 0;
    margin-right: 6px;
    font-size: 24px;
    color: #666;
    margin-top: 14px;
    margin-left: 10px;
}

.tabs input:nth-of-type(1):checked ~ label:nth-of-type(1), .tabs > label[for=tab1]:hover {
    color: #EF6C33;
    font-weight: bold;
    border-bottom: 2px solid #EF6C33;
    cursor: pointer;
}
.tabs input:nth-of-type(2):checked ~ label:nth-of-type(2), .tabs > label[for=tab2]:hover {
    color: #EF6C33;
    font-weight: bold;
    border-bottom: 2px solid #EF6C33;
    cursor: pointer;
}



.h2 {
	width:340px;
    height:50px;
    border: 0;
    outline: none;
    font-size: 14pt;
    border-bottom: 2px solid #e5e5e5;
    margin-bottom: 20px;
}

.middle {
	width: 90%;
	margin: 0 auto;
	height: 100%;
}

.text {
 /* margin-left: 510px; */
 border-bottom: 2px solid #e5e5e5;
 width: 100%;
}

/* .text2 {
 margin-left: 510px;
} */

.box {
	margin-top: 30px;
	border :1px solid #ccc;
	width : 100%;
	height: 200px;
 	text-align: center;
 	padding-top: 10%;
 	/* line-height: 200px; */
}

.check {
	text-align: center;
	margin-top: 15px;
}

.login { 
	width : 130px;
	height: 40px;
	background-color: #ffad33;
	border : none;
	border-radius: 5px;
	cursor: pointer;
}

.passwordfind {
	width : 130px;
	height: 40px;
	border : none;
	border-radius: 5px;
	cursor: pointer;
	margin-left: 30px;
}

.select_id {
	margin-top: 30px;
}

</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$(".login").on("click", function(){
		/* $(".select_id").val()  */
		
		$("#login").submit();   
	});
	
	$("#tab2, .passwordfind").on("click", function(){
		    
		location.href = "passwordfind";   
	});

	
	$("#tab1").on("click", function(){
	    
		location.href = "idfind";   
	});
	

});
</script>
</head>
<body>
<form id="login" action="login" method="post">

<div class="tabs">
	<input id="tab1" type="radio" value="0" checked="checked" />
	<input id="tab2" type="radio" value="1" />
	<label for="tab1">아이디찾기</label>
	<label for="tab2">비밀번호찾기</label>
</div>
	<div class="wrap">
			<div class="middle">
			<div class="text"><h2>아이디찾기</h2></div>
			<br>	
			<div class="text2">고객님의 정보와 일치하는 아이디 목록입니다.</div>
			<div class="box">
			<c:forEach var="id" items="${list}">
    			<input type="radio" class="select_id" name="selectId" value="${id.USER_ID}">${id.USER_ID}
    			<br/>
			</c:forEach>
			</div>
			<div class="check">
				<input type="button" class="login" value="로그인하기">
				<input type="button" class="passwordfind" value="비밀번호 찾기">
			</div>
		</div>
	</div>
</form>
</body>
</html>