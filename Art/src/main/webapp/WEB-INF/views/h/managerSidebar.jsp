<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자사이드</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	text-decoration: none;
}

a { text-decoration: none; color: inherit;}
img { border: 0px; }
ul { list-style: none;}
.font-red { color: red;}
.side{
	width: 200px;
	height: 940px;
	background-color: #6C7A89;
	display: inline-block;
	box-shadow: 5px 5px 5px grey;
}
.blank{
	height : 30px;
	background-color: RGBA;
}
.member{
	height : 60px;
	background-color: RGBA;
	font-size: 15pt;
	text-align: center;
	line-height: 60px;
	cursor: pointer;
}

.member:hover{
	height : 60px;
	background-color: #0C4A60;
	font-style: bold;
	font-size: 17pt;
	text-align: center;
	line-height: 60px;
	box-shadow: 5px 5px 5px grey;
	border-radius: 5px;
	color: white;
	font-style: 고딕;
	cursor: pointer;
	position: relative;
}

#active{
	height : 60px;
	background-color: #0C4A60;
	font-style: bold;
	font-size: 17pt;
	text-align: center;
	line-height: 60px;
	box-shadow: 5px 5px 5px grey;
	border-radius: 5px;
	color: white;
	font-style: 고딕;
	cursor: pointer;
}
.tag{
	height : 60px;
	background-color: RGBA;
	font-size: 15pt;
	text-align: center;
	line-height: 60px;
	cursor: pointer;
}
.tag:hover{
	height : 60px;
	background-color: #0C4A60;
	font-style: bold;
	font-size: 17pt;
	text-align: center;
	line-height: 60px;
	box-shadow: 5px 5px 5px grey;
	border-radius: 5px;
	color: white;
	font-style: 고딕;
	cursor: pointer;
	position: relative;
}
.gallary{
	height : 60px;
	background-color: RGBA;
	font-size: 15pt;
	text-align: center;
	line-height: 60px;
	cursor: pointer;
}

.gallary:hover{
	height : 60px;
	background-color: #0C4A60;
	font-style: bold;
	font-size: 17pt;
	text-align: center;
	line-height: 60px;
	box-shadow: 5px 5px 5px grey;
	border-radius: 5px;
	color: white;
	font-style: 고딕;
	cursor: pointer;
	position: relative;
}

.report{
	height : 60px;
	background-color: RGBA;
	font-size: 15pt;
	text-align: center;
	line-height: 60px;
	cursor: pointer;
}

.report:hover{
	height : 60px;
	background-color: #0C4A60;
	font-style: bold;
	font-size: 17pt;
	text-align: center;
	line-height: 60px;
	box-shadow: 5px 5px 5px grey;
	border-radius: 5px;
	color: white;
	font-style: 고딕;
	cursor: pointer;
	position: relative;
}
.gong{
	height : 60px;
	background-color: RGBA;
	font-size: 15pt;
	text-align: center;
	line-height: 60px;
	cursor: pointer;
}
.gong:hover{
	height : 60px;
	background-color: #0C4A60;
	font-style: bold;
	font-size: 17pt;
	text-align: center;
	line-height: 60px;
	box-shadow: 5px 5px 5px grey;
	border-radius: 5px;
	color: white;
	font-style: 고딕;
	cursor: pointer;
	position: relative;
}

.chart{
	height : 60px;
	background-color: RGBA;
	font-size: 15pt;
	text-align: center;
	line-height: 60px;
	cursor: pointer;
}
.chart:hover{
	height : 60px;
	background-color: #0C4A60;
	font-style: bold;
	font-size: 17pt;
	text-align: center;
	line-height: 60px;
	box-shadow: 5px 5px 5px grey;
	border-radius: 5px;
	color: white;
	font-style: 고딕;
	cursor: pointer;
	position: relative;
}

#logout {
	height : 30px;
	width: 50%;
	margin: 0 auto;
	background-color: RGBA;
	font-size: 10pt;
	text-align: center;
	line-height: 30px;
	cursor: pointer;
	border: 1px solid #0C4A60;
	border-radius: 20px;
	margin-top: 30px;
}

#logout:hover {
	background-color: #0C4A60;
	color: white;
}


</style>
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$(".member").on("click", function(){
		location.href = "user_board";
	});
	
	$(".tag").on("click", function(){
		location.href = "tag_board";
	});
	
	$(".gallary").on("click", function(){
		location.href = "gallaryManage";
	});
	
	$(".report").on("click", function(){
		location.href = "reportManage";
	});
	
	$(".gong").on("click", function(){
		location.href = "gong_board";
	});
	
	$(".chart").on("click", function(){
		location.href = "chart";
	});
	
	$("#logout").on("click", function() {
		console.log("aaa");
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

});//document end
</script>
</head>
<body> 
	 <div class="side">
		<div id="logout">로그아웃</div>
		<div class="blank" id=""></div>
		<div class="member" id="">회원관리</div>
		<div class="tag" id="">태그관리</div>
		<div class="gallary" id="">작품관리</div>
		<div class="report" id="">신고관리</div>
		<div class="gong" id="">공지사항</div>
		<div class="chart" id="">통계관리</div>
	 </div>
</body>
</html>