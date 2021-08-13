<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
<style type="text/css">
.footer {
	width: 100%;
	height: 150px;
	background-color: black;
	position: relative;
	color: white;
	/* margin-top: 200px; */
}

#btnLogo2 {
	margin-top: 2vw;
	text-align: center;
}

.footer_phrase {
	font-size: 1em;
	color: white;
	text-align: center;
	margin-bottom: 2vw;
}

/* .footer1, .footer2, .footer3, .footer4, .footer5 {
	font-size: 10pt;
	color: white;
	position: absolute;
	top: 60px;
	display: inline-block;
} */

.footer_img {
	display: block;
	margin: 0 auto;
	width: 70px;
}

.footer1 {
	font-size: 1em;
	color: white;
	/* position: absolute;
	top: 60px; */
	display: block;
	text-align: center; 
}

/* .footer1 {
	left: 500px;
}

.footer2 {
	left: 650px;
}

.footer3 {
	left: 780px;
}

.footer4 {
	left: 990px;
} */

.footer5 {
	font-size: 10pt;
	color: white;
	position: absolute;
	top: 70px;
	display: inline-block;
	left: 65%;
}
</style>
<script type="text/javascript">
$(document).ready(function () {
	$(".footer5").on("click", function () {
		location.href="user_board";
	});
	
});
</script>
</head>
<body>
	<div class="footer">
	<div class="footer_img">
		<a href="main"><img src="resources/images/JY/art2_w.png" id="btnLogo2" alt="로고" width="70px" height="50px"></a>
	</div>
		<div class="footer_phrase">You can be an art writer.</div>
		<div class="footer1">Copyright © 2021 ART PROJECT All Rights Reserved.</div>
		<!-- <div class="footer1"><a href="#">관리방침 안내</a></div>
		<div class="footer2"><a href="#">도움말 안내</a></div>
		<div class="footer3"><a href="#">회원가입 및 글게시 안내</a></div>
		<div class="footer4"><a href="#">홈페이지 서비스 안내</a></div> -->
		
		
		<c:choose>
			<c:when test="${empty sAdminNo}">
			</c:when>
			<c:otherwise>
				<div class="footer5"><a href="user_board">관리자 페이지</a></div>
			</c:otherwise>
		</c:choose>
		
		
	</div>
</body>
</html>