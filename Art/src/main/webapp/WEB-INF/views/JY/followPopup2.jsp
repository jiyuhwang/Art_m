<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
}
.bg2 {
	width: 100%;
	height: 1700px;
	position: absolute;
	background-color: #000000;
	opacity:0.3;
	z-index: 100;
	top: 0;
}

.popup_btn {
	height: 30px;
	text-align: center;
}

.follow_wrap {
	width: 290px;
	height: 560px;
	display: inline-block;
	vertical-align: top;
	margin-top: 10px;
	margin-bottom: 100px;
	position: absolute;
	z-index: 1000;
	background-color: white;
	position: absolute;
	top: 25%;
	left: 50%;
	margin-left: -150px;
	border-radius: 2%;
}


#follower, .tabs2 input:nth-of-type(1) ~ div:nth-of-type(1), #following, .tabs2 input:nth-of-type(2) ~ div:nth-of-type(2) {
    display:none;
}
.tabs2 input:nth-of-type(1):checked ~ div:nth-of-type(1), .tabs2 input:nth-of-type(2):checked ~ div:nth-of-type(2) {
    display: inline-block;
}

.tabs2 > label {
    display:inline-block;
    font-size: 12pt;
    padding:5px;
    text-align:center;
    width:130px;
    line-height:1.8em;
    font-weight:700;
    border-radius:3px 3px 0 0;
    background: white;
    color: black;
    border-bottom:1px solid #ffad33;
    border-width:1px 1px 0;
}
.tabs2 > label:hover {
    cursor:pointer;
}

.tabs2 input:nth-of-type(1):checked ~ label:nth-of-type(1), .tabs2 > label[for=follower]:hover {
    margin-left: 3px;
    margin-top: 3px;
    border-bottom: 3px solid #ffad33;
}
.tabs2 input:nth-of-type(2):checked ~ label:nth-of-type(2), .tabs2 > label[for=following]:hover {
    margin-left: 3px;
    margin-top: 3px;
    border-bottom: 3px solid #ffad33;

}

.follower_wrap, .following_wrap {
    padding: 2px;
    border: 1px solid #ddd;
    width: 278px;
    height: 510px;
    margin-left: 3px;
    overflow-y: scroll;
}

.follower_wrap::-webkit-scrollbar, .following_wrap::-webkit-scrollbar {
    width: 20px; /*스크롤바의 너비*/
}
 
.follower_wrap::-webkit-scrollbar-thumb, .following_wrap::-webkit-scrollbar-thumb {
    background-color: whitesmoke; /*스크롤바의 색상*/
    background-clip: padding-box;
    border: 4px solid transparent;
    border-top-left-radius: 50px;
    border-bottom-right-radius: 50px;
}

.follower_wrap::-webkit-scrollbar-track, .following_wrap::-webkit-scrollbar-track {
    background-color: white; /*스크롤바 트랙 색상*/
}

.follower, .following {
	width: 100%;
	border-bottom: 1px solid #ccc;
	padding: 5px 0px;
	cursor: pointer;
}

.follower_img_wrap, .following_img_wrap {
	margin-left: 20px;
	border-radius: 70%;
	width: 40px;
	height: 40px;
	overflow: hidden;
	display: inline-block
}

.follower_img, .following_img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

.follower_profile_wrap, .following_profile_wrap {
	display: inline-block;
	text-align: center;
	width: 190px;
	vertical-align: top;
    margin-top: 5px;
}


.follower_nickname, .follower_name, .following_nickname, .following_name {
	display: inline-block;
}
 
.follower_nickname, .following_nickname {
	font-size: 12pt;
	font-weight: bold;
}

.follower_name, .following_name {
	font-size: 10pt;
	margin-top: 3px;
}

