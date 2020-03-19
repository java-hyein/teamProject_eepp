<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community EE</title>
<%@ include file="/WEB-INF/include/forImport.jspf"%>
<script type="text/javascript">
function openMsg(){
	 var tw = window.open("http://localhost:8282/eepp/message?messageType=myReceiveMsg","message","left="+(screen.availWidth-700)/2
			 +",top="+(screen.availHeight-440)/2+",width=700,height=440");
	}
	
$(function(){  
	var currentPosition = parseInt($(".float").css("top")); 
	$(window).scroll(function() { 
		var position = $(window).scrollTop(); // 현재 스크롤바의 위치값을 반환
		$(".float").stop().animate({"top":position+currentPosition+"px"},500); 
	});
});
</script>
</head>

<body>
<!-- header -->
<%@ include file="/WEB-INF/views/header.jsp"%>
<!-- header -->

<input type="hidden" id="user_id" value="${loginUser.user_id}" />
<input type="hidden" id="uNickname" value="${loginUser.uNickname}" />

<!-- chat -->
<%@ include file="/WEB-INF/views/chat/chatRoomList.jsp"%>
<!-- chat -->

<!-- footer -->
<%@ include file="/WEB-INF/views/footer.jsp"%>
<!-- footer -->
</body>
</html>