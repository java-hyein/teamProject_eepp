<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>직무별 Community</title>
		<%@ include file="/WEB-INF/include/forImport.jspf"%>
	<style type="text/css">
.userBtn{color: #3e3e3e;
    font-weight: bold;}
    .dropdown-menu{
    height: 80px;
    padding: 10px!important;}
    .dropdown-menu li{margin:5px 0;}
    .dropdown-menu li a{cursor: pointer;color:#59bfbf!important;font-size:14px;}
		</style>
	</head>
	
	<body>
<script type="text/javascript">
function sendMessage(uNickname, receiver_id){
	 var tw = window.open("http://localhost:8282/eepp/message/sendMessage?receiver="+uNickname+"&receiver_id="+receiver_id+"&from=out", "sendmessage","left="+(screen.availWidth-370)/2
			 +",top="+(screen.availHeight-425)/2+",width=370,height=425");
}
</script>
	<input type="hidden" id="userNickname" name="loginUser" value="${loginUser.uNickname}">
	<input type="hidden" id="pageMakerTotalCount" value="${pageMaker.totalCount}">
	<input type="hidden" id="pageMakerCriPage" value="${pageMaker.cri.page}">
	<input type="hidden" id="pageMakeQuery" value="${pageMaker.makeQuery(1)}">
	
		<h1 class="boardTitle"></h1>
		<button type="button" onclick="location.href='/eepp/scrap/myScrapList'">스크랩 확인</button>
		<button type="button" onclick="location.href='/eepp/class/classList'">CLASS</button>
		<hr>
		
		<!-- 직무 게시판 카테고리 -->
		<div>
			<h3>직무 별 카테고리</h3>
			<a class="category" href="boardList">All</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=notice">공지사항</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=it_dev">IT & 개발</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=service">서비스</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=finance">금융</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=design">디자인</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=official">공무원</a>&nbsp;&nbsp;&nbsp;
			<a class="category" href="boardList?&bCategory=etc">etc</a>
		</div>
		<hr>
				
		<!-- 게시판 정렬방법 -->
		<div>
			<h3>게시글 정렬방법</h3>
			<a href="boardList?page=${pageMaker.startPage}&perPageNum=${pageMaker.cri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=bWrittenDate&bCategory=${bCategory}">최신순</a>&nbsp;&nbsp;&nbsp;
			<a href="boardList?page=${pageMaker.startPage}&perPageNum=${pageMaker.cri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=bHit&bCategory=${bCategory}">조회순</a>&nbsp;&nbsp;&nbsp;
			<a href="boardList?page=${pageMaker.startPage}&perPageNum=${pageMaker.cri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=bLike&bCategory=${bCategory}">추천순</a>&nbsp;&nbsp;&nbsp;
			<a href="boardList?page=${pageMaker.startPage}&perPageNum=${pageMaker.cri.perPageNum}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=rpCount&bCategory=${bCategory}">댓글순</a>
		</div>
		<hr>
		
		<!-- 게시글 n개씩 보기 -->
		<div>
			<select id="cntPerPage" name="perPageNum">
				<option value="5"  <c:out value="${pageMaker.cri.perPageNum eq '5' ? 'selected' : ''}"/>>5줄 보기</option>
				<option value="10" <c:out value="${pageMaker.cri.perPageNum eq '10' ? 'selected' : ''}"/>>10줄 보기</option>
				<option value="15" <c:out value="${pageMaker.cri.perPageNum eq '15' ? 'selected' : ''}"/>>15줄 보기</option>
				<option value="20" <c:out value="${pageMaker.cri.perPageNum eq '20' ? 'selected' : ''}"/>>20줄 보기</option>
				<option value="30" <c:out value="${pageMaker.cri.perPageNum eq '30' ? 'selected' : ''}"/>>30줄 보기</option>
				<option value="40" <c:out value="${pageMaker.cri.perPageNum eq '40' ? 'selected' : ''}"/>>40줄 보기</option>
				<option value="50" <c:out value="${pageMaker.cri.perPageNum eq '50' ? 'selected' : ''}"/>>50줄 보기</option>
			</select>&nbsp;&nbsp;&nbsp;
			
			<!-- 새글작성 -->
			<button type="button" class="writeBtn">새 글 쓰기</button>
		
			<form name="form1" role="form" method="post">
				<input type="hidden" name="page" value="${scri.page}" />
				<input type="hidden" name="perPageNum" value="${scri.perPageNum}" />
				<input type="hidden" name="searchType" id="scriSearchType" value="${scri.searchType}" />
				<input type="hidden" name="keyword" id="scriKeyword" value="${scri.keyword}" />
				<input type="hidden" name="sortType" id="sortType" value="${sortType}" />
				<input type="hidden" name="bCategory" id="bCategory" value="${bCategory}" />
			</form>
		</div>
		<hr>
		
		<!-- 게시물 리스트 -->
		<div>
			<table border="1">
				<tr>
					<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					<td>글번호</td>
					<td>카테고리</td>	
					<td>말머리</td>
					<td>글제목</td>
					<td>작성자</td>
					<td>조회수</td>
					<td>추천 // 비추천</td>
				</tr>
				
				<!-- 공지사항 상위노출 2개 -->
				<c:forEach items="${notice}" var="notice">
					<tr>
						<td><img src="${pageContext.request.contextPath}/resources/img/boardIcon/notice3.png" width="50" height="50"></td>
						<td>${notice.bId}</td>
						<td>${notice.bCategory}</td>
						<td>${notice.bSubject}</td>
						<td>
							<a style="text-decoration: none" href="contentView${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${notice.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}">${notice.bTitle}  [${notice.rpCount}]</a>
						</td>
						<td>
						<div class="dropdown">
						<a href="#" class="userBtn" id="user_${notice.uNickname}${btn.index}" data-toggle="dropdown">${notice.uNickname}</a>
           				 <ul class="dropdown-menu" role="menu" aria-labelledby="user_${notice.uNickname}${btn.index}">
                			<li><a href="#">회원정보</a></li>
                			<li><a onclick="sendMessage('${notice.uNickname}',${notice.user_id});">쪽지 보내기</a></li>
                			</ul>
						</div>
							${notice.bWrittenDate}
						</td>
						<td>${notice.bHit}</td>
						<td>${notice.bLike} // ${notice.bUnlike}</td>
					</tr>
				</c:forEach>
				
				<!-- 인기글 상위노출 3개 -->
				<c:forEach items="${hotArticle}" var="hot">
					<tr>
						<td><img src="${pageContext.request.contextPath}/resources/img/boardIcon/hot3.png" width="50" height="50"></td>
						<td>${hot.bId}</td>
						<td>${hot.bCategory}</td>
						<td>${hot.bSubject}</td>
						<td>
							<a style="text-decoration: none" href="contentView${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${hot.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}">${hot.bTitle}  [${hot.rpCount}]</a>
						</td>
						<td>
						<div class="dropdown">
						<a href="#" class="userBtn" id="user_${hot.uNickname}${btn.index}" data-toggle="dropdown">${hot.uNickname}</a>
           				 <ul class="dropdown-menu" role="menu" aria-labelledby="user_${hot.uNickname}${btn.index}">
                			<li><a href="#">회원정보</a></li>
                			<li><a onclick="sendMessage('${hot.uNickname}',${hot.user_id});">쪽지 보내기</a></li>
                			</ul>
						</div>
							${hot.bWrittenDate}
						</td>
						<td>${hot.bHit}</td>
						<td>${hot.bLike} // ${hot.bUnlike}</td>
					</tr>
				</c:forEach>
				
				<tr>
					<td colspan="9">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
				</tr>
				
				<c:choose>
					<c:when test="${fn:length(boardList) > 0 }">
						<c:forEach items="${boardList}" var="vo">
							<tr>
								<td>
									<c:choose>
										<c:when test="${vo.dCount > 10}">
											<b style="color: red">[BLIND]</b>
										</c:when>
										<c:otherwise>
											&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										</c:otherwise>
									</c:choose>
								</td>
								<td>${vo.bId}</td>
								<td>${vo.bCategory}</td>
								<td>${vo.bSubject}</td>
								<td>
									<c:choose>
										<c:when test="${vo.dCount > 10}">
											${vo.bTitle}
										</c:when>
										<c:otherwise>
											<a style="text-decoration: none" href="contentView${pageMaker.makeQuery(pageMaker.cri.page)}&bId=${vo.bId}&searchType=${scri.searchType}&keyword=${scri.keyword}&sortType=${sortType}&bCategory=${bCategory}">
											${vo.bTitle}  [${vo.rpCount}]</a>
										</c:otherwise>
									</c:choose>
								</td>
								<td>
								<div class="dropdown">
						<a href="#" class="userBtn" id="user_${vo.uNickname}${btn.index}" data-toggle="dropdown">${vo.uNickname}</a>
           				 <ul class="dropdown-menu" role="menu" aria-labelledby="user_${vo.uNickname}${btn.index}">
                			<li><a href="#">회원정보</a></li>
                			<li><a onclick="sendMessage('${vo.uNickname}',${vo.user_id});">쪽지 보내기</a></li>
                			</ul>
						</div>
									${vo.bWrittenDate}
								</td>
								<td>${vo.bHit}</td>
								<td>${vo.bLike}  //  ${vo.bUnlike}</td>
							</tr>
						</c:forEach>
					</c:when>
				
					<c:otherwise>
						<tr>
							<td colspan="9">조회된 결과가 없습니다.</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
		<hr>
		
		<!-- 검색 부분  -->
		<div class="search">
			<select name="searchType">
				<option value="n" <c:out value="${scri.searchType == null ? 'selected' : ''}"/>>검색조건</option>
				<option value="w" <c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
				<option value="t" <c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
				<option value="c" <c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
				<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
			</select> 
			
			<input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" />
			<button id="searchBtn" type="button">검색</button>
		</div>
		<!-- 검색 부분 끝  -->
		<hr>
		
		<!-- 페이징 -->
		<div>
			<c:if test="${pageMaker.prev}">
				<a style="text-decoration: none" href="boardList${pageMaker.makeSearch(pageMaker.startPage - 1)}&sortType=${sortType}&bCategory=${bCategory}"> « </a>
			</c:if>
			
			[<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<a style="text-decoration: none" href="boardList${pageMaker.makeSearch(idx)}&sortType=${sortType}&bCategory=${bCategory}">${idx}</a>
			</c:forEach>]
	
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
				<a style="text-decoration: none" href="boardList${pageMaker.makeSearch(pageMaker.endPage + 1)}&sortType=${sortType}&bCategory=${bCategory}"> » </a>&nbsp;&nbsp;
			</c:if>
		</div>

		<script src="${pageContext.request.contextPath}/js/board/boardMain.js"></script>
	</body>
</html>