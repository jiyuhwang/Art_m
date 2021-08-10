<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리 페이지</title>
<link rel="stylesheet" href="resources/css/HD/gong_board.css"/>
<link rel="stylesheet" href="resources/css/HD/managerSide.css"/>
<script type="text/javascript"
	src="resources/script/jquery/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	$(document).ready(function () {
		//이렇게 바로 넘겨오는 값을 받게되면 스트링으로 변환된 주소 값이 들어가게되서 안에 있는 내용들은 사용하지 못한다.
		 drawList() 
		console.log("document레디 실행됨");
		
		//------------------------------side bar 선택자 
		var now ='${now}';
		console.log('.'+now);
		$('.'+now).attr("id","active");
		
		$(".side").on("click","div", function () {
			if($(this).attr("id") != "active"){
				$('.'+ now).attr("id","");
				if($(this).attr("class") == "member"){
					location.href = "user_board";
					$(".member").attr("id","active");
				}else if($(this).attr("class") == "tag"){
					location.href = "tag_board";
					$(".tag").attr("id","active");
				}else if($(this).attr("class") == "product"){
					location.href = "product_board";
					$(".product").attr("id","active");
				}else if($(this).attr("class") == "warning"){
					location.href = "warning_board";
					$(".warning").attr("id","active");
				}else if($(this).attr("class") == "gong"){
					location.href = "gong_board";
					$(".gong").attr("id","active");
				}
			}
			
		});
		
		//----------------------------------------------체크박스 올 체크
		$("body").on("click","#all_check", function () {
			if($(this).is(":checked")){
				$("input[type=checkbox]").prop("checked",true);
			}else{
				$("input[type=checkbox]").prop("checked",false);
			}
		});
		
		
		//-------------------------------------------------- 페이지 변경 시
		$("body").on("click",".pagingWrap span", function () {
			$("#page").val($(this).attr("name"));
			console.log("이거 페이지 변경 값이 안들어가네"+ $("#page").val());
			drawList();
		});	
		
		//-------------------------------------------------- 검색버튼 클릭시
		$("#searchBtn").on("click", function () {
			$("#searchGbnForm").val($("#searchGbn").val());
			$("#searchTxtForm").val($("#searchTxt").val());
			$("#startDateForm").val($("#startDate").val());
			$("#endDateForm").val($("#endDate").val());
			$("#page").val(1);
			drawList();
		});
		
		$("#resetBtn").on("click", function () {
			console.log("working");
			$("input[name='searchTxt']").val("");
			$("#searchType option:eq(0)").prop("selected",true);
			$("#searchGbn option:eq(0)").prop("selected",true);
			$("#startDate").val("");
			$("#endDate").val("");
			
		});
		
		//-------------------------------------------------- 작성 버튼 클릭시
		$("#addBtn").on("click", function () {
			$("#everyForm").attr("action","addGong");
			$("#everyForm").submit();
			console.log("작동");
			
		});
		
		//-------------------------------------------------- 선택 삭제 버튼
		$("#selectDel").on("click", function () {
			var arr = new Array();
			console.log($(".main3-table [type=checkbox]:checked").val());
			$(".main3-table [type=checkbox]:checked").each(function (index, item) {
				arr.push($(item).val());
			});
			
			$("#noticeNo").val(arr);
			console.log($("#noticeNo").val());
			
			var params = $("#everyForm").serialize();
			console.log("drawList 실행한다.");
			
			$.ajax({
				url:"gongRowsDel",
				type:"post",
				dataType :"json",
				data:params,
				success : function (res) {
					drawList()
				},
				error: function (request, status, error) {
					console.log(error);
				}
			});
		});
		
		//--------------------------------------------------단일 행 삭제
		$("body").on("click","table .deleteBtn", function () {
			console.log("작동은 하니?");
			console.log($(this).parent().parent().attr("name"));
			$("#noticeNo").val($(this).parent().parent().attr("name"));
			
			//I don't know how this option is two parent()?? resaon :  there is td above this input type
			console.log($("#noticeNo").val());
			
			var params = $("#everyForm").serialize();
			console.log("drawList 실행한다.");
			
			$.ajax({
				url:"gongRowsDel",
				type:"post",
				dataType :"json",
				data:params,
				success : function (res) {
					drawList()
				},
				error: function (request, status, error) {
					console.log(error);
				}
			});
			
			
		});
		
		//--------------------------------------------------수정하기
		$("body").on("click",".updateBtn", function () {
			$("#noticeNo").val($(this).parent().parent().attr("name"));
			$("#everyForm").attr("action","editManager");
			$("#everyForm").submit();
		});
		
		
		
		
		//--------------------------------------------------
		//--------------------------------------------------
		//--------------------------------------------------
		
	}); // document end
	
	
	//-------------------------------------------------- ajax처리

	
	function drawList() {
		var params = $("#everyForm").serialize();
		console.log("drawList 실행한다.");
		$.ajax({
			url:"gong_boardA",
			type:"post",
			dataType :"json",
			data:params,
			success : function (res) {
				list(res.list, res.cnt);
				drawPaging(res.pb);
			},
			error: function (request, status, error) {
				console.log(error);
			}
		});
	}
	
	
	function list(list, cnt) {
		var html ="";
		
		                                                                                              
				html+= "		<colgroup>";
				html+= "				<col width=\"2%\"/>";
				html+= "				<col width=\"5%\"/>";
				html+= "				<col width=\"5%\"/>";
				/* html+= "				<col width=\"20%\"/>"; */
				html+= "				<col width=\"8%\"/>";
				html+= "				<col width=\"10%\"/>";
				html+= "				<col width=\"5%\"/>";
				html+= "				<col width=\"5%\"/>";
				html+= "				<col width=\"8%\"/>";
				html+= "			</colgroup>";
				html+= "			<tr>";
				html+= "				<th>";
				html+= "				<input type=\"checkbox\" id=\"all_check\">";
				html+= "				</th>";
				html+= "				<th>공지번호</th>";
				html+= "				<th>제목</th>";
			/* 	html+= "				<th>내용</th>"; */
				html+= "				<th>관리자번호</th>";
				html+= "				<th>첨부파일</th>";
				html+= "				<th>조회수</th>";
				html+= "				<th>등록일</th>";
				html+= "				<th>수정/삭제</th>";
				html+= "			</tr>";
				
				for(var b of list){
					html+= "			<tr name=\"" + b.NOTICE_NO + "\">";
					html+= "				<td>";
					html+= "		            <input type=\"checkbox\" class=\"ex_chk\" value=\"" + b.NOTICE_NO + "\">";
					html+= "		        </td>";
					html+= "				<td>" + b.NOTICE_NO + "</td>";
					html+= "				<td>" + b.TITLE + "</td>";
					/* html+= "				<td>" + b.CONTENTS + "</td>"; */
					html+= "				<td>" + b.ADMIN_NO + "</td>";
					html+= "				<td>" + b.FILE_PATH + "</td>";
					html+= "				<td>" + b.VIEWS + "</td>";
					html+= "				<td>" + b.REGISTER_DATE +"</td>";
					
					if("${sAdminNo}" == b.ADMIN_NO){
					html+= "				<td><input type=\"button\" class=\"updateBtn\" value=\"수정\"/>";
					html+= "		            <input type=\"button\" class=\"deleteBtn\"value=\"삭제/복구\"/></td>";
					}else{
					html+= "				<td>권한없음</td>";
					}
					
					html+= "			</tr>";
				}
						
		$(".main3-table table").html(html);
		
		html="";
		
		html += "전체 "+ cnt +" 개"
		
		$(".status").html(html);
		
		//-------------------------------------------------- 상세보기
		
		$(".main3-table table").on("dblclick","tr", function () {
			$("#noticeNo").val($(this).attr("name"));
			$("#everyForm").attr("action","gong_detail");
			$("#everyForm").submit();
		});
		
		//--------------------------------------------------삭제 버튼 
		/* $("table .deleteBtn").on("click", function () {
			console.log("작동은 하니?");
			console.log($(this).parent().parent().attr("name"));
			$("#noticeNo").val($(this).parent().parent().attr("name"));
			
			//I don't know how this option is two parent()?? resaon :  there is td above this input type
			console.log("drawList 실행한다.");
			drawList()
			
			
		}); */
		
	}
	
	//--------------------------------------------------PAGING처리
	function drawPaging(pb) {
		
		var html="";
		
		html += "<span name=\"1\">처음</span>";
		/* <!-- 이전 페이지  --> */
		if($("#page").val() == "1"){
				html +=		"<span name=\"1\">이전</span>";
		}else{
				html +=	    "<span name=\"" + ($("#page").val()*1 -1) + "\">이전 </span>";
		}
		/* <!-- 페이징   --> */
		for( var i = pb.startPcount ; i <= pb.endPcount; i++){
			if($("#page").val() ==i){
				html +=	"<span name=" + i + " ><b>" + i +  "</b></span>";
			}else{
				html +=	"<span name=" + i + " >" + i +  "</span>";
			}
		}
		/* 다음이랑 마지막 페이지  */
		if($("#page").val() == pb.maxPcount){
				html +=	"<span name=" + pb.maxPcount + ">다음</span>";
		}else{
				html += "<span name=" + ($("#page").val()*1 + 1) + ">다음</span>";
		}
		
	    html +=	"<span name="+ pb.maxPcount+">마지막</span>";
	
	 $(".pagingWrap").html(html);
	 
	 
	}
	
