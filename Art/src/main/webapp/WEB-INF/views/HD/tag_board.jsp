<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>태그 관리자</title>
    <link rel="stylesheet" href="resources/css/HD/tag_board.css">
    <link rel="stylesheet" href="resources/css/HD/managerSide.css"/>
	<script type="text/javascript"
			src="resources/script/jquery/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
	var arr = new Array();
		$(document).ready( function () {
		//----------------------------------------------사이드 바 변경
			var now ='${now}';
			console.log(now);
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
			//--------------------------------------------검색 기능
			$("#searchBtn").on("click", function () {
				$("#searchForm").submit();			
			});
			
			
			//-------------------------------------------- 등록하기 
			$("#startAdd").on("click", function () {
				if($(".main3 #startAdd").val() =="등록하기"){
					$(".main3 [type =text]").css({"display":"inline-block"});
					$(".main3 #startAdd").val("등록");
				}else{
					$(".main3 [type =text]").css({"display":"none"});
					$(".main3 #startAdd").val("등록하기");
					
					$("#addTag").val($("#addContent").val());
					if($("#addTag").val() != null && $("#addTag").val() !=''){
						$("#updateTagForm").submit();
					}
				}
			
			});
			//------------------------------------------- 각 요소 선택시 색 변경 및 번호 저장
			
			$(".main3-table .td").on("click", function () {
				
				if($(this).attr("class") != "active"){// 백그라운드가 배경색이면 저걸로 바꿔
					$(this).attr("class","active");
					arr.push($(this).attr("id"));
					console.log(arr);
				}else{
					$(this).attr("class","td");
						for(var i =0; i < arr.length; i++){
							if($(this).attr("id") == arr[i]){
							arr.splice(i,1);
							console.log("this is" + arr);
							}
						}
				}
				
				$("#tagNo").val(arr);
				console.log($("#tagNo").val());
				
			});
			
			
			
			//------------------------------------------ 삭제하기
			$("#deleteBtn").on("click", function () {
				$("#updateTagForm").attr("action","delTag");
				$("#updateTagForm").submit();
			});
			
			
			$("#forbiddenBtn").on("click", function () {
				if($("#del").val() !="1"){
					$("#del").val("1");
					$("#forbiddenBtn").val("금지태그");
				}else{
					$("#del").val("0");
					$("#forbiddenBtn").val("태그");
				}
			});
		
		});
		//document ready done
		
		
	</script>
</head>
<body>
	<form action="addTag" method="post" id="updateTagForm">
		<input type="hidden" name="tagNo" id="tagNo">
		<input type="hidden" name="addTag" id="addTag">
	</form>
    <div class="wrapper">
    <div class="content">
       <c:import url="managerSide.jsp"></c:import>
        <div class ="main">
            
            <div class ="blank2"></div>
            
            <div class ="bigClass">
                <div class ="bigClass-1">태그</div>
                <!-- <div class ="bigClass-2">금지어</div> -->
            </div>
            <div class="main1">
                <div class="main1-1">
                    <span><span class="font-red">검색어를 입력</span>하여 검색할 수 있습니다.</span><br/>
                    <span><span class="font-red">수정버튼</span>을 클릭하시면 수정할 수 있습니다.</span><br/>
                    <span><span class="font-red">데이터가 많은 경우</span> 느려질 수 있습니다.</span>
                </div>
            </div>
            <form action="tag_board" id="searchForm" method="post">
	            <div class ="main2">
	                <div class="main2-1">
	                    <label>검색</label>
	                     <input type="text" placeholder="태그를 입력해주세요."  id="searchTxt" name="searchTxt" value="${param.searchTxt }">
	                    <div class="date_search">
	                        <label>날짜분류</label>
	                            <input type="date" name="startDate">
	                            <span> ~ </span>
	                            <input type="date" name="endDate">
	                        </div>
	                     <input type="button" id="searchBtn" value="검색">
	                    </div>
	                    <div class="main3">
	                    	#<input type="text" id="addContent">
	                        <input type="button" id="startAdd" value="등록하기"/>
	                        <input type="button" value="삭제" id="deleteBtn"/>
	                    </div>
	            </div>
            </form>
            <div class="main3-table">
             	<c:forEach var="data" items="${tList}">
             		<c:if test="${empty data.TAG_NAME} and ${data.TAG_NAME }">
             			<div class="td" id="${data.TAG_NO}">없음</div>
             		</c:if>
             		<div class="td" id="${data.TAG_NO}">#${data.TAG_NAME}</div>
             	</c:forEach>
            </div>
            <div class ="status"> 전체 : ${cnt} 개</div>
        </div>
    
    </div>
</div><!-- wrapper end  -->
</body>
</html>