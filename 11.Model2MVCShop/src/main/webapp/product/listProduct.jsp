<%@ page contentType="text/html; charset=euc-kr" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="type" value="Product" scope="session"/>

<% //System.out.println("\n:: listProduct.jsp"); %>

<c:set var="menu" value="${param.menu}" />
<c:set var="title" value="" />
<c:if test="${param.menu == 'search'}">
	<c:set var="title" value="상품 목록" />
</c:if>
<c:if test="${param.menu == 'manage'}">
	<c:set var="title" value="상품 관리" />
</c:if>


<html>
<head>
<title>상품 목록조회</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">



	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>

<style>
	  body {
            padding-top : 50px;
        }
</style>


<script type="text/javascript">
function fncGetProductList(currentPage){
	//document.getElementById("currentPage").value = currentPage;
	$("#currentPage").val(currentPage)
	//document.detailForm.submit();
	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${menu}").submit();
}

$(function() {
	 //==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	 $( "button.btn.btn-default" ).on("click" , function() {
		fncGetProductList(1);
	});
});

$(function() {
	
	$( "td:nth-child(2)" ).on("click" , function() {
		if("${param.menu}" == 'manage'){
		 self.location ="/product/updateProduct?prodNo="+$(this).data("prodno");
		}
		
		else if("${param.menu}" == 'search'){
			self.location = "/product/getProduct?prodNo="+$(this).data("prodno");
		}
		
	});
				
	$( "td:nth-child(2)" ).css("color" , "red");
	
});	


$(function() {
	 
	$(  ".product-image" ).on("click" , function() {

		var prodNo = $(this).next().val();
		
			$.ajax( 
					{
						url : "/product/json/getProduct/"+prodNo ,
						method : "GET" ,
						dataType : "json" ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						success : function(JSONData , status) {

							var displayValue = "<h6>"
														+"상 품 번 호 : "+JSONData.prodNo+"<br/>"
														+"상  품  명 : "+JSONData.prodName+"<br/>"
														+"상품 상세정보 : "+JSONData.prodDetail+"<br/>"
														+"제 조 일 자 : "+JSONData.manuDate+"<br/>"
														+"가     격 : "+JSONData.price+"<br/>"
														+"등 록 일 자 : "+JSONData.regDate+"<br/>"
														+"</h6>";
						
							$("h6").remove();
							$( "#"+prodNo+"" ).html(displayValue);
						}
				});
			
	});
	
	//==> userId LINK Event End User 에게 보일수 있도록 
	$( ".ct_list_pop td:nth-child(3)" ).css("color" , "red");
	$("h7").css("color" , "red");
	
	//==> 아래와 같이 정의한 이유는 ??
	$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
});	

	
	
</script>
</head>

	<body>

		<jsp:include page="/layout/toolbar.jsp" />

		<div class="container">


			<div class="page-header text-info"><h3>${title}</h3></div>


		
		
		<div class="row">
	    
			<div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
			</div>
		    
		    <div class="col-md-6 text-right">
				<form class="form-inline" name="detailForm">
			    
					<div class="form-group">
				    	<select class="form-control" name="searchCondition" >
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품번호</option>
							<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품명</option>
							<option value="2"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품가격</option>
							
						</select>
				  	</div>
				  
				  	<div class="form-group">
				    	<label class="sr-only" for="searchKeyword">검색어</label>
				    	<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    		value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  	</div>
				  
				  	<button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  	<input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>		
		
		
		
	<table class="table table-hover table-striped" >
      
        <thead>
        	<tr>
        		<th align="center">No</th>
            	<th align="left" >상품명</th>
            	<th align="left">가격</th>
            	<th align="left">등록일</th>
            	<th align="left">현재상태</th>
            	<th align="left">간략정보</th>
			</tr>
        </thead>
        
       
		<tbody>
		
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
		<tr>
			<td align="center">${ i }</td>
			<td align="left" data-prodno="${product.prodNo}">${product.prodName}</td>
			<td align="left">${product.price}</td>
			<td align="left">${product.regDate}</td>	
			<td align="left">판매중</td>	
			<td align="left" data-prod-no="${product.prodNo}" >
			  	<img src= "/images/${product.fileName}" width="100" height="100" class="product-image">
			  	<input type="hidden" value="${product.prodNo}">
			  	<p id="${product.prodNo}"></p>
			  </td>	
		</tr>
	</c:forEach>
        
        </tbody>
      
      </table>	
		

</div>

			<jsp:include page="../common/pageNavigator_new.jsp"/>	

<!--  페이지 Navigator 끝 -->


</div>
</body>
</html>