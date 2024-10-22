<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

	<c:if test="${ resultPage.currentPage > resultPage.pageUnit && resultPage.currentPage%5 != 0}">
			<a href="javascript:fncGet${type}List('${ resultPage.currentPage-resultPage.currentPage%5}')">◀ 이전</a>
	</c:if>
	
	<c:if test="${ resultPage.currentPage > resultPage.pageUnit && resultPage.currentPage%5 == 0}">
			<a href="javascript:fncGet${type}List('${ resultPage.currentPage-5}')">◀ 이전</a>
	</c:if>
	
	<c:forEach var="i"  begin="${resultPage.beginUnitPage}" end="${resultPage.endUnitPage}" step="1">
		<a href="javascript:fncGet${type}List('${ i }');">${ i }</a>
	</c:forEach>
	
	<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
			<a href="javascript:fncGet${type}List('${resultPage.endUnitPage+1}')">이후 ▶</a>
	</c:if>