</script>
</head>
<body>
<form action="#" id="everyForm" method="post">
	<input type="hidden" name="page" id="page" value="1">
	<input type="hidden" name="fileName" id="fileName">
	<input type="hidden" name="noticeNo" id="noticeNo">
	<input type="hidden" name="searchGbn" id="searchGbnForm">
	<input type="hidden" name="searchTxt" id="searchTxtForm">
	<input type="hidden" name="startDate" id="startDateForm">
	<input type="hidden" name="endDate" id="endDateForm">
</form>
<div class="content">
	<!-- 사이드 통일  -->
	<c:import url="managerSide.jsp"></c:import>
	<div class ="main">
		
		<div> </div>
		<div class ="blank2"></div>
		
		<div class ="bigClass">
			<div class ="bigClass-1">공지사항</div>
		</div>
		<div class="main1">
			<div class="main1-1">
				<span><span class="font-red">검색어를 입력</span>하여 검색할 수 있습니다.</span><br/>
				<span><span class="font-red">수정버튼</span>을 클릭하시면 수정할 수 있습니다.</span><br/>
				<span><span class="font-red">데이터가 많은 경우</span> 느려질 수 있습니다.</span>
			</div>
		</div>
		<div class ="main2">
			<div class="main2-1">
				<form action="tag_board" id="searchForm" method="post">
					<label>검색분류</label>
					<select name="searchGbn" id="searchGbn">
						<option value="0">공지번호</option>
						<option value="1">제목</option>
						<option value="2">관리자번호</option>
						<option value="3">삭제여부</option>
					</select>
				     <input type="text" name="searchTxt" id="searchTxt" placeholder="검색어를 입력해주세요." value="${param.searchTxt }">
					<div class="date_search">
						<label>날짜분류</label>
							<input type="date" name="startDate" id="startDate" value="${param.startDate }">
							<span> ~ </span>
							<input type="date" name="endDate" id="endDate" value="${param.endDate }">
							<input type="button" value="검색" id="searchBtn">
							<input type="button" value="초기화" id="resetBtn">
					</div>
				</form>
			</div>
			
		</div>
		<div class="main3">
			<input type="button" value="선택 삭제/복구" id="selectDel"/>
			<input type="button" value="작성" id="addBtn"/>
		</div>
		<div class="main3-table">
			<table>
			</table>
		</div>
		<div class ="status"> 전체 : ${cnt}개</div>
	<div class="pagingWrap"></div>
	</div>
	
	
</div>
</body>
</html>