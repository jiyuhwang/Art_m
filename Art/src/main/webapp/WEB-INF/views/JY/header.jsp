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

.footer a, .side_bar a {
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

#searchW {
	width: 300px;
	height: 45px;
	position: absolute;
	right: 100px;
	display: none;
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

#btnUpload, #btnLogout {
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

.profile {
	width: 200px;
	height: 200px;
	border-radius: 70%;
	overflow: hidden;
	position: absolute;
	top: 50px;
	left: 48px;
}

.profile_img, .profile_img2, .profile_img3, .profile_img4 {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.profile_name {
	position: absolute;
	width: 300px;
	height: 20px;
	text-align: center;
	top: 260px;
	font-size: 22pt;
}

#btnUpload {
	position: absolute;
	top: 310px;
	left: 95px;
}

.side_bar_menu {
	position: absolute;
	margin: 330px auto 0px;
	text-align: center;
	padding-top: 20px;
	font-size: 15pt;
	width: 100%;
	height: 200px;
}

.side_bar_menu1:hover, .side_bar_menu2:hover, .side_bar_menu3:hover, .side_bar_menu4:hover {
	color: #ffad33;
	font-weight: bold;
}

#btnLogout {
	position: absolute;
	top: 550px;
	left: 95px;
}

.side_bar_menu1x, .side_bar_menu2x, .side_bar_menu3x, .side_bar_menu4x {
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
	
	$("#btnLogout").on("click", function() {
		$.ajax({
			url: "Logout",
			type: "post",
			success: function(res) {
				location.href = "main";
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
	});
});
</script>
</head>
<body>
	<div class="header">
		<img src="resources/images/JY/menu.png" id="btnMenu" alt="메뉴" width="35px" height="40px">
		<a href="main"><img src="resources/images/JY/art2.png" id="btnLogo" alt="로고" width="70px" height="40px"></a>
		<a href="searchGallaryPage"><img src="resources/images/JY/look.png" id="btnLook" alt="돋보기" width="40px" height="40px"></a>
	</div>
	<div class="side_bar">
	
		<c:choose>
				<c:when test="${empty sUserProfileImg}">
					<div class="profile">
						<img class="profile_img" src="resources/images/JY/who.png" alt="프로필사진" width="300px" height="300px">
				    </div>
				</c:when>
				<c:otherwise>
					<div class="profile">
						<img class="profile_img" src="resources/upload/${sUserProfileImg}" alt="프로필사진" width="300px" height="300px">
				    </div>
				</c:otherwise>
		</c:choose>
	
		<div class="profile_name">${sUserNickname}</div>
		<a href="write"><input type="button" id="btnUpload"
			value="작품등록"></a>
		<div class="side_bar_menu">
			<span>--------------</span>
			
			<c:choose>
				<c:when test="${param.url == 'mygallary'}">
					<div class="side_bar_menu1x">
						<a href="mygallary">나의 작업실</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="side_bar_menu1">
						<a href="mygallary">나의 작업실</a>
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
			<br />
			
			<c:choose>
				<c:when test="${param.url == 'profile'}">
					<div class="side_bar_menu3x">
						<a href="profile">마이페이지</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="side_bar_menu3">
						<a href="profile">마이페이지</a>
					</div>
				</c:otherwise>
			</c:choose>

			<br />
			
			<c:choose>
				<c:when test="${param.url == 'gongji'}">
					<div class="side_bar_menu4x">
						<a href="gongji">공지사항</a>
					</div>
				</c:when>
				<c:otherwise>
					<div class="side_bar_menu4">
						<a href="gongji">공지사항</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		<input type="button" id="btnLogout" value="로그아웃">
	</div>
</body>
</html>