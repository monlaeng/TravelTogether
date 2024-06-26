<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기</title>
<link rel="stylesheet" href="${path}/resources/css/reviewList.css">
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="content_wrapper">
		<h1 class="pageTitle">Funding List</h1>
		<form class="search_wrapper">
			<span class="search_left">
				<span>제&nbsp&nbsp목 : <span class="input-wrapper"><input type="text" name="serarch_title"></span></span><br>
				<span>지&nbsp&nbsp역 : <span class="input-wrapper"><input type="text" name="serarch_area"></span> </span><br>
				<span>출발일 : <span class="input-wrapper"><input type="date" name="search_start"></span> </span><br>
			</span>
			<span class="search_right">
				<span>카테고리 : <span class="input-wrapper"><input type="text" name="serarch_category"></span></span><br>
				<span>&nbsp도착일 &nbsp&nbsp: <span class="input-wrapper"><input type="date" name="search_end"> </span></span>
			</span>
			<input class="search_submit" type="submit" value="검색">
		</form> <br>
	
		 <div class="dropdown">
		    <button class="dropbtn">
		      <span class="dropbtn_content">최신순</span>
		      <image class="dropbtn_click" style="float:right;"
		        onclick="dropdown()"  alt="dropdown" src="${path}/resources/images/dropdown_icon.png">
		    </button>
		    <div class="dropdown-content">
		      <div class="filter" onclick="showMenu(this.innerText)">최신순</div>
		      <div class="filter" onclick="showMenu(this.innerText)" >높은금액순</div>
		      <div class="filter" onclick="showMenu(this.innerText)" >낮은금액순</div>
		      <div class="filter" onclick="showMenu(this.innerText)" >조회순</div>
		    </div>
	  	</div>
		
		<hr class="top_hr">
		<div class="items"></div>
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>