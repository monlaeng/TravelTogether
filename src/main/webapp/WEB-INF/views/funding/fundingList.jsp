<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/fundingList.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
$.ajax({
	url:"fundingListItem.do",
	type:"get",
	data: "selectOption=selectAllByDate",
	success:function(data) {
		$(".items").html(data);
	}
});  

$(function(){
    $(".dropbtn_click").onclick = ()=>{
      dropdown();
    }
    document.getElementsByClassName('filter').onclick = ()=>{
      showMenu(value);
    };
    dropdown = () => {
      var v = document.querySelector('.dropdown-content');
      var dropbtn = document.querySelector('.dropbtn')
      v.classList.toggle('show');
    }

    showMenu=(value)=>{
      $(".dropbtn_content").text(value);
      var selectOption = "";
      if(value=="최신순") {
    	  selectOption = "selectAllByDate"
      }
      else if(value=="높은금액순") {
    	  selectOption = "selectAllByPriceDesc"
      }
      else if(value=="낮은금액순") {
    	  selectOption = "selectAllByPriceAsc"
      }
      else if(value=="조회순") {
    	  selectOption = "selectAllByViews"
      }
      $.ajax({
    		url:"fundingListItem.do",
    		type:"get",
    		data: "selectOption="+selectOption,
    	  success:function(responseData) {
    		  $(".items").html(responseData); 
    	  }
      })
    }
  })
  window.onclick= (e)=>{
    if(!e.target.matches('.dropbtn_click')){
      var dropdowns = document.getElementsByClassName("dropdown-content");

      var dropbtn_icon = document.querySelector('.dropbtn_icon');
      var dropbtn_content = document.querySelector('.dropbtn_content');
      var dropbtn_click = document.querySelector('.dropbtn_click');
      var dropbtn = document.querySelector('.dropbtn');

      var i;
      for (i = 0; i < dropdowns.length; i++) {
        var openDropdown = dropdowns[i];
        if (openDropdown.classList.contains('show')) {
          openDropdown.classList.remove('show');
        }
      }
    }
  }
</script>
</head>
<body>
	<div class="content_wrapper">
		<h1 class="pageTitle">Funding List</h1>
		<button class="goBtn" onclick="location.href='fundingInput.do'">펀딩 만들기</button>
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
</body>
</html>