</style>
<script type="text/javascript">
$(document).ready(function() {
	$(".profile_like").on("click", function(){
		followPopup();
		followList();
	});
	
});
function followPopup() {
	
	var html = "";
	html += "<div class=\"bg2\"></div>";
	html += "<form id=\"followForm\" method=\"post\">";
	html += "<input type=\"hidden\" id=\"followNo\" name=\"followNo\" value=\"${param.authorNo}\">"
	html += "<input type=\"hidden\" id=\"followpage\" name=\"followpage\" value=\"1\">"
	html += "<input type=\"hidden\" id=\"authorNo\" name=\"authorNo\" value=\"\">"
	html += "<input type=\"hidden\" id=\"userNo\" name=\"userNo\" value=\"\">"
	html += "<input type=\"hidden\" id=\"userNo2\" name=\"userNo2\" value=\"\">"
	html += "<input type=\"hidden\" id=\"userNickname\" name=\"userNickname\" value=\"\">"
	html += "<input type=\"hidden\" id=\"userProfileImg\" name=\"userProfileImg\" value=\"\">"
	html += "<input type=\"hidden\" id=\"userIntroduce\" name=\"userIntroduce\" value=\"\">"
	html += "</form>"
	html += "<div class=\"follow_wrap\">";
	html += "<div class=\"tabs2\">";
	html += "<input id=\"follower\" type=\"radio\" value=\"0\" name=\"tab2\" checked=\"checked\" />";
	html += "<input id=\"following\" type=\"radio\" value=\"1\" name=\"tab2\" />";
	html += "<label for=\"follower\">구독자 " + $("#labelCnt").val() + "</label>";
	html += "<label for=\"following\">관심작가 ${cnt}</label>";
		
	html += "<div class=\"follower_wrap\">";
	html += "</div>";
	html += "<div class=\"following_wrap\">";
	html += "</div>";
	html += "</div>";
	html += "</div>";
	
	$("body").prepend(html);
	
	
	$(".bg2").hide();
	$(".follow_wrap").hide();
	
	$(".bg2").fadeIn();
	$(".follow_wrap").fadeIn();
	
	$(".bg2").off("click");
	$(".bg2").on("click", function(){
		closePopup();
	});
	
	$(".tabs2").on("change", "[type='radio']", function() {
		$("#followpage").val("1");
		$(".follower_wrap").html("");
		$(".following_wrap").html("");
		followList();
	});
	
	$(".follower_wrap").scroll(function(){
		console.log($(this).scrollTop());
		console.log($(this).innerHeight());
		console.log($(this)[0].scrollHeight);
		if(Math.ceil($(this).scrollTop()) + $(this).innerHeight() >= $(this)[0].scrollHeight){
			$("#followpage").val($("#followpage").val() * 1 + 1);
			followList();
		}
	});
	
	$(".following_wrap").scroll(function(){
		if(Math.ceil($(this).scrollTop()) + $(this).innerHeight() >= $(this)[0].scrollHeight){
			$("#followpage").val($("#followpage").val() * 1 + 1);
			followList();
		} 
	});
	
	$(".follower_wrap, .following_wrap").on("dblclick", "div", function() {
		$("#authorNo").val($(this).attr("no"));
		$("#userNo2").val($(this).attr("no"));
		$("#userNo").val($('#followNo').val());
		$("#userNickname").val($(this).attr("nick"));
		$("#userProfileImg").val($(this).attr("img"));
		$("#userIntroduce").val($(this).attr("introduce"));
		$("#followForm").attr("action", "othergallary");
		$("#followForm").submit();
		
		console.log($("#authorNo").val());
		console.log($("#userNickname").val());
		console.log($("#userProfileImg").val());
		console.log($("#userIntroduce").val());
		console.log($("#userNo").val());
		console.log($("#userNo2").val());
	});
	
}

function followList() {
	var params= $("#followForm").serialize();
	
	var urlTxt = "";
	switch($(".tabs2 [type='radio']:checked").val()) {
	case "0" :
		urlTxt = "followerList";
		break;
	case "1" :
		urlTxt = "followingList";
		break;

	}
	$.ajax({
		url : urlTxt,
		type : "post",
		dataType : "json",
		data : params,
		success: function(res) { // 성공 시 다음 함수 실행
			switch($(".tabs2 [type='radio']:checked").val()) {
			case "0" :
				followerList(res.list);
				break;
			case "1" :
				followingList(res.list);
				break;
			}

			
		},
		error: function(request, status, error) { // 실패 시 다음 함수 실행
			console.log(error);
		}
	});
}

function followerList(list) {
	var html = "";
	
	for(var f of list) {
		html += "<div no=\"" + f.USER_NO + "\" img=\"" + f.PROFILE_IMG_PATH + "\" nick=\"" + f.USER_NICKNAME + "\" introduce=\"" + f.INTRODUCE + "\" class=\"follower\">";
		if(f.PROFILE_IMG_PATH == null) {
			html += "<div class=\"follower_img_wrap\">"
			html += "<img src=\"resources/images/JY/who.png\" class=\"follower_img\" alt=\"프로필사진\" width=\"40px\" height=\"40px\">";
			html += "</div>"
		} else {
			html += "<div class=\"follower_img_wrap\">"
			html += "<img src=\"resources/upload/" + f.PROFILE_IMG_PATH + "\" class=\"follower_img\" alt=\"프로필사진\" width=\"40px\" height=\"40px\">";
			html += "</div>"
		}	
		html += "<div class=\"follower_profile_wrap\">";
		html += "<div class=\"follower_nickname\">" + f.USER_NICKNAME +"</div>";
		html += "<br/>";
		html += "<div class=\"follower_name\">" + f.NAME + "</div>";
		html += "</div>";
		html += "</div>";
	}
	
	$(".follower_wrap").append(html);
}

function followingList(list) {
	var html = "";
	
	for(var f of list) {
		html += "<div no=\"" + f.USER_NO + "\" img=\"" + f.PROFILE_IMG_PATH + "\" nick=\"" + f.USER_NICKNAME + "\" introduce=\"" + f.INTRODUCE + "\" class=\"following\">";
		if(f.PROFILE_IMG_PATH == null) {
			html += "<div class=\"following_img_wrap\">"
			html += "<img src=\"resources/images/JY/who.png\" class=\"following_img\" alt=\"프로필사진\" width=\"40px\" height=\"40px\">";
			html += "</div>"
		} else {
			html += "<div class=\"following_img_wrap\">"
			html += "<img src=\"resources/upload/" + f.PROFILE_IMG_PATH + "\" class=\"following_img\" alt=\"프로필사진\" width=\"40px\" height=\"40px\">";
			html += "</div>"
		}			
		html += "<div class=\"following_profile_wrap\">";
		html += "<div class=\"following_nickname\">" + f.USER_NICKNAME +"</div>";
		html += "<br/>";
		html += "<div class=\"following_name\">" + f.NAME + "</div>";
		html += "</div>";
		html += "</div>";
	}
	
	$(".following_wrap").append(html);
}


function closePopup() {
	$(".bg2").fadeOut(function(){
		$(".bg2").remove();
	});
	
	$(".follow_wrap").fadeOut(function(){
		$(".follow_wrap").remove();
	});
}
</script>
</head>
<body>

</body>
</html>