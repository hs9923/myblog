<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<div class="panel panel-default">
  <div class="panel-heading"><h4>#${post.postId}. ${post.title}</h4>
	<a href="${initParam.root}category/${post.categoryId}/page/1"><span class="label label-success">${post.category.name}</span></a> 
	<c:forEach var="tag" items="${post.tags}">
	<span class="label label-info">#${tag.name}</span> 
	</c:forEach>
  </div>
 	<div class="panel-body">
 	<i class="glyphicon glyphicon glyphicon-eye-open"></i> ${post.hits}
    <i class="glyphicon glyphicon glyphicon glyphicon-comment"></i>
    <i class="glyphicon glyphicon glyphicon glyphicon-time"></i> ${post.regDate}
    <button class="btn btn-danger btn-xs pull-right" onclick="remove_post()">삭제</button> 
    <button class="btn btn-warning btn-xs pull-right" onclick="javascript:document.update.submit()">수정</button>
    <form:form name="remove" action="${initParam.root}post/${post.postId}" method="delete"></form:form>
    <form:form name="update" action="${initParam.root}post/update" method="put">
    	<input type="hidden" name="postId" value="${post.postId}">
    </form:form>
 	<hr>
	${post.content}
	</div>
</div>
<script src="${initParam.root}resources/js/application.js"></script>
<script type="text/javascript">
	function remove_post() {
		var flag = confirm('정말 삭제하시겠습니까?');
		if(flag) document.remove.submit();
	}
</script>