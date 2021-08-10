<%@ page language="java" contentType="text/html; charselect=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 갤러리</title>
<link rel="stylesheet" href="resources/css/JY/mygallary.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	if("${param.selectGbn}" != "") {
		$(".select").val("${param.selectGbn}");
	}
	
	
	if("${param.tab}" != "") {
		$("input[name=tab]").prop("checked", false);
		$("input[name=tab][value='${param.tab}']").prop("checked", true);
	}
	
	if("${param.visibility}" != "") {
		$("#visibility").val("${param.visibility}");
		if($("#visibility").val() == "1"){
			$("#checkbox").prop("checked", false);
		} else {
			$("#checkbox").prop("checked", true);
		}
	}
	
	reloadList();

	

	$('#label').on("click", function() {
		if($('#checkbox').is(":checked")){
		    $('#visibility').val("1");
		} else {
			$('#visibility').val("0");
		}
		 reloadList();
	});
   
	
	
	
	$("html, body").animate({ scrollTop: 0 }, "fast")

	
	$('#btnGoUpload').click(function() {
		location.href =	"write";
	});
	
	
	$(".pagination").on("click", "a",  function() {
		$("#page").val($(this).attr("page"));
		$('html').scrollTop(0);
		reloadList();
	});
	
	$(".select").on("click", function() {

		reloadList();
	});
	
	
	$(".pic_wrap, .draw_wrap, .video_wrap").on("dblclick", "div", function() {
		$("#pNo").val($(this).attr("pno"));
		$("#postNo").val($(this).attr("pno"));
		$("#actionForm").attr("action", "detail");
		$("#actionForm").submit();
	});
	
	$(".tabs").on("change", "[type='radio']", function() {
		$("#page").val("1");
		$(".select").val("0");
		reloadList();
	});
	
	
	$(".gallary_wrap").on("click", '.contents_heart', function() {
		if($('#userNo').val() != "") {
		if ($(this).attr("src") == "resources/images/JY/heart3.png") {
			console.log($(this).parent().parent().attr("pno"));
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
						alert("오류 발생");
					} else {
						alert("오류 발생2");
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
						alert("오류 발생");
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
		}
	});
	
	
	
});


function reloadList() {
	var params= $("#actionForm").serialize();
	
	var urlTxt = "";
	switch($(".tabs [type='radio']:checked").val()) {
	case "0" :
		urlTxt = "mypicgallarys";
		break;
	case "1" :
		urlTxt = "mydrawgallarys";
		break;
	case "2" :
		urlTxt = "myvideogallarys";
		break;
	}
	
	$.ajax({
		url: urlTxt, // 접속 주소
		type: "post", // 전송 방식: get, post
		dataType: "json", // 받아올 데이터 형태
		data: params, // 보낼 데이터(문자열 형태)
		success: function(res) { // 성공 시 다음 함수 실행
			switch($(".tabs [type='radio']:checked").val()) {
			case "0" :
				picList(res.list);
				break;
			case "1" :
				drawList(res.list);
				break;
			case "2" :
				videoList(res.list);
				break;
			}
			
			drawPaging(res.pb);	
		},
		error: function(request, status, error) { // 실패 시 다음 함수 실행
			console.log(error);
		}
	});
}

