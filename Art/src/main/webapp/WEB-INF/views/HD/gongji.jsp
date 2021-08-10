<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" type="text/css" href="resources/css/HD/gongji.css"/>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

var loadFlag = true;
	loadList();
$(document).ready(function() {
	$("#recentPost").attr("class","selected");
	
	//------------------------------------------- 사이드바 
	
	
//---------------------------------------------------------- 무한 스크롤 페이지	

 /* $(".main").scroll(function () {
	if(loadFlag) {
		if($(".ctts_wrap").height() <= $(".main").scrollTop() + $(".main").height()){

			
			$("#page").val(($("#page").val()*1) +1);
			
			loadList();
			console.log("이제 여기에 아작스 찍자");
			console.log($(".ctts_wrap").innerHeight() );
		console.log("문서 높이" + $(document).height());
		console.log("cttwrap 총 높이"+$(".ctts_wrap").height());
		console.log("cttwrap 높이"+$(".ctts_wrap").scrollTop());
		console.log("window 높이"+$(window).scrollTop());
		console.log("window 높이"+$(window).height());
		console.log("window 높이"+$(window).innerHeight());
		
		}
	} 
});
 */
	$(".main").scroll(function(){
			console.log($(this).innerHeight());
			console.log($(this)[0].scrollHeight);
			console.log($(this).scrollTop());
			console.log($(this).prop('scrollHeight'));
		if($(this).scrollTop() + $(this).innerHeight() >= $(this).prop('scrollHeight')){
			$("#page").val($("#page").val() * 1 + 1);
			loadList();
		} 
	
});









//--------------------------------------------------------------
	
	
	
	$('#btnLook').click(function() {
		location.href="searchGallaryPage";
	});
	//--------------------------------------- 오래된 클릭
	$("#oldPost").on("click", function () {
		$("#oldPost").attr("class","selected");
		$("#recentPost").attr("class","recentPost");
		$("#sortO").val("0");
		$("#page").val("1");
		$("div .main_ctt2").remove();
		loadList();
	});
	
	
	//---------------------------------------- 최신 클릭
	$("#recentPost").on("click", function () {
		$("#recentPost").attr("class","selected");
		$("#oldPost").attr("class","recentPost");
		$("#sortO").val("1");
		$("#page").val("1");
		$("div .main_ctt2").remove();
		loadList();
	});
	
	
	//---------------------------------------- 더블 클릭시 해당 상세페이지로 이동 시키기
	
	$("body").on("dblclick",".main_ctt2_cover", function () {
		$("#noticeNo").val($(this).attr("name"));
		$("#actionFrom").attr("action","gong_detail");
		$("#actionFrom").submit();
		console.log("실행 여부 확인");
	});
	
});

	function check(chk) {
		var obj = document.getElementsByName("check");
		for (var i = 0; i < obj.length; i++) {
			if (obj[i] != chk) {
				obj[i].checked = false;
			}
		}
	}
	
	//-------------------------------------------------- 게시판 출력 아작스
	function loadList() {
		console.log("발동");
		$("#actionForm").attr("action","gongji_page")
		var params = $("#actionFrom").serialize();
		
		$.ajax({
			url : "gongji_page",
			type : "post",
			dataType : "json",
			data : params,
			success: function (res) {
				console.log(res.list);
					drawList(res.list, res.cnt);
			},
			error : function (request, status, error) {
				console.log(error);
			}
		});
	}
	
	
	
	
	//-------------------------------------------------- 게시판 리스트 출력
	
	function drawList(list,cnt) {
		var html ='';
		if(list == null || list.length == 0) {
			loadFlag = false;
		}
		for(var d of list){
			html+= "	<div class=\"main_ctt2\">";
			html+= "		<div class=\"main_ctt2_cover\" name=\"" + d.NOTICE_NO + "\">";
			html+= "			<div class=\"second\" >";
			if(d.FILE_PATH =="" && d.FILE_PATH == null ){
				html+= "				<img src=\"resources/images/JY/art2.png\" alt=\"content\">";
			}else{
				console.log("여기 실행은 되니? 엘스 창이야");
				html+= "				<img src=\"resources/images/JY/art2.png\" alt=\"content\">";
				/* html+= "				<img src=\"resources/upload/" + d.FILE_PATH + "\" alt=\"content\">"; */
			}
			
			html+= "			</div>";
			html+= "			<div class=\"first\">";
			html+= "				<h5> " + d.TITLE + "</h5>";
			html+= "				<div class=\"sub-ctt\">";
			html+= "					<span>" + d.CONTENTS + "</span>";
			html+= "				</div>";
			html+= "				<span class=\"sub-ctt-bottom\">by Art </span>";
			html+= "			</div>";
			html+= "		</div>";
			html+= "	</div>";
		}
		
		$(".ctts_wrap").append(html);
		
		html = cnt + "개의 글";
		
		$(".left").html(html);
	}


</script>
</head>
<body>

	<form action="#" id="actionFrom" method="post">
		<input type="hidden" id="noticeNo" name="noticeNo">
		<input type="hidden" id="sortO" name="sortO" >
		<input type="hidden" id="page" name="page" value="1">
	</form>
	
	<c:choose>

		<c:when test="${empty sUserNo}">
			<c:import url="../JY/header2.jsp">
				<c:param name="url" value="gongji"></c:param>
			</c:import>
		</c:when>

		<c:otherwise>
			<c:import url="../JY/header.jsp">
				<c:param name="url" value="gongji"></c:param>
			</c:import>
		</c:otherwise>

	</c:choose>
	
	<!-----------------------------------------------------------------header 검색하는 부분  -->
	<div class="ctts">
		<span class="gong">공지사항</span>
	</div>
			<!-------------------------------------------------만약 검색어가 없을 경우  -->
<div class="main">	
	<div class="ctts_wrap">
		<div class="main_ctt">
			<div class="left">n개의 글</div>
			<div class="right">
				<ul>
					<li id="oldPost" class="oldPost">오래된</li>
					<li id="recentPost" class="recentPost">최신</li>
				</ul>
			</div>
		</div>
		
	</div>
</div>
<div class="ftr">
	<a href="main.html"><img src="resources/images/JY/art2_w.png" id="btnLogo2" alt="로고" width="70px" height="50px"></a>
	<div class="ftr_pae">You can be an art writer.</div>
	<div class="footer1">Copyright © 2021 ART PROJECT All Rights Reserved.</div>
	<!-- <div id="ftr1"><a href="#">관리방침 안내</a></div>
	<div id="ftr2"><a href="#">도움말 안내</a></div>
	<div id="ftr3"><a href="#">회원가입 및 글게시 안내</a></div>
	<div id="ftr4"><a href="#">홈페이지 서비스 안내</a></div> -->
</div>

</body>
</html>