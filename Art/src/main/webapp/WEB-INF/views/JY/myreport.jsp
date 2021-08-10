<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인정보 관리</title>
<link rel="stylesheet" href="resources/css/JY/myreport.css">
<script type="text/javascript" src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	reportPostList();
	reportCommentList();
	
	
	$(".profile_manage").on("click", function() {
		location.href = "profile";
	});
	
	$(".privacy").on("click", function() {
		location.href = "set";
	});
	
	$(".stop").on("click", function() {
		location.href = "withdrawal";
	});
	
	$(".report").on("click", function() {
		location.href = "myreport";
	});
	
	$(".post_wrap").on("dblclick", "td:not(:last-child)", function() {
		$("#pNo").val($(this).parent().attr("pno"));
		$("#postNo").val($(this).parent().attr("pno"));
		console.log($(this).parent().attr("del"));
		if($(this).parent().attr("del") == "1") {
			$("#goForm").attr("action", "detail");
			$("#goForm").submit();
		} else {
			alert("삭제된 작품입니다.");
		}
		
	});
	
	$(".comment_wrap").on("dblclick", "td:not(:last-child)", function() {
		$("#pNo").val($(this).parent().attr("pno"));
		$("#postNo").val($(this).parent().attr("pno"));
		if($(this).parent().attr("del") == "1") {
			$("#goForm").attr("action", "detail");
			$("#goForm").submit();
		} else {
			alert("삭제된 작품입니다.");
			return false;
		}
		
		if($(this).parent().attr("del2") == "1") {
			$("#goForm").attr("action", "detail");
			$("#goForm").submit();
		} else {
			alert("삭제된 댓글입니다.");
			$("#goForm").attr("action", "detail");
			$("#goForm").submit();
		}
	});
	
	
	$(".report_menu1_contents").scroll(function(){
		if(Math.ceil($(this).scrollTop()) + $(this).innerHeight() >= $(this)[0].scrollHeight){
			$("#page").val($("#page").val() * 1 + 1);
			reportPostList();
		} 
	});
	
	$(".report_menu2_contents").scroll(function(){
		if(Math.ceil($(this).scrollTop()) + $(this).innerHeight() >= $(this)[0].scrollHeight){
			$("#page").val($("#page").val() * 1 + 1);
			reportCommentList();
		} 
	});

	
	console.log($("#page").val());
	
	$(".post_wrap tbody").on("click", ".cancel", function() {
		$("#reportNo").val($(this).parent().parent().attr("name"));
		console.log($("#reportNo").val());
		var result = confirm('정말 취소하시겠습니까?');
		
		if(result) {
		var params = $("#goForm").serialize();

		$.ajax({
			url: "changeMyReport",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res){
				if(res.msg == "success") {
					alert("정상적으로 신고 접수가 취소되었습니다.");
					$("#goForm").attr("action", "myreport");
					$("#goForm").submit();
				} else if(res.msg == "failed") {
					alert("삭제 중 오류가 발생하였습니다.");
				} else {
					alert("삭제 중 문제가 발생하였습니다.")
				}
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	}
	});
	
	$(".post_wrap tbody").on("click", ".delete", function() {
		$("#reportNo").val($(this).parent().parent().attr("name"));
		console.log($("#reportNo").val());
		var result = confirm('정말 삭제하시겠습니까?');
		
		if(result) {
		var params = $("#goForm").serialize();

		$.ajax({
			url: "deleteMyReport",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res){
				if(res.msg == "success") {
					alert("정상적으로 삭제되었습니다.");
					$("#goForm").attr("action", "myreport");
					$("#goForm").submit();
				} else if(res.msg == "failed") {
					alert("삭제 중 오류가 발생하였습니다.");
				} else {
					alert("삭제 중 문제가 발생하였습니다.")
				}
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	}
	});
	
	$(".comment_wrap tbody").on("click", ".cancel2", function() {
		$("#reportNo").val($(this).parent().parent().attr("name"));
		console.log($("#reportNo").val());
		var result = confirm('정말 취소하시겠습니까?');
		
		if(result) {
		var params = $("#goForm").serialize();

		$.ajax({
			url: "changeMyReport",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res){
				if(res.msg == "success") {
					alert("정상적으로 신고 접수가 취소되었습니다.");
					$("#goForm").attr("action", "myreport");
					$("#goForm").submit();
				} else if(res.msg == "failed") {
					alert("삭제 중 오류가 발생하였습니다.");
				} else {
					alert("삭제 중 문제가 발생하였습니다.")
				}
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	}
	});
	
	$(".comment_wrap tbody").on("click", ".delete2", function() {
		$("#reportNo").val($(this).parent().parent().attr("name"));
		console.log($("#reportNo").val());
		var result = confirm('정말 삭제하시겠습니까?');
		
		if(result) {
		var params = $("#goForm").serialize();

		$.ajax({
			url: "deleteMyReport",
			type: "post",
			dataType: "json",
			data: params,
			success: function(res){
				if(res.msg == "success") {
					alert("정상적으로 삭제되었습니다.");
					$("#goForm").attr("action", "myreport");
					$("#goForm").submit();
				} else if(res.msg == "failed") {
					alert("삭제 중 오류가 발생하였습니다.");
				} else {
					alert("삭제 중 문제가 발생하였습니다.")
				}
				
			}, error: function(request, status, error){
				console.log(error);
			}
		});
	}
	});
});

function reportPostList(){
	var params = $("#goForm").serialize();

	$.ajax({
		url: "myReportPostList",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result){
			
			drawReportPostList(result.list);
		

			
		}, error: function(request, status, error){
			console.log(error);
		}
	});
}

function reportCommentList(){
	var params = $("#goForm").serialize();

	$.ajax({
		url: "myReportCommentList",
		type: "post",
		dataType: "json",
		data: params,
		success: function(result){
			
			drawReportCommentList(result.list2);
		
			
		}, error: function(request, status, error){
			console.log(error);
		}
	});
}

function drawReportPostList(list){
	var html = "";
	

	for(var d of list){
		html +="<tr name=\"" + d.REPORT_NO + "\" pno=\"" + d.POST_NO + "\" del=\"" + d.DEL + "\">";
		html +="<td>" + d.TYPE_NAME + "</td>";
		html +="<td>" + d.USER_NICKNAME + "</td>";
		if(d.CONTENTS != null) {
			html += "<td>" + d.CONTENTS + "</td>";
		} else {
			html += "<td>내용없음</td>";
		}
		html +="<td>" + d.REGISTER_DATE + "</td>";
		if(d.REPORT_STATUS == "0") {
			html +="<td>대기중</td>";
		} else if(d.REPORT_STATUS == "1") {
			html +="<td>철회</td>";
		} else if(d.REPORT_STATUS == "2") {
			html +="<td>접수완료</td>";
		} else if(d.REPORT_STATUS == "3") {
			html +="<td>처리완료</td>";
		}
		
		if(d.REPORT_STATUS == "1") {
			html += "<td><input type=\"button\" id=\"delete\" class=\"delete\" value=\"삭제하기\"></td>";
		} else if(d.REPORT_STATUS == "0") {
			html += "<td><input type=\"button\" id=\"cancel\" class=\"cancel\" value=\"취소하기\"></td>";
		} else if(d.REPORT_STATUS == "3") {
			html += "<td><input type=\"button\" id=\"delete\" class=\"delete\" value=\"삭제하기\"></td>";
		} else {
			html += "<td></td>"
		}
		html +="</tr>";
	}	
	
	
	$(".post_wrap tbody").append(html);
	

}


function drawReportCommentList(list2){
	var html = "";
	
	for(var d of list2){
		html +="<tr name=\"" + d.REPORT_NO + "\" pno=\""  + d.POST_NO + "\" del=\"" + d.DEL + "\" del2=\"" + d.DEL2 + "\">";
		html +="<td>" + d.TYPE_NAME + "</td>";
		html +="<td>" + d.USER_NICKNAME + "</td>";
		if(d.CONTENTS != null) {
			html += "<td>" + d.CONTENTS + "</td>";
		} else {
			html += "<td>내용없음</td>";
		}
		html +="<td>" + d.REGISTER_DATE + "</td>";
		if(d.REPORT_STATUS == "0") {
			html +="<td>대기중</td>";
		} else if(d.REPORT_STATUS == "1") {
			html +="<td>철회</td>";
		} else if(d.REPORT_STATUS == "2") {
			html +="<td>접수완료</td>";
		} else if(d.REPORT_STATUS == "3") {
			html +="<td>처리완료</td>";
		}

		if(d.REPORT_STATUS == "1") {
			html += "<td><input type=\"button\" id=\"delete\" class=\"delete2\" value=\"삭제하기\"></td>";
		} else if(d.REPORT_STATUS == "0") {
			html += "<td><input type=\"button\" id=\"cancel\" class=\"cancel2\" value=\"취소하기\"></td>";
		} else if(d.REPORT_STATUS == "3") {
			html += "<td><input type=\"button\" id=\"delete\" class=\"delete2\" value=\"삭제하기\"></td>";
		} else {
			html += "<td></td>"
		}
		
		
		html +="</tr>";
	}	
	
	
	$(".comment_wrap tbody").append(html);
	

	
}
</script>
</head>
<body>
<form action="#" id="goForm" method="post">
	<input type="hidden" name="userNo" value="${sUserNo}">
	<input type="hidden" id="reportNo" name="reportNo" value="">
	<input type="hidden" id="pNo" name="pNo" value="">
	<input type="hidden" id="page" name="page" value="1">
	<input type="hidden" id="listPage" name="listPage" value="5">
	<input type="hidden" id="postNo" name="postNo" value="">
</form>
	
	<c:choose>
		<c:when test="${empty sUserNo}">
			<c:import url="header2.jsp"></c:import>
		</c:when>
		<c:otherwise>
			<c:import url="header.jsp">
				<c:param name="url" value="profile"></c:param>
			</c:import>
		</c:otherwise>
	</c:choose>
	
	<div class="wrap">
		<div class="btn_menu">
			<div class="set">마이페이지</div>
			<div class="report">나의 신고목록</div>
			<div class="profile_manage">프로필관리</div>
			<div class="privacy">개인정보관리</div>
			<div class="stop">탈퇴하기</div>
		</div>
		<div class="contents">
			<div class="title">신고목록</div>
			<div class="report_type">A : 홍보·영리목적, B : 부적절한 홍보, C : 불법 정보, D : 음란 또는 청소년에게 부적합한내용, E : 욕설·비방·차별 혐오<br/>F : 도배·스팸, G : 개인정보 노출 거래, H : 저작권 및 명예훼손, I : 기타</div>
			<div class="report_wrap">
			<div class="report_wrap2">
				<div class="tabs">
					<input id="reportMenu1" type="radio" value="0" name="tab" checked="checked" />
					<input id="reportMenu2" type="radio" value="1" name="tab" />
					<label for="reportMenu1">작품 신고 내역</label>
					<label for="reportMenu2">댓글 신고 내역</label>
					

					<div class="report_menu1_contents">
						<div class="post_wrap">
						<table cellspacing="0" class="table">
							<colgroup>
								<col width="80px"/>
								<col width="160px"/>
								<col width="400px"/>
								<col width="100px"/>
								<col width="100px"/>
								<col width="100px"/>
							</colgroup>
							<thead>
							<tr>
								<th>신고타입</th>
								<th>피신고자</th>
								<th>신고내용</th>
								<th>신고일</th>
								<th>처리상태</th>
								<th></th>
							</tr>
							</thead>
							<tbody></tbody>	
						</table>				
						</div> 
					</div>
					
					<div class="report_menu2_contents">
						<div class="comment_wrap">
						<table cellspacing="0" class="table">
							<colgroup>
								<col width="80px"/>
								<col width="160px"/>
								<col width="400px"/>
								<col width="100px"/>
								<col width="100px"/>
								<col width="100px"/>
							</colgroup>
							<thead>
							<tr>
								<th>신고타입</th>
								<th>피신고자</th>
								<th>신고내용</th>
								<th>신고일</th>
								<th>처리상태</th>
								<th></th>
							</tr>
							</thead>
							<tbody></tbody>	
						</table>
						</div> 
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
	
	<c:import url="footer.jsp"></c:import>
</body>
</html>