function picList(list) {
		var html = "";
		if(list.length == 0) {
			html += "<div class=\"noPost\">";
			html += "작품이 없습니다.";
			html += "</div>"
		} else {
			for(var p of list) {
				html += "<div pno = \"" + p.POST_NO + "\"class = \"pic\" id=\"pic" + p.POST_NO + "\">";					
				html += "<div class=\"bg\">";
				html += "<div class=\"contents_title\">" + p.TITLE + "</div>";
				/* html += "<div class=\"contents_in\">" + p.EXPLAIN + "</div>"; */
				if(p.REGISTER_DATE == null) {
					html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart3.png\" alt=\"투명하트\" width=\"40px\" height=\"40px\">";
				} else {
					html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart2.png\" alt=\"빨간하트\" width=\"40px\" height=\"40px\">";
				}
				html += "<div class=\"contents_name\"> " + p.USER_NICKNAME + "</div>";
				html += "</div>";
				html += "</div>";
		
			}
		}
		$(".pic_wrap").html(html);
		for(var p of list) {
			$('#pic' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
		}		
}

function drawList(list) {
	var html = "";
	if(list.length == 0) {
		html += "<div class=\"noPost\">";
		html += "작품이 없습니다.";
		html += "</div>"
	} else {
		for(var p of list) {
			html += "<div pno = \"" + p.POST_NO + "\"class = \"pic\" id=\"draw" + p.POST_NO + "\">";					
			html += "<div class=\"bg\">";
			html += "<div class=\"contents_title\">" + p.TITLE + "</div>";
			/* html += "<div class=\"contents_in\">" + p.EXPLAIN + "</div>"; */
			if(p.REGISTER_DATE == null) {
				html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart3.png\" alt=\"투명하트\" width=\"40px\" height=\"40px\">";
			} else {
				html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart2.png\" alt=\"빨간하트\" width=\"40px\" height=\"40px\">";
			}
			html += "<div class=\"contents_name\"> " + p.USER_NICKNAME + "</div>";
			html += "</div>";
			html += "</div>";
	
		}
	}
	$(".draw_wrap").html(html);
	for(var p of list) {
		$('#draw' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
	}		
}

function videoList(list) {
	var html = "";
	if(list.length == 0) {
		html += "<div class=\"noPost\">";
		html += "작품이 없습니다.";
		html += "</div>"
	} else {
		for(var p of list) {
			html += "<div pno = \"" + p.POST_NO + "\"class = \"pic\" id=\"video" + p.POST_NO + "\">";					
			html += "<div class=\"bg\">";
			html += "<div class=\"contents_title\">" + p.TITLE + "</div>";
			/* html += "<div class=\"contents_in\">" + p.EXPLAIN + "</div>"; */
			if(p.REGISTER_DATE == null) {
				html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart3.png\" alt=\"투명하트\" width=\"40px\" height=\"40px\">";
			} else {
				html += "<img class=\"contents_heart\" src=\"resources/images/JY/heart2.png\" alt=\"빨간하트\" width=\"40px\" height=\"40px\">";
			}
			html += "<div class=\"contents_name\"> " + p.USER_NICKNAME + "</div>";
			html += "</div>";
			html += "</div>";
	
		}
	}
	$(".video_wrap").html(html);
	for(var p of list) {
		$('#video' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
	}		
}	



function drawPaging(pb) {
	var html ="";
	
	html += "<a page=\"1\"><<</a>";
	if($("#page").val() == "1") {
		html += "<a page=\"1\"><</a>";		
	} else {
		html += "<a page=\"" + ($("#page").val() - 1) + "\"><</a>";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount; i++){
		if($("#page").val() == i) {
			html += "<a class=\"on\" page=\"" + i + "\">" + i + "</a>";			
		} else {
			html += "<a page=\"" + i + "\">" + i + "</a>";			
			
		}
	}
	
	if($("#page").val() == pb.maxPcount) {
		html += "<a page=\"" + pb.maxPcount + "\">></a>";
	} else {
		html += "<a page=\"" + ($("#page").val() * 1 + 1) + "\">></a>";
	}
	
	html += "<a page=\"" + pb.maxPcount + "\">>></a";
	
	$(".pagination").html(html);
}
</script>
</head>
<body>
	<c:choose>
		<c:when test="${empty sUserNo}">
			<c:import url="header2.jsp"></c:import>
		</c:when>
		<c:otherwise>
			<c:import url="header.jsp">
				<c:param name="url" value="mygallary"></c:param>
			</c:import>
		</c:otherwise>
	</c:choose>
	<c:import url="followPopup.jsp"></c:import>
<form action="#" id="actionForm" method="post">
		<input type="hidden" id="pNo" name="pNo" />
		<input type="hidden" id="userNo" name="userNo" value="${sUserNo}" />
		<input type="hidden" id="postNo" name="postNo" />
		<input type="hidden" id="page" name="page" value="${page}" />
		<input type="hidden" id="mainGallary" name="listPage" value="1"/>	
	
	<div class="main_title_wrap">
		<span id="mainTitle">나의 작업실</span>
	</div>
	<div class="background_wrap">
	<div class="wrap">
		<div class="profile_wrap">

			<c:choose>
				<c:when test="${empty sUserProfileImg}">
					<div class="profile2">
						<img class="profile_img2" src="resources/images/JY/who.png" alt="프로필사진" width="200px" height="200px">
				    </div>
				</c:when>
				<c:otherwise>
					<div class="profile2">
						<img class="profile_img2" src="resources/upload/${sUserProfileImg}" alt="프로필사진" width="200px" height="200px">
					</div>
				</c:otherwise>
			</c:choose>
			
			<div class="profile_name2">${sUserNickname}</div>
			<div class="profile_like">
				<span class="profile_like_cnt">구독자 ${data.LIKECNT} | 관심작가 ${cnt}</span>
			</div>
			<%-- <div class="profile_like2">팔로우수
				<span class="profile_like_cnt2">${cnt}</span>
			</div> --%>
			<div class="profile_introduce">
				<div class="profile_introduce_in">${sUserIntroduce}</div>
			</div>
		</div>
		<div class="gallary_wrap">
			<div class="gallary">
				<div class="tabs">
					<input id="gallaryMenu1" type="radio" value="0" name="tab" checked="checked" />
					<input id="gallaryMenu2" type="radio" value="1" name="tab" />
					<input id="gallaryMenu3" type="radio" value="2" name="tab" />
					<label for="gallaryMenu1">사진작품관</label>
					<label for="gallaryMenu2">그림작품관</label>
					<label for="gallaryMenu3">영상작품관</label>
					<input type="checkbox" id="checkbox" checked>
						<label id="label" for="checkbox">
						<span></span>
					</label>
					<input type="hidden" id="visibility" name="visibility" value="0"/>
					
					<input id="btnGoUpload" type="button" value="작품 등록하기">
					<select class="select" name="selectGbn">
						<option value="0" selected="selected">최신순</option>
						<option value="1">좋아요순</option>
					</select>
					<div class="gallary_menu1_contents">
						<div class="pic_wrap"></div> 
					</div>
					<div class="gallary_menu2_contents">
						<div class="draw_wrap"></div> 
					</div>
					<div class="gallary_menu3_contents">
						<div class="video_wrap"></div> 
					</div>
				</div>
			</div>
			<div class="pagination"></div>
		</div>
	</div>
	</div>
</form>
	<br />
	
	<c:import url="footer.jsp"></c:import>
</body>
</html>