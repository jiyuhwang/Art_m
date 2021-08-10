<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<style type="text/css">

body {
	/* font-size: 0pt; */
	margin: 0;
	font-family: '돋움';
}

[type="button"] {
	cursor: pointer;
	font-family: '돋움';
}

a {
	color: inherit;
	text-decoration: none;
}

.header {
	margin-top: 20px;
	position: relative;
	width: 100%;
	height: 60px;
}

#btnMenu {
	position: absolute;
	left: 40px;
	cursor: pointer;
}

#btnLogo {
	position: absolute;
	left: 80px;
}

#btnStart2 {
	position: absolute;
	right: 100px;
	border: 1px solid #ffad33;
	color: #ffad33;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15pt;
	padding: 10px;
	cursor: pointer;
	border-radius: 20px;
	background-color: white;
}

#btnSearch {
	width: 100%;
	height: 100%;
	border-radius: 15px;
	border: 1px solid #cccccc;
	outline-style: none;
}

#btnLook {
	position: absolute;
	right: 40px;
	cursor: pointer;
}

.side_bar {
	display: none;
	border: 2px solid gray;
	background-color: white;
	width: 300px;
	height: 630px;
	position: absolute;
	top: 65px;
	left: 40px;
	z-index: 900;
	border-radius: 10px;
}

#sideBarLogo {
	position: absolute;
	top: 50px;
	left: 105px;
}

.side_bar_phrase {
	position: absolute;
	top: 110px;
	left: 40px;
	font-size: 15pt;
}

#btnStart {
	position: absolute;
	top: 170px;
	left: 70px;
	padding: 10px;
	border: 1px solid #ffad33;
	color: #ffad33;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 18pt;
	cursor: pointer;
	border-radius: 20px;
	background-color: white;
}

.side_bar_menu {
	/* top: 230px;
	left: 70px; */
	text-align: center;
	border-top: 1px dashed black;
	margin: 0 auto;
	margin-top: 240px;
	width: 200px;
	padding-top: 30px;
	height: 200px;
	font-size: 18pt;
}

.side_bar_menu1:hover, .side_bar_menu2:hover, .side_bar_menu3:hover {
	color: #ffad33;
	font-weight: bold;
}

.forget {
	position: absolute;
	bottom:30px;
	left: 75px;
	text-decoration: underline;
	font-size: 10pt;
}

.side_bar_menu1x, .side_bar_menu2x, .side_bar_menu3x {
	color: #ffad33;
	font-weight: bold;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	$('#btnMenu').click(function() {
		if ($('.side_bar').css('display') == 'none') {
			$('.side_bar').slideDown();
		} else {
			$('.side_bar').slideUp();
		}
	});
	
	$(document).mouseup(function (e){

		var container = $(".side_bar");

		if( container.has(e.target).length === 0)

		container.slideUp();

	});
	
	$('#btnStart, #btnStart2').click(function() {
		location.href = "login";
	});
});
</script>
</head>
<body>
	<div class="header">
		<img src="resources/images/JY/menu.png" id="btnMenu" alt="메뉴" width="35px" height="40px">
		<a href="main"><img src="resources/images/JY/art2.png" id="btnLogo" alt="로고" width="70px" height="40px"></a>
		<input type="button" id="btnStart2" value="시작하기">
		<a href="searchGallaryPage"><img src="resources/images/JY/look.png" id="btnLook" alt="돋보기" width="40px" height="40px"></a>
	</div>
	<div class="side_bar">
		<img id="sideBarLogo" src="resources/images/JY//art2.png" alt="로고" width="80px"
			height="50px">
		<div class="side_bar_phrase">You can be an art writer.</div>
		<input type="button" id="btnStart" value="Art 시작하기">
		<div class="side_bar_menu">
			<c:choose>
				<c:when test="${param.url == 'main'}">
					<div class="side_bar_menu1x">
						<a href="main">Art 홈</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="side_bar_menu1">
						<a href="main">Art 홈</a>
					</div>
				</c:otherwise>
			</c:choose>
			
			<br />
			
			<c:choose>
				<c:when test="${param.url == 'gallary'}">
					<div class="side_bar_menu2x">
						<a href="gallary">작품 보러가기</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="side_bar_menu2">
						<a href="gallary">작품 보러가기</a>
					</div>
				</c:otherwise>
			</c:choose>
			
			<br/>
			
			<c:choose>
				<c:when test="${param.url == 'gongji'}">
					<div class="side_bar_menu3x">
						<a href="gongji">공지사항</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="side_bar_menu3">
						<a href="gongji">공지사항</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="forget">
			<a href="idfind">계정을 잊어버리셨나요?</a>
		</div>
	</div>
</body>
</html>