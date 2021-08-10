<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="resources/css/HD/gong_detail.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	reloadLikeCnt();
	reloadList();
	reloadCommentCnt();
	
	$("#goForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) { // 엔터키를 눌렀을 때
			return false; // 페이지가 안넘어간다.
		}
	});
	
	
	
	console.log($('#listPage').val());
/* 	$('#leftArrow').click(function() {
		if($('#listPage').val() == "0") {
			$("#goForm").attr("action", "gallary");
			$("#goForm").submit();
		} else if($('#listPage').val() == "1") {
			$("#goForm").attr("action", "mygallary");
			$("#goForm").submit();
		} else if($('#listPage').val() == "2") {
			$("#goForm").attr("action", "othergallary");
			$("#goForm").submit();
		}
	}) */
	
	$(".pagination").on("click", "a",  function() {
		$("#page").val($(this).attr("page"));
		reloadList();
		var offset = $('.comment_wrap1').offset();

        $('html').animate({scrollTop : offset.top}, 400);
	});
	
	if($("#userNo").val() != $("#authorNo").val()) {
		$(".btnCommentDelete").hide();
		//$("#replyBtnCommentDelete").hide();
		$(".header").hide();
		$(".share_wrap").hide();
		$(".header2").show();
		$(".share_wrap2").show();
	} else {
		$(".btnCommentDelete").show();
		//$("#replyBtnCommentDelete").show();
		$(".header").show();
		$(".share_wrap").show();
		$(".header2").hide();
		$(".share_wrap2").hide();
	}

	
	$(document).mouseup(function (e){

		var container = $(".side_bar");
	
		if( container.has(e.target).length === 0)
	
		container.slideUp();

	});
	
	$('#btnStart').click(function() {
		location.href = "login";
	});
	
	$('#btnShare').click(function() {
		if ($('.share_wrap').css('display') == 'none') {
			$('.share_wrap').show();
		} else {
			$('.share_wrap').hide();
		}
	})
	
	$('#btnShare2').click(function() {
		if ($('.share_wrap2').css('display') == 'none') {
			$('.share_wrap2').show();
		} else {
			$('.share_wrap2').hide();
		}
	})
	
	$('.comment_wrap1').click(function() {
		reloadList();
		if ($('.comment_wrap2').css('display') == 'none') {
			$('.comment_wrap2').show();
		} else {
			$('.comment_wrap2').hide();
		}
	})
	

	
	$('#btnShare').hide();
	$("#btnDot2, #btnDot22").hide();
	$("#btnDeclation2").hide();
	$(".share_wrap").hide();
	$(".share_wrap2").hide();
	
	
	$('#btnDot1').click(function() {
		$('#btnShare').show();
		$('#btnLike').hide();
		$('#likeCnt').hide();
		$('#btnEdit').hide();
		$('#btnDelete').hide();
		$('#btnComment').hide();
		$('.comment_cnt').hide();
		$(this).hide();
		$("#btnDot2").show();
	})
	
	$('#btnDot2').click(function() {
		$('#btnEdit').show();
		$('#btnDelete').show();
		$('#btnShare').hide();
		$('#btnLike').show();
		$('#likeCnt').show();
		$('#btnComment').show();
		$('.comment_cnt').show();
		$(this).hide();
		$("#btnDot1").show();
	})
	
	$('#btnDot12').click(function() {
		$('#btnShare2').hide();
		$('#btnLike2').hide();
		$('.like_cnt').hide();
		$('#btnComment2').hide();
		$('.comment_cnt12').hide();
		$(this).hide();
		$("#btnDot22").show();
		$("#btnDeclation2").show();
	})
	
	$('#btnDot22').click(function() {
		$('#btnShare2').show();
		$('#btnLike2').show();
		$('.like_cnt').show();
		$('#btnComment2').show();
		$('.comment_cnt12').show();
		$(this).hide();
		$("#btnDot12").show();
		$("#btnDeclation2").hide();
	})
	
	$('#btnMenu, #btnMenu2').click(function() {
		if($("#userNo").val() != "") {
			if ($('.side_bar').css('display') == 'none') {
				$('.side_bar').slideDown();
			} else {
				$('.side_bar').slideUp();
			}
		} else {
			if ($('.side_bar2').css('display') == 'none') {
				$('.side_bar2').slideDown();
			} else {
				$('.side_bar2').slideUp();
			}
		}
	})
	
	if($("#userNo").val() != "") {
		$('.side_bar_menu4').css('color', '#ffad33');
		$('.side_bar_menu4').css('font-weight', 'bold');
	} else {
		$('.side_bar_menu3x').css('color', '#ffad33');
		$('.side_bar_menu3x').css('font-weight', 'bold');
	}
	
	$('#btnComment, .comment_cnt_wrap').click(function(){
			$(".comment_wrap1").show();
			var offset = $('.comment_wrap1').offset();

	        $('html').animate({scrollTop : offset.top}, 400);
	})
	
	$('#btnComment2, .comment_cnt_wrap').click(function(){
			$(".comment_wrap1").show();
			var offset = $('.comment_wrap1').offset();

	        $('html').animate({scrollTop : offset.top}, 400);
	})
	
	
	
	
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
	

	
	
	$("#btnEdit").on("click", function() {
		$("#goForm").attr("action", "edit");
		$("#goForm").submit();
	});
	
	
	$(document).mouseup(function (e){

		var container = $(".side_bar, .side_bar2");
	
		if( container.has(e.target).length === 0)
	
		container.slideUp();

	});
			
	$("#btnDelete").on("click", function() {
		if(confirm("삭제하시겠습니까?")) {
			var params= $("#goForm").serialize();
			
			$.ajax({
				url: "postDeletes", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
					if(res.msg == "success") {
						location.href = "gallary";
					} else if(res.msg == "failed") {
						alert("삭제에 실패하였습니다.")
					} else {
						alert("삭제 중 문제가 발생하였습니다.")
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});
		}
	});
	
	
	
	
	
$('body').on("click", '.heart', function() {
	if($('#userNo').val() != "") {
		if ($(this).attr("src") == "resources/images/JY/heart.png") {
			$(this).attr("src", "resources/images/JY/heart2.png");
			
			var params= $("#goForm").serialize();
			
			$.ajax({
				url : "postOnHeart",
				type : "post",
				dataType : "json",
				data : params,
				success: function(res) { // 성공 시 다음 함수 실행
					reloadLikeCnt();
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});
			


		} else {
			
			$(this).attr("src", "resources/images/JY/heart.png");
			
			var params= $("#goForm").serialize();
			
			$.ajax({
				url : "postOffHeart",
				type : "post",
				dataType : "json",
				data : params,
				success: function(res) { // 성공 시 다음 함수 실행

					reloadLikeCnt();
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			});
			
		}
		
		} else {
			alert("로그인 후 이용해주세요.")
		}
	});
	
	
	
	
	$("#btnCommentUpload").on("click", function() {
		
		if($('#userNo').val() != "") {
			var params= $("#goForm").serialize();
			
			$.ajax({
				url: "commentWrite", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
					if(res.msg == "success") {
						reloadList();
						reloadCommentCnt();
						$('#commentWrite').val("");
					} else if(res.msg == "failed") {
						alert("댓글 작성에 실패하였습니다.")
					} else {
						alert("댓글 작성 중 문제가 발생하였습니다.")
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			})
		} else {
			alert("로그인 후 이용해주세요.");
			location.href = "login";
		}
	});
	
});

function reloadList() {
	var params= $("#goForm").serialize();
	
	
	$.ajax({
		url: "commentList", // 접속 주소
		type: "post", // 전송 방식: get, post
		dataType: "json", // 받아올 데이터 형태
		data: params, // 보낼 데이터(문자열 형태)
		success: function(res) { // 성공 시 다음 함수 실행
			
			commentList(res.list);	
			drawPaging(res.pb);	
		},
		error: function(request, status, error) { // 실패 시 다음 함수 실행
			console.log(error);
		}
	});
}

function commentList(list) {

	
	var html = "";
	var html2 = "";
	for(var p of list) {
	if(p.TOP_COMMENT_NO == null) {
			if(p.DEL == 1) {
				html += "<div class=\"comment_form1\">";
				html += "<div class=\"profile3\">";
				if(p.PROFILE_IMG_PATH != null) {
				html += "<img class=\"profile_img3\" src=\"resources/upload/" + p.PROFILE_IMG_PATH + "\" alt=\"프로필 이미지\" width=\"30px\" height=\"30px\">";
				} else {
				html += "<img class=\"profile_img3\" src=\"resources/images/JY/who.png\" alt=\"프로필 이미지\" width=\"30px\" height=\"30px\">";
				}
				html += "</div>";
				html += "<div class=\"comment_name1\">" + p.USER_NICKNAME + "</div>";
				html += "<div class=\"comment1\">" + p.CONTENT + "</div>";
				html += "<div class=\"comment1_date\">" + p.REGISTER_DATE + "<a class=\"comment_declation\" href=\"#\">신고하기</a></div>";
				html += "<div class=\"btn_reply_upload_comment_delete_w\" cNo=\"" + p.COMMENT_NO +"\" >";
				html += "<input type=\"hidden\" class=\"commentUserNo\" value=\"" + p.USER_NO + "\">";
				html += "<input type=\"button\" class=\"btnReplyUpload\" id=\"btnReplyUpload\" value=\"답글\">";
				if("${sUserNo}" == p.USER_NO) {
					html += "<input type=\"button\" class=\"btnCommentDelete\" id=\"btnCommentDelete\" value=\"삭제\">";
				}
				html += "</div>";
				html += "</div>";
				html += "<div class=\"reply_comment_form1_w1\">";
				html += "<form action=\"#\" class=\"commentform\" id=\"go" + p.COMMENT_NO + "\" method=\"post\">";
				html += "<input type=\"hidden\" name=\"topCommentNo\" value=\"" + p.COMMENT_NO + "\">";
				html += "<input type=\"hidden\" class=\"userNo\" name=\"userNo\" value=\"${sUserNo}\">";
				html += "<input type=\"hidden\" name=\"postNo\" value=\"" + p.POST_NO + "\">";
				html += "<span class=\"reply\"></span>";
				html += "<div class=\"reply_comment_write_w\"><input id=\"replyCommentWrite\" name=\"replyCommentWrite\"type=\"text\" placeholder=\"답글을 남겨보세요.\"></div>";
				html += "<div class=\"reply_btn_comment_upload_w\"><input type=\"button\" class=\"replyBtnCommentUpload\" id=\"replyBtnCommentUpload\" value=\"답글 작성\"></div>";
				html += "</form>";
				html += "</div>";
			} else {
				html += "<div class=\"comment_form1\">삭제된 댓글입니다</div>";
			}
			
	} else {
			if(p.DEL == 1) {
				html += "<div class=\"reply_comment_form1_w2\">";
				html += "<span class=\"reply\"></span>";
				html += "<div class=\"reply_comment_form1\">";
				html += "<div class=\"reply_profile3\">";
				if(p.PROFILE_IMG_PATH != null) {
					html += "<img class=\"reply_profile_img3\" src=\"resources/upload/" + p.PROFILE_IMG_PATH + "\" alt=\"프로필 이미지\" width=\"30px\" height=\"30px\">";
				} else {
					html += "<img class=\"reply_profile_img3\" src=\"resources/images/JY/who.png\" alt=\"프로필 이미지\" width=\"30px\" height=\"30px\">";
				}
				html += "</div>";
				html += "<div class=\"reply_comment_name1\">" + p.USER_NICKNAME + "</div>";
				html += "<div class=\"reply_comment1\">" + p.CONTENT + "</div>";
				html += "<input type=\"hidden\" class=\"commentUserNo2\" value=\"" + p.USER_NO + "\">";
				html += "<div class=\"reply_comment1_date\">" + p.REGISTER_DATE + "<a class=\"reply_comment_declation\" href=\"#\">신고하기</a></div>";
				html += "<div class=\"reply_btn_reply_upload_comment_delete_w\" cNo2 = \"" +  p.COMMENT_NO + "\">";
				if("${sUserNo}" == p.USER_NO) {
					html += "<input type=\"button\" class=\"replyBtnCommentDelete\" id=\"replyBtnCommentDelete\" value=\"삭제\">";
				}
				html += "</div>";
				html += "</div>";
				html += "</div>";
			} else {
				html += "<div class=\"reply_comment_form1_w2\">";
				html += "<span class=\"reply\"></span>";
				html += "<div class=\"reply_comment_form1\">";
				html += "삭제된 답글입니다.";
				html += "</div>";
				html += "</div>";
				html += "</div>";
			}
		}
	}
	console.log(html);
		$("#commentFormWrap").html(html);
		console.log($("#commentFormWrap").html());
		
		$(".replyBtnCommentUpload").on("click", function() {
			if($('#userNo').val() != "") {
				//var cNo = $(this).parent().parent().attr("cNo");
				var params= $(this).parent().parent().serialize();

				$.ajax({
					url: "replyCommentWrite", // 접속 주소
					type: "post", // 전송 방식: get, post
					dataType: "json", // 받아올 데이터 형태
					data: params, // 보낼 데이터(문자열 형태)
					success: function(res) { // 성공 시 다음 함수 실행
						if(res.msg == "success") {
							reloadList();
							reloadCommentCnt();
						} else if(res.msg == "failed") {
							alert("답글 작성에 실패하였습니다.")
						} else {
							alert("답글 작성 중 문제가 발생하였습니다.")
						}
					},
					error: function(request, status, error) { // 실패 시 다음 함수 실행
						console.log(error);
					}
				})
			} else {
				alert("로그인 후 이용해주세요.");
				location.href = "login";
			}
		});
		
		$(".btnReplyUpload").click(function() {
			var cNo = $(this).parent().attr("cNo");
			if($('.reply_comment_form1_w1').css('display') == 'none') {
				$("#go" + cNo).parent().show();
			} else {
				$("#go" + cNo).parent().hide();
			}
			
		})
		
		
		$(".btnCommentDelete").click(function() {
			if(confirm("삭제하시겠습니까?")) {
			var cNo = $(this).parent().attr("cNo");

			$("#commentNo").val(cNo);
			
			var params= $("#goForm").serialize();

			
			$.ajax({
				url: "deleteComment", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
					if(res.msg == "success") {
						reloadList();
						reloadCommentCnt();
					} else if(res.msg == "failed") {
						alert("댓글 삭제에 실패하였습니다.")
					} else {
						alert("댓글 삭제 중 문제가 발생하였습니다.")
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			})
			}
		})
		
		$(".replyBtnCommentDelete").click(function() {
			if(confirm("삭제하시겠습니까?")) {
			var cNo2 = $(this).parent().attr("cNo2");

			$("#ReplyCommentNo").val(cNo2);
			console.log($("#ReplyCommentNo").val());
			var params= $("#goForm").serialize();

			
			$.ajax({
				url: "deleteReplyComment", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
					if(res.msg == "success") {
						reloadList();
						reloadCommentCnt();
					} else if(res.msg == "failed") {
						alert("댓글 삭제에 실패하였습니다.")
					} else {
						alert("댓글 삭제 중 문제가 발생하였습니다.")
					}
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			})
			}
		})
	
		
		
		
		
		$(".commentform").on("keypress", "input", function(event) {
			if(event.keyCode == 13) { // 엔터키를 눌렀을 때
				return false; // 페이지가 안넘어간다.
			}
		});
		
		
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

function reloadLikeCnt() {
	
	var params= $("#goForm").serialize();
	$.ajax({
		url : "postLikeCnt",
		type : "post",
		dataType : "json",
		data : params,
		success: function(res) { // 성공 시 다음 함수 실행
			likeCnt(res.data)
		},
		error: function(request, status, error) { // 실패 시 다음 함수 실행
			console.log(error);
		}
	});
}

function likeCnt(data) {
	var html = "";
	
	if($('#userNo').val() == $('#authorNo').val()) {

			html += "<div id=\"likeCnt\" class=\"like_cnt\">" + data.LIKECNT + "</div>";
		
	} else {

			html += "<div id=\"likeCnt2\" class=\"like_cnt\">" + data.LIKECNT + "</div>";
		
	}
	
	$(".like_cnt_wrap").html(html);

}

function reloadCommentCnt() {
	
	var params= $("#goForm").serialize();
	$.ajax({
		url : "postCommentCnt",
		type : "post",
		dataType : "json",
		data : params,
		success: function(res) { // 성공 시 다음 함수 실행
			CommentCnt(res.data)
		},
		error: function(request, status, error) { // 실패 시 다음 함수 실행
			console.log(error);
		}
	});
}

function CommentCnt(data) {
	var html = "";
	var html2 = "";
	
	html2 += data.COMMENTCNT;
		
	if($('#userNo').val() == $('#authorNo').val()) {

		html += "<span class=\"comment_cnt\">" + data.COMMENTCNT +  "</span>";
	
} else {

		html += "<span class=\"comment_cnt12\">" + data.COMMENTCNT + "</span>";
	
}

	$(".comment_cnt_wrap").html(html);
	$(".comment_cnt2").html(html2);

}

function CopyUrl()

{
	var ShareUrl = document.getElementById("shareAddress");
	ShareUrl.value = window.document.location.href;  // 현재 URL 을 세팅해 줍니다.
	ShareUrl.select();  // 해당 값이 선택되도록 select() 합니다
	document.execCommand("copy"); // 클립보드에 복사합니다.
	ShareUrl.blur(); // 선택된 것을 다시 선택안된것으로 바꿉니다.
	alert("URL이 클립보드에 복사되었습니다"); 

}

function CopyUrl2()

{
	var ShareUrl = document.getElementById("shareAddress2");
	ShareUrl.value = window.document.location.href;  // 현재 URL 을 세팅해 줍니다.
	ShareUrl.select();  // 해당 값이 선택되도록 select() 합니다
	document.execCommand("copy"); // 클립보드에 복사합니다.
	//obShareUrl.blur(); // 선택된 것을 다시 선택안된것으로 바꿉니다.
	alert("URL이 클립보드에 복사되었습니다"); 

}
</script>
</head>
<body>
	
	<input type="hidden" id="userNo" name="userNo" value="${sUserNo}">
	
	
	
	<!-- 글 작가와 본인이 동일할 때 -->	
	<div class="header">
		<img src="resources/images/JY/menu.png" id="btnMenu" alt="메뉴" width="35px" height="40px">
		<a href="main"><img src="resources/images/JY/art2.png" id="btnLogo" alt="로고" width="70px" height="40px"></a>
		

		<div class="like_cnt_wrap">
			<%-- <div id="likeCnt" class="like_cnt">${data.LIKECNT}</div> --%>
		</div>
		<div class="comment_cnt_wrap"></div>
		<img src="resources/images/JY/share.png" id="btnShare" alt="공유" width="20px" height="20px">
		<img src="resources/images/JY/dot1.png" id="btnDot1" alt="메뉴" width="25px" height="25px">
		<img src="resources/images/JY/dot2.png" id="btnDot2" alt="메뉴" width="25px" height="25px">
	</div>
	<div class="share_wrap">
		<div class="share">아트 글을 공유해보세요.</div>
		<input type="text" id="shareAddress" value="http://localhost:8090/art/detail"/>
		<input type="button" id="btnShareAddress" value="Copy" onclick="javascript:CopyUrl()" />
	</div>
	
	
	<!-- 글 작가와 본인이 동일하지않을 때 -->	
	<div class="header2">
		<img src="resources/images/JY/menu.png" id="btnMenu2" alt="메뉴" width="35px" height="40px">
		<a href="main"><img src="resources/images/JY/art2.png" id="btnLogo3" alt="로고" width="70px" height="40px"></a>
		<img src="resources/images/JY/comment2.png" id="btnComment2" alt="댓글" width="20px" height="20px">
		<div class="comment_cnt_wrap"></div>
		<c:choose>
			<c:when test="${empty data.RD}">
				<img src="resources/images/JY/heart.png" id="btnLike2" class="heart" alt="투명하트" width="25px" height="25px">
			</c:when>	
			<c:otherwise>
				<img src="resources/images/JY/heart2.png" id="btnLike2" class="heart" alt="빨간하트" width="25px" height="25px">
			</c:otherwise>
		</c:choose>
		<div class="like_cnt_wrap">
			<%-- <div id="likeCnt2" class="like_cnt">${data.LIKECNT}</div> --%>
		</div>
		<img src="resources/images/JY/share.png" id="btnShare2" alt="공유" width="20px" height="20px">
		<img src="resources/images/JY/dot1.png" id="btnDot12" alt="메뉴" width="25px" height="25px">
		<img src="resources/images/JY/dot2.png" id="btnDot22" alt="메뉴" width="25px" height="25px">
	</div>
	<div class="share_wrap2">
		<div class="share2">아트 글을 공유해보세요.</div>
		<input type="text" id="shareAddress2" value="http://localhost:8090/art/detail"/>
		<input type="button" id="btnShareAddress2" value="Copy" onclick="javascript:CopyUrl2()" />
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
		<a href="write"><input type="button" id="btnUpload" value="작품등록"></a>
		<div class="side_bar_menu">
			<span>--------------</span>
			<div class="side_bar_menu1"><a href="mygallary">나의 작업실</a></div>
			<br />
			<div class="side_bar_menu1"><a href="gallary">작품 보러가기</a></div>
			<br />
			<div class="side_bar_menu3"><a href="profile">개인정보 수정</a></div>
			<br />
			<div class="side_bar_menu4"><a href="gongji">공지사항</a></div>
		</div>
		<input type="button" id="btnLogout" value="로그아웃">
	</div>
	
	<div class="side_bar2">
		<img id="sideBarLogo" src="resources/images/JY//art2.png" alt="로고" width="80px" height="50px">
		<div class="side_bar_phrase">You can be an art writer.</div>
		<input type="button" id="btnStart" value="Art 시작하기">
		<div class="side_bar_menux">
			<div class="side_bar_menu1x">
				<a href="main">Art 홈</a>
			</div>
			<br />
			<div class="side_bar_menu2x">
				<a href="gallary">작품 보러가기</a>
			</div>
			<br/>
			<div class="side_bar_menu3x">
				<a href="gongji">공지사항</a>
			</div>
		</div>
		<div class="forget">
			<a href="idfind">계정을 잊어버리셨나요?</a>
		</div>
	</div>
	
	<div class="wrap">
	
		<%-- <c:choose>		
			<c:when test="${data.CATEGORY_NO eq '3'}">
				<div class="contents_wrap">
					${data.VIDEO_LINK}
				</div>
			</c:when>

			<c:otherwise>
				<div class="contents_wrap">
					<img class="contents_img" src="resources/upload/${data.POST_FILE}">
				</div>
			</c:otherwise>	
		</c:choose> --%>

		<div class="category">공지사항</div>
		<div class="title"><%-- ${data.TITLE} --%>${data.TITLE}</div>
		<div class="middleLine">
		<div class="byArt">by ArtTeam</div>
		<div class="dot"></div>
		<div class="contents_date"> ${data.REGISTER_DATE}</div>
		<div class="views"> 조회수 ${data.VIEWS}</div>
		</div>
		<br />
		<br />
		<!-- 첨부파일 있고 없음에 따라 조건 처리해주기  -->
		<div class="uploadBox">
			<input type="button" id="uploadFile" value="첨부파일 : "><!--옆에 아래화살표  -->
			<a href="resources/upload/${data.FILE_PATH }" download="${data.FILE_PATH }"><span id="fileName" >${data.FILE_PATH }</span></a>
		</div>
		<div class="contents" style="font-size:30pt;">
		${data.CONTENTS}
		</div>
		<br />
		<div class="profile2_wrap">
					<div class="profile2">
						<img class="profile_img2" src="resources/images/JY/art2.png" alt="프로필사진" width="40px" height="40px">
				    </div>
			<div class="profile_name2">ArtTeam</div>
			<div class="profile_introduce">아트팀입니다. 최선을 다하겠습니다.</div>
		</div>
	</div>

	<c:import url="../JY/footer.jsp"></c:import>
	
</body>
</html>