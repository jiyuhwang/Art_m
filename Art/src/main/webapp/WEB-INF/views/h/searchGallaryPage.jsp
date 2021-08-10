<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작품 검색페이지</title>
<link rel="stylesheet" type="text/css" href="resources/css/h/search_gallary_page.css"/>


<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$(".srh_cnt").css("display", "none");
	
	/* 순서 지켜야 파람값 지정됨. */
	if("${param.tabFlag}" != "") {
		$("input[name=tabFlag]").prop("checked", false);
		$("input[name=tabFlag][value='${param.tabFlag}']").prop("checked", true);
	}
	
	if($("#searchTxt").val() != "") {
		reloadList();
	}

	$("#searchTxt").on("keypress", function(event){
		if(event.keyCode == 13){
			if($.trim($(this).val()) == ""){
				alert("검색어가 없습니다.");
				$(this).focus();
			} else {
				$(".srh_cnt").css("display", "block");
				$("#page").val("1");
 				$("#orderFlag").val("0");
 				$("#searchOldTxt").val($("#searchTxt").val());
				reloadList();
			}
			return false;
		}
	});
	
	$('.tabs').on("change", function() {
		if($('input[name="tabFlag"]:checked').val() == "3") {
			$('.views_order').hide();
		} else {
			$('.views_order').show();
		}
	});
	
	$(".pic_contents, .draw_contents, .video_contents").on("click", ".box_img", function() {
		$("#pNo").val($(this).attr("pno"));
		$("#postNo").val($(this).attr("pno"));
		$("#searchTxt").val($("#searchOldTxt").val());
		$("#actionForm").attr("target", "");
		$("#actionForm").attr("action", "detail");
		$("#actionForm").submit();
	});
	
	$(".writer_contents").on("click", ".writer_div", function() {
		$("#authorNo").val($(this).children().attr("name"));
		$("#userNo2").val($(this).children().attr("name"));
		$("#userNo3").val($('#userNo').val());
		$("#userNickname").val($(this).children().attr("nick"));
		$("#userProfileImg").val($(this).children().attr("img"));
		$("#userIntroduce").val($(this).children().attr("introduce"));		
		if($(this).children().attr("name") != "${sUserNo}") {
			$("#actionForm").attr("target", "_blank");
			$("#actionForm").attr("action", "othergallary");
			$("#actionForm").submit();
		} else {
			$("#actionForm").attr("target", "_blank");
			$("#actionForm").attr("action", "mygallary");
			$("#actionForm").submit();
			/* location.href = "mygallary"; */
		}

	});

	
	$(".srh_flag").on("click", "li", function(){
		
		if($(this).attr("class") == "accuracy"){
			$("#orderFlag").val("0");
			$(this).attr("id", "active");
			$(".views_order").attr("id", "");
			$(".recency").attr("id", "");
		} else if($(this).attr("class") == "views_order"){
			$("#orderFlag").val("1");
			$(this).attr("id", "active");
			$(".accuracy").attr("id", "");
			$(".recency").attr("id", "");
		} else {
			$("#orderFlag").val("2");
			$(this).attr("id", "active");
			$(".accuracy").attr("id", "");
			$(".views_order").attr("id", "");
		}
		if($("#searchTxt").val() != "") {
			reloadList();
		}
		
	});

	
	//페이지 클릭시
	$(".paging_area").on("click", "a",  function() {
		$("#page").val($(this).attr("page"));
		$('html').scrollTop(0);
		reloadList();
	});
	
	
 	$(".tabs").on("change", "[type='radio']", function() {
		$("#page").val("1");
		$("#orderFlag").val("0");
		if($("#searchTxt").val() != "") {
			reloadList();
		}
		
		/* $("#tabFlag").val($(".tabs [type='radio']:checked").val()); */
	});
	
	
	
});	

	
	
	
	
	
	
	
	//---------------------------------------------------------탭 클릭시
	function reloadList() {
		var params= $("#actionForm").serialize();
		var urlTxt = "";
		
		console.log("==>" + $(".tabs [type='radio']:checked").val());
		switch($(".tabs [type='radio']:checked").val()) {
		case "0" :
			urlTxt = "picSearch";
			break;
		case "1" :
			urlTxt = "drawSearch";
			break;
		case "2" :
			urlTxt = "videoSearch";
			break;
		case "3" :
			urlTxt = "writerSearch";
			break;
		}

		$.ajax({
			url: urlTxt, 
			type: "post", 
			dataType: "json", 
			data: params, 
			success: function(res) {
				console.log("===>" + $(".tabs [type='radio']:checked").val());
					switch($(".tabs [type='radio']:checked").val()) {
					case "0" :
						picSearch(res.list, res.cnt);
						break;
					case "1" :
						drawSearch(res.list, res.cnt);
						break;
					case "2" :
						videoSearch(res.list, res.cnt);
						break;
					case "3" :
						writerSearch(res.list, res.cnt);
						break;
					 }
					drawPaging(res.pb);	
					
			},
			error: function(request, status, error) { // 실패 시 다음 함수 실행
				console.log(error);
			}
		});
	}

	
	function picSearch(list, cnt) {
		var html = "";
		var cntObj = "";
		
		if(list.length == 0 && $("#page").val() == 1) {
			
			cntObj += cnt;
			$(".spanCnt").html(cntObj);
			
			html +="<div class=\"search_result\">";
			html +="	<div class=\"search_nothing\">";
			html +="		<b>검색어</b>에 대한 검색결과가 없습니다.<br/>";
			html +="		다시 검색해 보세요.";
			html +="	</div>";
			html +="</div>";
			
			$(".pic_contents").html(html);
			
		}  else {
			cntObj += cnt;
			$(".spanCnt").html(cntObj);
			for(var p of list) {
				                                                                    
			html +=" <div class=\"gallary_div\">";
			html += "	<div pno = \"" + p.POST_NO + "\"class = \"box_img\" id=\"pic" + p.POST_NO + "\"></div>";
			html +=" 		<div class=\"box_img_txt\">";
			html +=" 			<div class=\"box_img_txt_title\">" + p.TITLE + "</div>";
			html +=" 			<div class=\"box_img_txt_writer_div\">";
			html +=" 				<span class=\"writer_flag\">by </span>";
			html +=" 				<span class=\"box_img_txt_writer\"> " + p.USER_NICKNAME + "</span>";
			html +=" 			</div>";
			html +=" 	</div>";
			html +=" </div>";
		
			}
			
			$(".pic_contents").html(html);
			
			for(var p of list) {
				
				if(p.POST_FILE != null && p.POST_FILE != "") {
					$('#pic' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
				} else {
					$('#pic' + p.POST_NO).css('background-image', 'url(\'resources/images/JY/짱구1.jpg\')');
				}
			}

		}

	}
	
	function drawSearch(list, cnt) {
		var html = "";
		var cntObj = "";
		
		if(list.length == 0 && $("#page").val() == 1) {
			
			cntObj += cnt;
			$(".spanCnt").html(cntObj);
			
			html +="<div class=\"search_result\">";
			html +="	<div class=\"search_nothing\">";
			html +="		<b>검색어</b>에 대한 검색결과가 없습니다.<br/>";
			html +="		다시 검색해 보세요.";
			html +="	</div>";
			html +="</div>";
			
			$(".draw_contents").html(html);
			
		}  else {
			
			cntObj += cnt;
			$(".spanCnt").html(cntObj);
			
			for(var p of list) {
				                                                                    
			html +=" <div class=\"gallary_div\">";
			html += "	<div pno = \"" + p.POST_NO + "\"class = \"box_img\" id=\"draw" + p.POST_NO + "\"></div>";
			html +=" 		<div class=\"box_img_txt\">";
			html +=" 			<div class=\"box_img_txt_title\">" + p.TITLE + "</div>";
			html +=" 			<div class=\"box_img_txt_writer_div\">";
			html +=" 				<span class=\"writer_flag\">by </span>";
			html +=" 				<span class=\"box_img_txt_writer\"> " + p.USER_NICKNAME + "</span>";
			html +=" 			</div>";
			html +=" 	</div>";
			html +=" </div>";
		
			}
			
			$(".draw_contents").html(html);
			
			for(var p of list) {
				
				if(p.POST_FILE != null && p.POST_FILE != "") {
					$('#draw' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
				} else {
					$('#draw' + p.POST_NO).css('background-image', 'url(\'resources/images/JY/짱구1.jpg\')');
				}
			}

		}
	}
	
	
	function videoSearch(list, cnt) {
		var html = "";
		var cntObj = "";
		
		if(list.length == 0 && $("#page").val() == 1) {
			
			cntObj += cnt;
			$(".spanCnt").html(cntObj);
			
			html +="<div class=\"search_result\">";
			html +="	<div class=\"search_nothing\">";
			html +="		<b>검색어</b>에 대한 검색결과가 없습니다.<br/>";
			html +="		다시 검색해 보세요.";
			html +="	</div>";
			html +="</div>";
			
			$(".video_contents").html(html);
			
		}  else {
			
			cntObj += cnt;
			$(".spanCnt").html(cntObj);
			
			for(var p of list) {
				                                                                    
			html +=" <div class=\"gallary_div\">";
			html += "	<div pno = \"" + p.POST_NO + "\"class = \"box_img\" id=\"video" + p.POST_NO + "\"></div>";
			html +=" 		<div class=\"box_img_txt\">";
			html +=" 			<div class=\"box_img_txt_title\">" + p.TITLE + "</div>";
			html +=" 			<div class=\"box_img_txt_writer_div\">";
			html +=" 				<span class=\"writer_flag\">by </span>";
			html +=" 				<span class=\"box_img_txt_writer\"> " + p.USER_NICKNAME + "</span>";
			html +=" 			</div>";
			html +=" 	</div>";
			html +=" </div>";
		
			}
			
			$(".video_contents").html(html);
			
			for(var p of list) {
				
				if(p.POST_FILE != null && p.POST_FILE != "") {
					$('#video' + p.POST_NO).css('background-image', 'url(\'resources/upload/' + p.POST_FILE + '\')');
				} else {
					$('#video' + p.POST_NO).css('background-image', 'url(\'resources/images/JY/짱구1.jpg\')');
				}
			}

		}

	}


	function writerSearch(list, cnt) {
		var html = "";
		var cntObj = "";
		
		if(list.length == 0 && $("#page").val() == 1) {
			
			cntObj += cnt;
			$(".spanCnt").html(cntObj);
			
			html +="<div class=\"search_result\">";
			html +="	<div class=\"search_nothing\">";
			html +="		<b>검색어</b>에 대한 검색결과가 없습니다.<br/>";
			html +="		다시 검색해 보세요.";
			html +="	</div>";
			html +="</div>";
			
			$(".writer_contents").html(html);
			
		}  else {
			
			cntObj += cnt;
			$(".spanCnt").html(cntObj);
		
			for(var p of list) {
				                  
				
			html +=" <div class=\"writer_div\">";
			/* html += "	<div name = \"" + p.USER_NO + "\"class = \"writer_img\" id=\"writer" + p.USER_NO + "\"></div>"; */
			html += "	<div name = \"" + p.USER_NO + "\"class = \"writer_img\" id=\"writer" + p.USER_NO + "\" img=\"" + p.PROFILE_IMG_PATH + "\" nick=\"" + p.USER_NICKNAME + "\" introduce=\"" + p.INTRODUCE + "\" class=\"follower\"></div>";
			html +=" 	<div class=\"writer_box_txt\">";
			html +=" 		<div class=\"writer_name\"><h5>" + p.USER_NICKNAME + "</h5></div>";
			html +=" 		<div class=\"writer_introduce\">";
			html +=" 			<span> " + p.INTRODUCE + "</span>";
			html +=" 		</div>";
			html +=" 	</div>";
			html +=" </div>";
		
			}
			
			
			$(".writer_contents").html(html);
			
			for(var p of list) {
				
				if(p.PROFILE_IMG_PATH != null && p.PROFILE_IMG_PATH != "") {
					$('#writer' + p.USER_NO).css('background-image', 'url(\'resources/upload/' + p.PROFILE_IMG_PATH + '\')');
				} else {
					$('#writer' + p.USER_NO).css('background-image', 'url(\'resources/images/JY/who.png\')');
				}
			}
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
		
		$(".paging_area").html(html);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


</script>
</head>
<body>

	<c:choose>
		<c:when test="${empty sUserNo}">
			<c:import url="../JY/header2.jsp"></c:import>
		</c:when>
		<c:otherwise>
			<c:import url="../JY/header.jsp">
				<c:param name="url" value="mygallary"></c:param>
			</c:import>
		</c:otherwise>
	</c:choose>
<form action="#" id="actionForm" name="go" method="post" target="">
	<div class="input_txt_wrap">
		<div id="srhTxt">
			<input type="hidden" id="visibility" name="visibility" value="0"/>
			<input type="text" id="searchTxt" name="searchTxt" placeholder="검색어를 입력해주세요." value="${param.searchTxt}"/>
			<input type="hidden" id="searchOldTxt" value="${param.searchTxt}"/>
			<input type="hidden" id="orderFlag" name="orderFlag" value="0">
			<input type="hidden" id="userNo" name="userNo" value="${sUserNo}" />
			<input type="hidden" id="pNo" name="pNo" />
			<input type="hidden" id="authorNo" name="authorNo" value="">
			<input type="hidden" id="userNo3" name="userNo" value="">
			<input type="hidden" id="userNo2" name="userNo2" value="">
			<input type="hidden" id="userNickname" name="userNickname" value="">"
			<input type="hidden" id="userProfileImg" name="userProfileImg" value="">
			<input type="hidden" id="userIntroduce" name="userIntroduce" value="">
			<input type="hidden" id="postNo" name="postNo" />
			<input type="hidden" id="page" name="page" value="${page}" />
			<input type="hidden" id="mainGallary" name="listPage" value="3"/>
		</div>
		<div class="srh_cnt_div">
			<div class="srh_cnt_box">	
			<span class="srh_cnt">작품 검색 결과 <span class="spanCnt"></span>건</span>";				
				<div class="srh_flag_div">
					<ul class="srh_flag">
						<li class="accuracy" id="active">좋아요수</li>
						<li class="views_order">조회수</li>
						<li class="recency">최신</li>
					</ul>
				</div>
			</div>
		</div>	
	</div>
	<div class="main">
		<div class="ctts">
			<div class="search_tab_wrap">
				<div class="tabs">
					<input id="tabP" type="radio" value="0" name="tabFlag" checked="checked" />
					<input id="tabD" type="radio" value="1" name="tabFlag" />
					<input id="tabV" type="radio" value="2" name="tabFlag" />
					<input id="tabW" type="radio" value="3" name="tabFlag" />		
					<label for="tabP">사진</label>
					<label for="tabD">그림</label>
					<label for="tabV">영상</label>
					<label for="tabW">작가</label>
					<div class="pic_contents"></div>
					<div class="draw_contents"></div>
					<div class="video_contents"></div>
					<!-------------------------------------------------------------작가검색시  -->
					<div class="writer_contents"></div>
					<!------------------------------------------------------------------------ 페이징 -->
					<div class="paging_area"></div>
				</div>
			</div>
		</div>
	</div>
</form>
	<c:import url="../JY/footer.jsp"></c:import>
</body>
</html>