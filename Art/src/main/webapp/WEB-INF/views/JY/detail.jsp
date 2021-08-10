<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-sacle = 1.0, user-scalable=no" />
<title>작품 상세보기</title>
<link rel="stylesheet" href="resources/css/JY/detail.css">
<link rel="stylesheet" type="text/css"
	href="resources/css/h/user_report_popup.css" />
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	reloadLikeCnt();
	reloadList();
	reloadCommentCnt();
	$("#page2").val("1");
	$("#goForm").on("keypress", "input", function(event) {
		if(event.keyCode == 13) { // 엔터키를 눌렀을 때
			return false; // 페이지가 안넘어간다.
		}
	});
		
	
	
	$('#leftArrow').click(function() {
		if($('#listPage').val() == "0") {
			$("#goForm").attr("action", "gallary");
			$("#goForm").submit();
		} else if($('#listPage').val() == "1") {
			$("#goForm").attr("action", "mygallary");
			$("#goForm").submit();
		} else if($('#listPage').val() == "2") {
			$("#goForm").attr("action", "othergallary");
			$("#goForm").submit();
		} else if($('#listPage').val() == "3") {
			$("#goForm").attr("action", "searchGallaryPage");
			$("#goForm").submit();
		} else if($('#listPage').val() == "4") {
			$("#goForm").attr("action", "main");
			$("#goForm").submit();
		} else if($('#listPage').val() == "5") {
			$("#goForm").attr("action", "myreport");
			$("#goForm").submit();
		}
	})
	
	$(".pagination").on("click", "a",  function() {
		$("#page2").val($(this).attr("page"));
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
	
	
	$(".select_flag").on("click", "li", function(){
		
		if($(this).attr("class") == "recent_order"){
			$("#commentGbn").val("0");
			$(this).attr("id", "active");
			$(".past_order").attr("id", "");
			$(".comment_cnt_order").attr("id", "");
		} else if($(this).attr("class") == "past_order"){
			$("#commentGbn").val("1");
			$(this).attr("id", "active");
			$(".recent_order").attr("id", "");
			$(".comment_cnt_order").attr("id", "");
		} else {
			$("#commentGbn").val("2");
			$(this).attr("id", "active");
			$(".recent_order").attr("id", "");
			$(".past_order").attr("id", "");
		}
		$("#page2").val("1");
		reloadList();
		reloadCommentCnt();
	});
	
	
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
	
	$(document).mouseup(function (e){

		var container = $(".side_bar, .side_bar2");
	
		if( container.has(e.target).length === 0)
	
		container.slideUp();

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
	
	$('#btnStart').click(function() {
		location.href = "login";
	});
	

	
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
		
		//신고버튼 클릭시 팝업창 띄우기
		$("#btnDeclation2").on("click", function(){
			
			if($('#userNo').val() != "") {
			
				var params= $("#goForm").serialize();
				
				$.ajax({
					url: "userReport",
					type: "post",
					dataType: "json",
					data: params,
					success: function(res) {				
						reportPopup(res.data, res.userNo);
					},
					error: function(request, status, error) {
						console.log(error);
					}
				});
			
			} else {
				alert("로그인 후 이용해주세요.");
			}

		});//신고버튼함수end
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
	
	$('#btnComment, .comment_cnt_wrap').click(function(){
		
			reloadList();
			
			$('.comment_wrap2').show();

			var offset = $('.comment_wrap1').offset();
			
	        $('html').animate({scrollTop : offset.top}, 400);
	})
	
	$('#btnComment2, .comment_cnt_wrap').click(function(){
			reloadList();
			$('.comment_wrap2').show();
			
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
	
	
	$(".profile_name2").on("click", function() {
		if($('#userNo').val() == $('#authorNo').val()) {
			location.href = "mygallary";
		} else {
			$("#goForm").attr("action", "othergallary");
			$("#goForm").submit();
		}
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
						history.back(-1);
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
			 
		 	if($("#commentWrite").val() == "") {
				alert("댓글을 작성해주세요.")
				return false;
			}
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
	
	
	$("#commentFormWrap").on("click", ".replyBtnCommentUpload", function() {
		var cNo = $(this).parent().parent().attr("cmt");
		console.log(cNo);
		if($('#userNo').val() != "") {
			if($("#replyCommentWrite" + cNo).val() == "") {
				alert("답글을 작성해주세요.");
				return false;
			}
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
			});
		} else {
			alert("로그인 후 이용해주세요.");
			location.href = "login";
		}
			
	});
	
	
	$("#commentFormWrap").on("click", ".replyBtnCommentDelete", function() {
		
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
	
	$("#commentFormWrap").on("click", ".comment_name1", function() {
		$("#commentForm #authorNo").val($(this).attr("no"));
		$("#commentForm #userNo2").val($(this).attr("no"));
		$("#commentForm #userNickname").val($(this).attr("name"));
		$("#commentForm #userProfileImg").val($(this).attr("img"));
		$("#commentForm #userIntroduce").val($(this).attr("introduce"));

		if($(this).attr("del2") == "undefined") {
			if($(this).attr("no") != "${sUserNo}") {
				$("#commentForm").attr("target", "_blank");
				$("#commentForm").attr("action", "othergallary");
				$("#commentForm").submit();
			} else {
				$("#commentForm").attr("target", "_blank");
				$("#commentForm").attr("action", "mygallary");
				$("#commentForm").submit();
			}
		} else {
			alert("탈퇴한 회원입니다.")
		}
		
		console.log($("#authorNo").val());
		console.log($("#userNickname").val());
		console.log($("#userProfileImg").val());
		console.log($("#userIntroduce").val());
		console.log($("#userNo").val());
		console.log($("#userNo2").val());
	});
	


});// document End

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
	if(list.length == 0) {
		html += "<div class=\"comment_form1\">";
		html += "등록된 댓글이 없습니다.";
		html += "</div>"
	} else {
		for(var p of list) {

			
			if(p.DEL == 1) {
				
				html += "<form id=\"commentForm\" method=\"post\">";
				html += "<input type=\"hidden\" id=\"followNo\" name=\"followNo\" value=\"${sUserNo}\">"
				html += "<input type=\"hidden\" id=\"authorNo\" name=\"authorNo\" value=\"\">"
				html += "<input type=\"hidden\" id=\"userNo\" name=\"userNo\" value=\"\">"
				html += "<input type=\"hidden\" id=\"userNo2\" name=\"userNo2\" value=\"\">"
				html += "<input type=\"hidden\" id=\"userNickname\" name=\"userNickname\" value=\"\">"
				html += "<input type=\"hidden\" id=\"userProfileImg\" name=\"userProfileImg\" value=\"\">"
				html += "<input type=\"hidden\" id=\"userIntroduce\" name=\"userIntroduce\" value=\"\">"
				html += "</form>"
				
				html += "<div class=\"comment_form1\">";
				html += "<div class=\"profile3\">";
				if(p.PROFILE_IMG_PATH != null) {
				html += "<img class=\"profile_img3\" src=\"resources/upload/" + p.PROFILE_IMG_PATH + "\" alt=\"프로필 이미지\" width=\"30px\" height=\"30px\">";
				} else {
				html += "<img class=\"profile_img3\" src=\"resources/images/JY/who.png\" alt=\"프로필 이미지\" width=\"30px\" height=\"30px\">";
				}
				html += "</div>";
				html += "<div del2=\"" + p.OUT_DATE +"\" no=\"" + p.USER_NO +"\" img=\"" + p.PROFILE_IMG_PATH +"\" introduce=\"" + p.INTRODUCE + "\" name=\"" + p.USER_NICKNAME + "\" class=\"comment_name1\">" + p.USER_NICKNAME + "</div>";
				html += "<div class=\"comment1\">" + p.CONTENT + "</div>"; 
				html += "<div class=\"comment1_date\">" + p.REGISTER_DATE;
				
				if("${sUserNo}" != p.USER_NO) {
					html += "<a class=\"comment_declation\" commentNo=\""+ p.COMMENT_NO +"\" href=\"#\">신고하기</a>";		
				}		
				html += "</div>";		
				html += "<div class=\"btn_reply_upload_comment_delete_w\" cNo=\"" + p.COMMENT_NO + "\" >";
				html += "<input type=\"hidden\" class=\"commentUserNo\" value=\"" + p.USER_NO + "\">";
				if(p.CNT > 0) {
					html += "<input type=\"button\" class=\"btnReplyUpload\" id=\"btnReplyUpload\"" + p.COMMENT_NO + "\" value=\"답글 " + p.CNT + "\">";
				} else {
					html += "<input type=\"button\" class=\"btnReplyUpload\" id=\"btnReplyUpload\"" + p.COMMENT_NO +"\" value=\"답글쓰기\">";
				}
				if("${sUserNo}" == p.USER_NO) {
					html += "<input type=\"button\" class=\"btnCommentDelete\" id=\"btnCommentDelete\" value=\"삭제\">";
				}
				html += "</div>";
				
				
				html += "<div class=\"reply_comment_form1_w1\" id=\"reply_comment_form1_w1" + p.COMMENT_NO + "\">";
				html += "<form action=\"#\" class=\"commentform\" id=\"go" + p.COMMENT_NO + "\" method=\"post\" cmt=\"" + p.COMMENT_NO + "\">";
				html += "<input type=\"hidden\" name=\"topCommentNo\" value=\"" + p.COMMENT_NO + "\">";
				html += "<input type=\"hidden\" class=\"userNo\" name=\"userNo\" value=\"${sUserNo}\">";
				html += "<input type=\"hidden\" name=\"postNo\" value=\"" + p.POST_NO + "\">";

				html += "<span class=\"reply\"></span>";
				html += "<div class=\"reply_comment_write_w\"><input id=\"replyCommentWrite" + p.COMMENT_NO + "\" class=\"replyCommentWrite\" name=\"replyCommentWrite\"type=\"text\" placeholder=\"답글을 남겨보세요.\"></div>";
				html += "<div class=\"reply_btn_comment_upload_w\"><input type=\"button\" class=\"replyBtnCommentUpload\" id=\"replyBtnCommentUpload\" value=\"답글 작성\"></div>";
				html += "</form>";
				html += "</div>";
				
				
				html += "<div id=\"comment" + p.COMMENT_NO + "\" class=\"commentClass\">"
				html += "</div>";
				html += "</div>";
				

			} else {
				if(p.CNT > 0) {
					html += "<div class=\"comment_form1\">삭제된 댓글입니다";
					html += "<div class=\"btn_reply_upload_comment_delete_w\" cNo=\"" + p.COMMENT_NO + "\" >";

					html += "<input type=\"button\" class=\"btnReplyUpload\" id=\"btnReplyUpload\"" + p.COMMENT_NO + "\" value=\"답글 " + p.CNT + "\">";

					
					html += "<div class=\"reply_comment_form1_w1\" id=\"reply_comment_form1_w1" + p.COMMENT_NO + "\">";
					html += "<form action=\"#\" class=\"commentform\" id=\"go" + p.COMMENT_NO + "\" method=\"post\" cmt=\"" + p.COMMENT_NO + "\">";
					html += "<input type=\"hidden\" name=\"topCommentNo\" value=\"" + p.COMMENT_NO + "\">";
					html += "<input type=\"hidden\" class=\"userNo\" name=\"userNo\" value=\"${sUserNo}\">";
					html += "<input type=\"hidden\" name=\"postNo\" value=\"" + p.POST_NO + "\">";

					html += "</form>";
					html += "</div>";
					
					
					html += "<div id=\"comment" + p.COMMENT_NO + "\" class=\"commentClass\">"
					html += "</div>";			
					html += "</div>";
					html += "</div>";
				} else {
				}
			}
				

		}
	}
	
		$("#commentFormWrap").html(html);
		

		
		$(".btnReplyUpload").click(function() {
			var cNo = $(this).parent().attr("cNo");
			if($('#reply_comment_form1_w1' + cNo).css('display') == 'none') {
				$("#go" + cNo).parent().show();
				$("#comment" + cNo).show();
			} else {
				$("#go" + cNo).parent().hide();
				$("#comment" + cNo).hide();
			}
		});
		
		
		$(".btnReplyUpload").click(function() {
			var cNo = $(this).parent().attr("cNo");
			
			var params = "cNo=" + $(this).parent().attr("cNo");
			
			$.ajax({
				url: "replyCommentList", // 접속 주소
				type: "post", // 전송 방식: get, post
				dataType: "json", // 받아올 데이터 형태
				data: params, // 보낼 데이터(문자열 형태)
				success: function(res) { // 성공 시 다음 함수 실행
					
					replyCommentList(res.list, cNo);
				},
				error: function(request, status, error) { // 실패 시 다음 함수 실행
					console.log(error);
				}
			})
			
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
		
	
		
		
		
		
		$(".commentform").on("keypress", "input", function(event) {
			if(event.keyCode == 13) { // 엔터키를 눌렀을 때
				return false; // 페이지가 안넘어간다.
			}
		});
		
		
		
		//---------------------------------------댓글 신고하기기능
		$(".comment_declation").on("click", function(){
			if($('#userNo').val() != ""){

			$("#commentNo").val($(this).attr("commentNo"));
			
			var params= $("#goForm").serialize();
			
			$.ajax({
				url: "commentReport",
				type: "post",
				dataType: "json",
				data: params,
				success: function(res) {
				
					reportCommentPopup(res.data, res.userNo);
				},
				error: function(request, status, error) {
					console.log(error);
				}
			});
			
			} else {
				alert("로그인 후 이용해주세요.")
			}
		});
		

		
		
}

function replyCommentList(list, cNo) {
	var html = ""
	for(var p of list) {
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
			html += "<div del2=\"" + p.OUT_DATE + "\" no=\"" + p.USER_NO +"\" img=\"" + p.PROFILE_IMG_PATH +"\" introduce=\"" + p.INTRODUCE + "\" name=\"" + p.USER_NICKNAME + "\" class=\"reply_comment_name1\">" + p.USER_NICKNAME + "</div>";
			html += "<div class=\"reply_comment1\">" + p.CONTENT + "</div>";
			html += "<input type=\"hidden\" class=\"commentUserNo2\" value=\"" + p.USER_NO + "\">";
			html += "<div class=\"reply_comment1_date\">" + p.REGISTER_DATE;
			if("${sUserNo}" != p.USER_NO) {
			html += "<a class=\"reply_comment_declation\" replayCommentNo=\""+ p.COMMENT_NO +"\" href=\"#\">신고하기</a>";
			}
			html += "</div>";
			html += "<div class=\"reply_btn_reply_upload_comment_delete_w\" cNo2 = \"" +  p.COMMENT_NO + "\">";
			if("${sUserNo}" == p.USER_NO) {
				html += "<input type=\"button\" class=\"replyBtnCommentDelete\" id=\"replyBtnCommentDelete\" value=\"삭제\">";
			}
			html += "</div>";
			html += "</div>";
			html += "</div>";
			html += "<div class=\"commentWriteForm\"></div>";
		} else {
		}
	}

	
	$("#comment" + cNo).html(html);
	
	$("#comment" + cNo).on("click", ".reply_comment_name1", function() {
		$("#commentForm #authorNo").val($(this).attr("no"));
		$("#commentForm #userNo2").val($(this).attr("no"));
		$("#commentForm #userNickname").val($(this).attr("name"));
		$("#commentForm #userProfileImg").val($(this).attr("img"));
		$("#commentForm #userIntroduce").val($(this).attr("introduce"));
		
		if($(this).attr("del2") == "undefined") {
		
			if($(this).attr("no") != "${sUserNo}") {
				$("#commentForm").attr("target", "_blank");
				$("#commentForm").attr("action", "othergallary");
				$("#commentForm").submit();
			} else {
				$("#commentForm").attr("target", "_blank");
				$("#commentForm").attr("action", "mygallary");
				$("#commentForm").submit();
			}
		} else {
			alert("탈퇴한 회원입니다.");
		}
		
		console.log($("#authorNo").val());
		console.log($("#userNickname").val());
		console.log($("#userProfileImg").val());
		console.log($("#userIntroduce").val());
		console.log($("#userNo").val());
		console.log($("#userNo2").val());
	});
	
	//답글 신고하기 기능
	$(".reply_comment_declation").on("click", function(){
		if($('#userNo').val() != ""){
		$("#commentNo").val($(this).attr("replayCommentNo"));
		
		var params= $("#goForm").serialize();
		
		$.ajax({
			url: "commentReport",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res) {
			
				reportCommentPopup(res.data, res.userNo);
			},
			error: function(request, status, error) {
				console.log(error);
			}
		});
		} else {
			alert("로그인 후 이용해주세요.")
		}
		
	});
} 

function drawPaging(pb) {
	var html ="";
	
	html += "<a page=\"1\"><<</a>";
	if($("#page2").val() == "1") {
		html += "<a page=\"1\"><</a>";		
	} else {
		html += "<a page=\"" + ($("#page2").val() - 1) + "\"><</a>";
	}
	
	for(var i = pb.startPcount ; i <= pb.endPcount; i++){
		if($("#page2").val() == i) {
			html += "<a class=\"on\" page=\"" + i + "\">" + i + "</a>";			
		} else {
			html += "<a page=\"" + i + "\">" + i + "</a>";			
			
		}
	}
	
	if($("#page2").val() == pb.maxPcount) {
		html += "<a page=\"" + pb.maxPcount + "\">></a>";
	} else {
		html += "<a page=\"" + ($("#page2").val() * 1 + 1) + "\">></a>";
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





//--------------------------------------------------------------------신고하기



	function reportPopup(data, userNo){
		var html = "";
							                                                                                                                                   
		html +="<div class=\"background_r\"></div>";
		html +="	<div class=\"ctts_r\">";
		html += "	<form id=\"reportForm\">";
 		html += "		<input type=\"hidden\" name=\"pNo\" value=\"" + data.POST_NO + "\" />";
 		html +="<input type=\"hidden\" id=\"userNo\" name=\"userNo\" value=\""+ userNo +"\"/>";
		 		
 		var ranAdmin = Math.floor(Math.random()*6 + 1);
 				
 		html += "		<input type=\"hidden\" name=\"adminNo\" value=\"" + ranAdmin + "\" />"; 
		html += "		<input type=\"hidden\" name=\"checkArr\"  id=\"checkArr\"/>";
		html +="		<div class=\"top_ctt\">";
		html +="			<div class=\"top_ctt1\">";
		html +="			<div>신고하기</div>";
		html +="			</div>";
		html +="			<div class=\"top_ctt2\">";
		html +="			<b>신고합니다.</b>";
		html +="			</div>";
		html +="			<div class=\"top_ctt3\">";
		html +="			아래 내용을 제출합니다.";
		html +="			</div>";
		html +="			<div class=\"top_ctt4\">";
		html +="				<div class=\"top_ctt4-1\">신고사유</div>";
		html +="				<div class=\"checkbox_div\">";
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c1\" value=\"0\" class=\"check_one\"/>";
		html +="						<label for=\"c1\">홍보,영리목적</label>";
		html +="					</div>";
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c2\" value=\"1\" class=\"check_one\"/>";
		html +="						<label for=\"c2\">부적절한 홍보</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c3\" value=\"2\" class=\"check_one\"/>";
		html +="						<label for=\"c3\">불법정보</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"  id=\"c4\" value=\"3\" class=\"check_one\"/>";
		html +="						<label for=\"c4\">음란 또는 청소년에게 부적합한 내용</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\" id=\"c5\" value=\"4\" class=\"check_one\"/>";
		html +="						<label for=\"c5\">욕설비방차별혐</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c6\" value=\"5\" class=\"check_one\"/>";
		html +="						<label for=\"c6\">도배 스팸</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c7\" value=\"6\" class=\"check_one\"/>";
		html +="						<label for=\"c7\">개인정보 노출거래</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c8\" value=\"7\" class=\"check_one\"/>";
		html +="						<label for=\"c8\">저작권 및 명예훼손</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\" id=\"c9\" value=\"8\" class=\"check_one\"/>";
		html +="						<label for=\"c9\">기타</label>";
		html +="					</div>";	
		html +="				</div>";
		html +="			</div>";
		html +="			<div class=\"r_content_div\">";
		html +="				<div class=\"r_content-1\">내용<br/><span id=\"cttCnt\"></span></div>";
		html +="				<div class=\"report_content\">";
		html +="				<textarea rows=\"16\" cols=\"78\" name=\"reportCtt\" id=\"reportCtt\"></textarea></div>";
		html +="			</div>";
		html +="		</div><!-- --------------------------------------------top-ctt -->";
		html +="		<div class=\"btm-ctt\">";
		html +="			<div class=\"btm-ctt1\">";
		html +="				<ul>";
		html +="					<li><span class=\"font-red\">허위신고</span>일 경우 신고자에 대한 제재가 있을 수 있습니다.</li>";
		html +="					<li>신고내용의 사유에 따라 사용자를 처벌하는 시간이 다소 걸릴 수 있습니다.</li>";
		html +="					<li>이 글이 신고사유에 해당하는 글인지 다시 한 번 <span class=\"font-red\">확인</span>하시기 바랍니다.<br/>";
		html +="					<li>신고하게 된 이유를 자세히 써주시면 운영자의 관련 결정에 도움이 됩니다.</li>";
		html +="					신고기능은 글 작성자에게 <span class=\"font-red\">피해</span>를 줄 수 있으며, <span class=\"font-red\">3회</span> 부정신고 시";
		html +="					<span class=\"font-red\">영구적</span>으로 이용이 제한됩니다.</li>";
		html +="				</ul>";
		html +="			</div>";
		html +="			<div class=\"btm-ctt2\">";
		html +="			<div class=\"btm-ctt3\">";
		html +="				<div class=\"btn_rot\">신고</div>";
		html +="				<div class=\"btn_cancel\">취소</div>";
		html +="			</div>";
		html +="			</div>";
		html +="		</div>";
		html += "	</form>";
		html +="	</div>";

			
			
			$("body").prepend(html);
			
			$(".background_r").hide();
			$(".ctts_r").hide();				
			$(".background_r").fadeIn();
			$(".ctts_r").fadeIn();
			
			//닫기
			$(".btn_cancel").off("click");
			$(".btn_cancel").on("click", function(){
				closePopup();
			});
			
			$(".background_r").off("click");
			$(".background_r").on("click", function(){
				closePopup();
			}); 
			
			
			
			//신고하기 textarea 글자수 제한
			$("#reportCtt").on("keyup", function(){
				
				$("#cttCnt").html("(" + $(this).val().length + "/ 500)");
				
				if($(this).val().length > 500){
					$(this).val($(this).val().substring(0,500));
					$("#cttCnt").html("(500 / 500)");
				}				
			});
	
						
			//----------------------------------------------신고할 때
				$(".btn_rot").off("click");
				$(".btn_rot").on("click", function(){
					
	
						//체크박스 값 보내기		
						$("#checkArr").val("");
						$(".checkbox_div [type='checkbox']:checked").each(function(){					
							$("#checkArr").val($("#checkArr").val() + "," + $(this).val());
						});
			
						$("#checkArr").val($("#checkArr").val().substring(1));//처음,안나오게하기위해서
						
						if($(".checkbox_div [type='checkbox']:checked").length == 0){
							alert("선택된 신고사유가 없습니다. 신고사유를 선택하세요.");
		
						} else {
							var params = $("#reportForm").serialize();
							$.ajax({
								type : "post",
								url : "userReports",
								dataType : "json",
								data : params,
								success : function(result) {
									
									if(result.msg == "success"){
										alert("정상적으로 신고 접수되었습니다.");
										closePopup();
									} else if(result.msg == "failed"){
										alert("신고에 실패했습니다.");
									} else {
										console.log(result);
										alert("신고 전송 중 문제가 발생했습니다.");										
									}						
					
								},
								error: function(request, status, error){
									console.log(error);
									
								}
							
							});//ajax

						}//else		

					//로그인 안했을 시

				});//신고하기버튼누르면	
	};//popup end

	
	//댓글신고 팝업
	function reportCommentPopup(data, userNo){
		var html = "";
							                                                                                                                                   
		html +="<div class=\"background_c\"></div>";
		html +="	<div class=\"ctts_c\">";
		html += "	<form id=\"reportForm\">";
		html += "		<input type=\"hidden\" name=\"cNo\" value=\"" + data.COMMENT_NO + "\" />";
 		html += "		<input type=\"hidden\" name=\"pNo\" value=\"" + data.POST_NO + "\" />";
 		html +="<input type=\"hidden\" id=\"userNo\" name=\"userNo\" value=\""+ userNo +"\"/>";
		 		
 		var ranAdmin = Math.floor(Math.random()*6 + 1);
 				
 		html += "		<input type=\"hidden\" name=\"adminNo\" value=\"" + ranAdmin + "\" />"; 
		html += "		<input type=\"hidden\" name=\"checkArr\"  id=\"checkArr\"/>";
		html +="		<div class=\"top_ctt\">";
		html +="			<div class=\"top_ctt1\">";
		html +="			<div>신고하기</div>";
		html +="			</div>";
		html +="			<div class=\"top_ctt2\">";
		html +="			<b>신고합니다.</b>";
		html +="			</div>";
		html +="			<div class=\"top_ctt3\">";
		html +="			아래 내용을 제출합니다.";
		html +="			</div>";
		html +="			<div class=\"top_ctt4\">";
		html +="				<div class=\"top_ctt4-1\">신고사유</div>";
		html +="				<div class=\"checkbox_div\">";
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c1\" value=\"0\" class=\"check_one\"/>";
		html +="						<label for=\"c1\">홍보,영리목적</label>";
		html +="					</div>";
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c2\" value=\"1\" class=\"check_one\"/>";
		html +="						<label for=\"c2\">부적절한 홍보</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c3\" value=\"2\" class=\"check_one\"/>";
		html +="						<label for=\"c3\">불법정보</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"  id=\"c4\" value=\"3\" class=\"check_one\"/>";
		html +="						<label for=\"c4\">음란 또는 청소년에게한 내용</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\" id=\"c5\" value=\"4\" class=\"check_one\"/>";
		html +="						<label for=\"c5\">욕설비방차별혐</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c6\" value=\"5\" class=\"check_one\"/>";
		html +="						<label for=\"c6\">도배 스팸</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c7\" value=\"6\" class=\"check_one\"/>";
		html +="						<label for=\"c7\">개인정보 노출거래</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\"id=\"c8\" value=\"7\" class=\"check_one\"/>";
		html +="						<label for=\"c8\">저작권 및 명예훼손</label>";
		html +="					</div>";	
		html +="					<div>";
		html +="						<input type=\"checkbox\" id=\"c9\" value=\"8\" class=\"check_one\"/>";
		html +="						<label for=\"c9\">기타</label>";
		html +="					</div>";	
		html +="				</div>";
		html +="			</div>";
		html +="			<div class=\"r_content_div\">";
		html +="				<div class=\"r_content-1\">내용<br/><span id=\"cttCnt\"></span></div>";
		html +="				<div class=\"report_content\">";
		html +="				<textarea rows=\"16\" cols=\"78\" name=\"reportCtt\" id=\"reportCtt\"></textarea></div>";
		html +="			</div>";
		html +="		</div><!-- --------------------------------------------top-ctt -->";
		html +="		<div class=\"btm-ctt\">";
		html +="			<div class=\"btm-ctt1\">";
		html +="				<ul>";
		html +="					<li><span class=\"font-red\">허위신고</span>일 경우 신고자에 대한 제재가 있을 수 있습니다.</li>";
		html +="					<li>신고내용의 사유에 따라 사용자를 처벌하는 시간이 다소 걸릴 수 있습니다.</li>";
		html +="					<li>이 글이 신고사유에 해당하는 글인지 다시 한 번 <span class=\"font-red\">확인</span>하시기 바랍니다.<br/>";
		html +="					<li>신고하게 된 이유를 자세히 써주시면 운영자의 관련 결정에 도움이 됩니다.</li>";
		html +="					신고기능은 글 작성자에게 <span class=\"font-red\">피해</span>를 줄 수 있으며, <span class=\"font-red\">3회</span> 부정신고 시";
		html +="					<span class=\"font-red\">영구적</span>으로 이용이 제한됩니다.</li>";
		html +="				</ul>";
		html +="			</div>";
		html +="			<div class=\"btm-ctt2\">";
		html +="			<div class=\"btm-ctt3\">";
		html +="				<div class=\"btn_rot\">신고</div>";
		html +="				<div class=\"btn_cancel\">취소</div>";
		html +="			</div>";
		html +="			</div>";
		html +="		</div>";
		html += "	</form>";
		html +="	</div>";

			
			
			$("body").prepend(html);
			
			$(".background_c").hide();
			$(".ctts_c").hide();				
			$(".background_c").fadeIn();
			$(".ctts_c").fadeIn();
			
			//닫기
			$(".btn_cancel").off("click");
			$(".btn_cancel").on("click", function(){
				closePopupComment();
			});
			
			$(".background_c").off("click");
			$(".background_c").on("click", function(){
				closePopupComment();
			}); 
			
			
			
			//신고하기 textarea 글자수 제한
			$("#reportCtt").on("keyup", function(){
				
				$("#cttCnt").html("(" + $(this).val().length + "/ 500)");
				
				if($(this).val().length > 500){
					$(this).val($(this).val().substring(0,500));
					$("#cttCnt").html("(500 / 500)");
				}				
			});
	
						
			//----------------------------------------------신고할 때
				$(".btn_rot").off("click");
				$(".btn_rot").on("click", function(){
					
					
					
						//체크박스 값 보내기		
						$("#checkArr").val("");
						$(".checkbox_div [type='checkbox']:checked").each(function(){					
							$("#checkArr").val($("#checkArr").val() + "," + $(this).val());
						});
			
						$("#checkArr").val($("#checkArr").val().substring(1));//처음,안나오게하기위해서
						
						if($(".checkbox_div [type='checkbox']:checked").length == 0){
							alert("선택된 신고사유가 없습니다. 신고사유를 선택하세요.");
							
						} else {
								var params = $("#reportForm").serialize();

								$.ajax({
									type : "post",
									url : "userCommentReports",
									dataType : "json",
									data : params,
									success : function(result) {
										
										if(result.msg == "success"){
											closePopupComment();
											alert("정상적으로 신고 접수되었습니다.");
										} else if(result.msg == "failed"){
											alert("신고에 실패했습니다.");
										} else {
											console.log(result);
											alert("신고 전송 중 문제가 발생했습니다.");
										}						
						
									},
									error: function(request, status, error){
										console.log(error);
										
									}
								
								});//ajax
						}//else						
					//로그인 안했을 시

				});//신고하기버튼누르면	
	};//댓글 신고popup end	

	
	
	
	//신고하기 팝업 닫기
	function closePopup() {
		$(".background_r").fadeOut(function(){
		$(".background_r").remove();
		});
		
		$(".ctts_r").fadeOut(function(){
		$(".ctts_r").remove();
		});	
	}
	
	//댓글 신고 팝업 닫기
		function closePopupComment() {
		$(".background_c").fadeOut(function(){
		$(".background_c").remove();
		});
		
		$(".ctts_c").fadeOut(function(){
		$(".ctts_c").remove();
		});	
	}




</script>
</head>
<body>

	<img src="resources/images/JY/left_arrow2.png" id="leftArrow"
		alt="왼쪽 화살표" width="50px" height="50px">

	<!-- 글 작가와 본인이 동일할 때 -->
	<div class="header">
		<img src="resources/images/JY/menu.png" id="btnMenu" alt="메뉴"
			width="35px" height="40px"> <a href="main"><img
			src="resources/images/JY/art2.png" id="btnLogo" alt="로고" width="70px"
			height="40px"></a>
		<c:choose>
			<c:when test="${empty data.RD}">
				<img src="resources/images/JY/heart.png" id="btnLike" class="heart"
					alt="투명하트" width="25px" height="25px">
			</c:when>
			<c:otherwise>
				<img src="resources/images/JY/heart2.png" id="btnLike" class="heart"
					alt="빨간하트" width="25px" height="25px">
			</c:otherwise>
		</c:choose>

		<div class="like_cnt_wrap">
			<%-- <div id="likeCnt" class="like_cnt">${data.LIKECNT}</div> --%>
		</div>
		<img src="resources/images/JY/comment2.png" id="btnComment" alt="댓글"
			width="20px" height="20px">
		<div class="comment_cnt_wrap"></div>
		<img src="resources/images/JY/share.png" id="btnShare" alt="공유"
			width="20px" height="20px"> <img
			src="resources/images/JY/dot1.png" id="btnDot1" alt="메뉴" width="25px"
			height="25px"> <img src="resources/images/JY/dot2.png"
			id="btnDot2" alt="메뉴" width="25px" height="25px"> <img
			src="resources/images/JY/edit.png" id="btnEdit" alt="수정" width="20px"
			height="20px"> <img src="resources/images/JY/delete.png"
			id="btnDelete" alt="삭제" width="25px" height="25px">
	</div>
	<div class="share_wrap">
		<div class="share">아트 글을 공유해보세요.</div>
		<input type="text" id="shareAddress"
			value="http://localhost:8090/art/detail" /> <input type="button"
			id="btnShareAddress" value="Copy" onclick="javascript:CopyUrl()" />
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
		<img src="resources/images/JY/declation.png" id="btnDeclation2" alt="신고" width="20px" height="20px">
	</div>
	<div class="share_wrap2">
		<div class="share2">아트 글을 공유해보세요.</div>
		<input type="text" id="shareAddress2" value="http://localhost:8090/art/detail" />
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
			<div class="side_bar_menu1">
				<a href="mygallary">나의 작업실</a>
			</div>
			<br />
			<div class="side_bar_menu1">
				<a href="gallary">작품 보러가기</a>
			</div>
			<br />
			<div class="side_bar_menu3">
				<a href="profile">마이페이지</a>
			</div>
			<br />
			<div class="side_bar_menu4">
				<a href="gongji">공지사항</a>
			</div>
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

		<c:choose>
			<c:when test="${data.CATEGORY_NO eq '3'}">
				<div class="contents_wrap">${data.VIDEO_LINK}</div>
			</c:when>

			<c:otherwise>
				<div class="contents_wrap">
					<img class="contents_img" src="resources/upload/${data.POST_FILE}">
				</div>
			</c:otherwise>
		</c:choose>

		<div class="category">${data.CATEGORY_NAME}</div>
		<div class="title">${data.TITLE}</div>
		<div class="contents_date">${data.REGISTER_DATE}</div>
		<div class="views">조회수 ${data.VIEWS}</div>
		<br /> <br />
		<div class="contents">${data.EXPLAIN}</div>
		<c:if test="${!empty array}">
			<c:forEach var="i" items="${array}">
				<i class="tag"># ${i}</i>
			</c:forEach>
		</c:if>

		<div class="comment_wrap1">
			<img class="comment_img" src="resources/images/JY/comment.png" width="30px" height="30px">
			<div class="comment">댓글</div>
		</div>
		<br />

		<div class="comment_wrap2">
			<form action="#" id="goForm" method="post">
				<input type="hidden" id="pNo" name="pNo" value="${data.POST_NO}" />
				<input type="hidden" id="postNo" name="postNo" value="${data.POST_NO}" />
				<input type="hidden" id="userNo" name="userNo" value="${sUserNo}" />
				<input type="hidden" id="authorNo" name="authorNo" value="${data.USER_NO}" />
				<input type="hidden" id="userNo2" name="userNo2" value="${data.USER_NO}" />
				<input type="hidden" id="userNickname" name="userNickname" value="${data.USER_NICKNAME}" />
				<input type="hidden" id="userIntroduce" name="userIntroduce" value="${data.INTRODUCE}" />
				<input type="hidden" id="userProfileImg" name="userProfileImg" value="${data.PROFILE_IMG_PATH}" />
				<input type="hidden" id="tab" name="tab" value="${param.tab}" />
				<input type="hidden" name="page" id="page" value="${param.page}" />
				<input type="hidden" name="page2" id="page2" value="${page}" />
				<input type="hidden" id="searchTxt" name="searchTxt" value="${param.searchTxt}" />
				<input type="hidden" id="tabFlag" name="tabFlag" value="${param.tabFlag}" /> 
				<input type="hidden" name="selectGbn" value="${param.selectGbn}" />
				<input type="hidden" name="visibility" value="${param.visibility}" />
				<input type="hidden" name="commentNo" id="commentNo" value="" />
				<input type="hidden" name="ReplyCommentNo" id="ReplyCommentNo" value="" />
				<input type="hidden" id="listPage" name="listPage" value="${param.listPage}" />
				<input type="hidden" id="commentGbn" name="commentGbn" value="0" />
				<div class="comment_title">
					댓글 <span class="comment_cnt2"></span>
				</div>
				<div class="comment_write_w">
					<input id="commentWrite" name="commentWrite" type="text" placeholder="댓글을 남겨보세요.">
				</div>
				<div class="btn_comment_upload_w">
					<input type="button" id="btnCommentUpload" value="댓글 작성">
				</div>
				<div class="select_cnt_div">
					<div class="select_cnt_box">	
						<div class="select_flag_div">
							<ul class="select_flag">
								<li class="recent_order" id="active">최신순</li>
								<li class="past_order">과거순</li>
								<li class="comment_cnt_order">답글순</li>
							</ul>
						</div>
					</div>
				</div>	
	
	
			</form>
			<hr>
			<div id="commentFormWrap"></div>




			<div class="pagination"></div>
		</div>
		<div class="profile2_wrap">

			<c:choose>
				<c:when test="${empty data.PROFILE_IMG_PATH}">
					<div class="profile2">
						<img class="profile_img2" src="resources/images/JY/who.png" alt="프로필사진" width="40px" height="40px">
					</div>
				</c:when>
				<c:otherwise>
					<div class="profile2">
						<img class="profile_img2" src="resources/upload/${data.PROFILE_IMG_PATH}" alt="프로필사진" width="40px" height="40px">
					</div>
				</c:otherwise>
			</c:choose>


			<div class="profile_name2">${data.USER_NICKNAME}</div>
			<div class="profile_introduce">${data.INTRODUCE}</div>
		</div>
	</div>

	<c:import url="footer.jsp"></c:import>

</body>
</html>