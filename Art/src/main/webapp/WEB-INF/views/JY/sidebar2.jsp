<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sidebar2</title>
<link rel="stylesheet" href="resources/css/JY/sidebar2.css">

<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#btnMenu').click(function() {
			if ($('.side_bar').css('display') == 'none') {
				$('.side_bar').slideDown();
			} else {
				$('.side_bar').slideUp();
			}
		});
		
		$('#btnLook').click(function() {
			if ($('#searchW').css('display') == 'none') {
				$('#searchW').show();
			} else {
				$('#searchW').hide();
			}
		})
	});
</script>
</head>
<body>
	<div class="header">
		<img src="resources/images/JY/menu.png" id="btnMenu" alt="메뉴" width="35px" height="40px">
		<a href="main"><img src="resources/images/JY/art2.png" id="btnLogo" alt="로고" width="70px" height="40px"></a>
		<a href="searchPage"><img src="resources/images/JY/look.png" id="btnLook" alt="돋보기" width="40px" height="40px"></a>
	</div>
	<div class="side_bar">
		<img id="sideBarLogo" src="resources/images/JY//art2.png" alt="로고" width="80px"
			height="50px">
		<div class="side_bar_phrase">You can be an art writer.</div>
		<input type="button" id="btnStart" value="Art 시작하기">
		<div class="side_bar_menu">
			<div class="side_bar_menu1">
				<a href="main">Art 홈</a>
			</div>
			<br />
			<div class="side_bar_menu2">
				<a href="gallary">작품 보러가기</a>
			</div>
		</div>
		<div class="forget">
			<a href="#">계정을 잊어버리셨나요?</a>
		</div>
	</div>
</body>
</html>