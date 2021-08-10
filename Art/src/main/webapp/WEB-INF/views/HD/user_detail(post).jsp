<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div class= "background"></div>
<div class ="Pmain">
	<div class ="topBar">
		<div class ="blank"></div>
	</div>
	<div class = "profile">
		<div class ="pBox">
			<img class ="img" alt="프로필사진" src="resources/images/HD/profile.png">
			<div class ="cButtonB"></div>
			<div class ="cButtonc">
				<img class ="cButtonI" alt="취소버튼" src="resources/images/HD/cancel.png">
			</div>
		</div>
		<input class ="pName" type ="text" placeholder="nickname" readonly="readonly">
	</div>
	
	<div class ="writeBox" >
		<div class = "blank1">회원상세정보</div>
			<div class = "smallBox">
				<div class ="MsmallBox">
					<div class="informing">이름</div>
					<div class="content_box"></div>
				</div>
				<div class ="MsmallBox">
					<div class="informing">회원번호</div>
					<div class="content_box"></div>
				</div>
				<div class ="MsmallBox">
					<div class="informing">전화번호</div>
					<div class="content_box"></div>
				</div>
				
			</div>
			<div class = "smallBox">
				<div class ="MsmallBox">
					<div class="informing">성별</div>
					<div class="content_box"></div>
				</div>
				<div class ="MsmallBox">
					<div class="informing">생년월일</div>
					<div class="content_box"></div>
				</div>
				<div class ="MsmallBox">
					<div class="informing">이메일</div>
					<div class="content_box"></div>
				</div>
			</div>
			
			<div class="introduce_box">
				<div class="sogea"><b>소개</b></div>
				<div class="sogea_box">
				소개 입력란입니다.
				</div>
			</div>
	</div>
	
	<div class ="middleSection">
		<div class = "brick"></div>
		<input type="button" class ="insideMiddle1" id="insideMiddle1" value="작품">
		<input type="button" class ="insideMiddle2" id="insideMiddle2" value="메모">
		<div class = "underLine"></div>
	</div>
	<div class ="boxForB">
		<div class ="topOfBox">
			<div class ="topBar"></div>
			<div class ="searchBox">
				<select id="searchGbn">
					<option value="0">선택없음</option>
					<option value="1">제목</option>
					<option value="2">태그</option>
				</select>
				<input type="text" placeholder="검색어를 입력하세요" style="font-size:10pt;" class="searchTxt">
				<input type="button" value="검색" class="btnDP" id="searchBtn">
				<div class = "blank2"></div>
				<input type="button" value="수정" class="btnDP" id="updateBtn">
				<input type="button" value="삭제" class="btnDP" id="deleteBtn">
			</div>
		</div>
		<div class ="boxForBoard">
		<table>
		<thead>
			<tr>
				<th>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</th>
				<th> no</th>
				<th> 제목</th>
				<th> 좋아요 개수</th>
				<th> 댓글개수</th>
				<th> 태그</th>
				<th> 신고</th>
				<th> 설명</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
		</tbody>
		</table>
		</div>
	</div>
	<div id="pagingWrap">
		<span name="1">처음</span>
		<!-- 이전 페이지  -->
		<c:choose>
			<c:when test="${page eq 1}">
				<span name="1">이전</span>
			</c:when>
			<c:otherwise>
				<span  name="${page-1 }">이전 </span>
			</c:otherwise>
		</c:choose>
		
		<!-- 페이징   -->
		<c:forEach var="i" begin="${pb.startPcount}" end="${pb.endPcount}" step="1">
			<c:choose>
				<c:when test="${i eq page}">
					<span name="${i}"><b>${i}</b></span>
				</c:when>
				<c:otherwise>
					<span name="${i}">${i}</span>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<!--다음페이지  -->
		<c:choose>
			<c:when test="${page eq pb.maxPcount}">
				<span name="${pb.maxPcount}">다음</span>
			</c:when>
			<c:otherwise>
				<span name="${page+1}">다음</span>
			</c:otherwise>
		</c:choose>
		<span name="${pb.maxPcount}">마지막</span>
	</div>
</div>
</body>
</html> 
<!-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세페이지(작품)</title>
<link rel="stylesheet" href="resources/css/HD/user_detail(byBoard).css">
<script type="text/javascript"
		src="resources/script/jquery/jquery-1.12.4.min.js">
</script>
<script type="text/javascript"
		src="resources/script/HD/user_detailP.js"></script>
</head>
<body>
<div class= "background"></div>
<div class ="Pmain">
	<div class ="topBar">
		<div class ="blank"></div>
	</div>
	<div class = "profile">
		<div class ="pBox">
			<img class ="img" alt="프로필사진" src="resources/images/HD/profile.png">
			<div class ="cButtonB"></div>
			<div class ="cButtonc">
				<img class ="cButtonI" alt="취소버튼" src="resources/images/HD/cancel.png">
			</div>
		</div>
		<input class ="pName" type ="text" placeholder="nickname" readonly="readonly">
	</div>
	
	<div class ="writeBox" >
		<div class = "blank1">회원상세정보</div>
			<div class = "smallBox">
				<div class ="MsmallBox">
					<div class="informing">이름</div>
					<div class="content_box"></div>
				</div>
				<div class ="MsmallBox">
					<div class="informing">회원번호</div>
					<div class="content_box"></div>
				</div>
				<div class ="MsmallBox">
					<div class="informing">전화번호</div>
					<div class="content_box"></div>
				</div>
				
			</div>
			<div class = "smallBox">
				<div class ="MsmallBox">
					<div class="informing">성별</div>
					<div class="content_box"></div>
				</div>
				<div class ="MsmallBox">
					<div class="informing">생년월일</div>
					<div class="content_box"></div>
				</div>
				<div class ="MsmallBox">
					<div class="informing">이메일</div>
					<div class="content_box"></div>
				</div>
			</div>
			
			<div class="introduce_box">
				<div class="sogea"><b>소개</b></div>
				<div class="sogea_box">
				소개 입력란입니다.
				</div>
			</div>
	</div>
	
	<div class ="middleSection">
		<div class = "brick"></div>
		<button class ="insideMiddle1" id="insideMiddle1">작품</button>
		<button class ="insideMiddle2" id="insideMiddle2">메모</button>
		<div class = "underLine"></div>
	</div>
	<div class ="boxForB">
		<div class ="topOfBox">
			<div class ="topBar"></div>
			<div class ="searchBox">
				<select>
					<option>선택없음</option>
					<option>이거</option>
					<option>저거</option>
				</select>
				<input type="text" placeholder="검색어를 입력하세요" style="font-size:10pt;">
				<button>검색</button>
				<div class = "blank2"></div>
				<button>등록</button>
				<button>수정</button>
				<a herf ="http://localhost:8090/TestWeb/HTML/cssproject.html/remove.html"></a><button>삭제</button></a>
			</div>
		</div>
		<div class ="boxForBoard">
		<table>
			<tr>
				<th>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</th>
				<th> no</th>
				<th> 제목</th>
				<th> 좋아요 개수</th>
				<th> 댓글개수</th>
				<th> 태그</th>
				<th> 신고</th>
				<th> 설명</th>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
			<tr>
				<td>
				<input class = "check" type="checkbox" id="ex_chk"> 
				</td>
				<td> no</td>
				<td> 제목</td>
				<td> 좋아요 개수</td>
				<td> 댓글개수</td>
				<td> 태그</td>
				<td> 신고</td>
				<td> 설명</td>
			</tr>
		</table>
		</div>
	</div>
	
</div>
</body>
</html> -->