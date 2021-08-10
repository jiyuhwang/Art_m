<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-sacle = 1.0, user-scalable=no" />
<title>main</title>
<link rel="stylesheet" href="resources/css/JY/main.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	reloadList();
	

	
	$(".go_pic").on("click", function() {
		$("#tab").val("0");
		$("#actionForm").attr("action", "gallary");
		$("#actionForm").submit();
	});
	
	$(".go_draw").on("click", function() {
		$("#tab").val("1");
		$("#actionForm").attr("action", "gallary");
		$("#actionForm").submit();
	});
	
	$(".go_video").on("click", function() {
		$("#tab").val("2");
		$("#actionForm").attr("action", "gallary");
		$("#actionForm").submit();
	});
	
	
	
	$(".pic_main_wrap, .draw_main_wrap, .video_main_wrap").on("click", "div", function() {
		$("#pNo").val($(this).attr("pno"));
		//$("#postNo").val($(this).attr("pno"));
		$("#actionForm").attr("action", "detail");
		$("#actionForm").submit();
	});
	
	$(".wrap").on("click", '.contents_heart', function() {
		if($('#userNo').val() != "") {
		
		if ($(this).attr("src") == "resources/images/JY/heart3.png") {
			//console.log($(this).parent().parent().attr("pno"));
			$(this).attr("src", "resources/images/JY/heart2.png");
			$("#postNo").val($(this).parent().parent().attr("pno"));

			
			var params= $("#actionForm").serialize();
			
			$.ajax({
				url : "postOnHeart",
				type : "post",
				dataType : "json",
				data : params,
				success: function(res) { // 성공 시 다음 함수 실행
					if(res.msg == "success") {
						//alert("좋아요가 눌렸습니다.");
						
					} else if(res.msg == "failed") {
						alert("로그인 후 이용해주세요.");
						location.href = "login";
					} else {
						alert("로그인 후 이용해주세요.");
						location.href = "login";
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});

		} else {
			$("#postNo").val($(this).parent().parent().attr("pno"));
			
			$(this).attr("src", "resources/images/JY/heart3.png");
			
			var params= $("#actionForm").serialize();
			
			$.ajax({
				url : "postOffHeart",
				type : "post",
				dataType : "json",
				data : params,
				success: function(res) { // 성공 시 다음 함수 실행
					if(res.msg == "success") {
						//alert("좋아요를 취소하였습니다.");
						
					} else if(res.msg == "failed") {
						alert("에러 발생");
						location.href = "login";
					} else {
						alert("문제 발생");
						
					}

				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});
		}
		} else {
			alert("로그인 후 이용해주세요.");
			location.href = "login";
		}
	});
});

function reloadList() {
	var params= $("#actionForm").serialize();

	
	$.ajax({
		url: "mainList", // 접속 주소
		type: "post", // 전송 방식: get, post
		dataType: "json", // 받아올 데이터 형태
		data: params, // 보낼 데이터(문자열 형태)
		success: function(res) { // 성공 시 다음 함수 실행
			picList(res.list1);
			drawList(res.list2);
			videoList(res.list3);

		},
		error: function(request, status, error) { // 실패 시 다음 함수 실행
			console.log(error);
		}
	});
}

function picList(list1) {
		var html = "";
		for(var p of list1) {
			html += "<div pno = \"" + p.POST_NO + "\"class=\"pic\" id=\"pic" + p.POST_NO + "\">";	
			/* html += "<div class=\"bg\">"
			html += "<div class=\"contents_title\">" +  p.TITLE + "</div>"
	
		if(p.REGISTER_DATE == null) {
			html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart3.png\" alt=\"투명하트\" width=\"40px\" height=\"40px\">";
		} else {
			html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart2.png\" alt=\"빨간하트\" width=\"40px\" height=\"40px\">";
		}
		
			html += "<div class=\"contents_name\"> " + p.USER_NICKNAME + "</div>";
			html += "</div>"; */
			html += "</div>";
	
		}
		$(".pic_main_wrap").html(html);
		for(var p of list1) {
			$('#pic' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
		}		
}

function drawList(list2) {
	var html = "";
	for(var p of list2) {
		html += "<div pno = \"" + p.POST_NO + "\"class=\"pic\" id=\"draw" + p.POST_NO + "\">";	
		/* html += "<div class=\"bg\">"
		html += "<div class=\"contents_title\">" +  p.TITLE + "</div>"

	if(p.REGISTER_DATE == null) {
		html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart3.png\" alt=\"투명하트\" width=\"40px\" height=\"40px\">";
	} else {
		html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart2.png\" alt=\"빨간하트\" width=\"40px\" height=\"40px\">";
	}
	
		html += "<div class=\"contents_name\"> " + p.USER_NICKNAME + "</div>";
		html += "</div>"; */
		html += "</div>";

	}
	$(".draw_main_wrap").html(html);
	for(var p of list2) {
		$('#draw' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
	}
}

function videoList(list3) {
	var html = "";
	for(var p of list3) {
		html += "<div pno = \"" + p.POST_NO + "\"class=\"pic\" id=\"video" + p.POST_NO + "\">";	
		/* html += "<div class=\"bg\">"
		html += "<div class=\"contents_title\">" +  p.TITLE + "</div>"

	if(p.REGISTER_DATE == null) {
		html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart3.png\" alt=\"투명하트\" width=\"40px\" height=\"40px\">";
	} else {
		html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart2.png\" alt=\"빨간하트\" width=\"40px\" height=\"40px\">";
	}
	
		html += "<div class=\"contents_name\"> " + p.USER_NICKNAME + "</div>";
		html += "</div>"; */
		html += "</div>";

	}
	$(".video_main_wrap").html(html);
	for(var p of list3) {
		$('#video' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
	}		
}
	
</script>
</head>
<body>
	<c:choose>
		<c:when test="${empty sUserNo}">
			<c:import url="header_main2.jsp">
				<c:param name="url" value="main"></c:param>
			</c:import>
		</c:when>
		<c:when test="${!empty sAdminNo}">
			<c:import url="header_main.jsp"></c:import>
		</c:when>
		<c:otherwise>
			<c:import url="header_main.jsp"></c:import>
		</c:otherwise>
	</c:choose>
	

	<form action="#" id="actionForm" method="post">
		<input type="hidden" id="userNo" name="userNo" value="${sUserNo}" />
		<input type="hidden" id="pNo" name="pNo" />
		<input type="hidden" id="postNo" name="postNo" />
		<input type="hidden" id="tab" name="tab" />
		<input type="hidden" id="page" name="page" value="1" />
		<input type="hidden" id="mainGallary" name="listPage" value="4"/>
	</form>
	<div class="background_wrap">

	<div class="wrap">
		<div class="pic_wrap">
			<div class="pic_title">사진갤러리</div>
			<div class="img_wrap">
				<div class="pic_main_wrap"></div>
			</div>	
			<div class="more">
				<div class="go_pic">더 많은 작품 보러가기 ></div>
			</div>
		</div>
		<br />
		<div class="draw_wrap">
			<div class="draw_title">그림갤러리</div>
			<div class="img_wrap2">
				<div class="draw_main_wrap"></div>
			</div>
				<div class="more">
					<div class="go_draw">더 많은 작품 보러가기 ></div>
				</div>
		</div>
		<br />
		<div class="video_wrap">
			<div class="video_title">영상갤러리</div>
			<div class="img_wrap3">
				<div class="video_main_wrap"></div>
			</div>
				<div class="more">
					<div class="go_video">더 많은 작품 보러가기 ></div>
				</div>
		</div>
	</div>
	</div>
	
	<c:import url="footer.jsp"></c:import>

</body>
</html>
