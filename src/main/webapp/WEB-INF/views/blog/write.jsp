<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>

<script src="${initParam.root}resources/ckeditor/ckeditor.js"></script>

<script src="${initParam.root}resources/tagsinput/bootstrap-tagsinput.min.js"></script>
<link href="${initParam.root}resources/tagsinput/bootstrap-tagsinput.css" rel="stylesheet">
<script type="text/javascript">
	$(function(){
		$('#tagString').tagsinput({
		  confirmKeys: [13, 32, 44]
		});
		
	});
</script>

<form:form action="${initParam.root}post" method="post" commandName="post">
	
	<label>카테고리</label>
	<form:select name="categoryId" path="categoryId" class="form-control">
		<option>------카테고리를 선택하세요------</option>
		<c:forEach var="category" items="${categories}">
		<option value="${category.categoryId}">${category.name}</option>
		</c:forEach>
	</form:select>
	<font color="red"><form:errors path="categoryId"></form:errors></font><br>
	
	<label>제목</label>
	<form:input type="text" name="title" path="title" class="form-control" placeholder="제목을 입력하세요"/>
	<font color="red"><form:errors path="title"></form:errors></font><br>
	
	<label>#태그</label><br>
	<input type="text" name="tagString" id="tagString" class="form-control" placeholder="Enter, 콤마(,)로 구분하여 여러개의 태그를 등록하세요)" style="display: none;"><br>
	
    <form:textarea name="content" path="content" id="editor1" rows="10" cols="80"/>
    <font color="red"><form:errors path="content"></form:errors></font><br>
    <label></label>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Post</button>
    <label></label>
    
</form:form>

<script src="${initParam.root}resources/js/application.js"></script>

<script>
    // Replace the <textarea id="editor1"> with a CKEditor
    // instance, using default configuration.
    CKEDITOR.replace( 'editor1',{
    	height:'400px',
    	'filebrowserImageUploadUrl':'/blog/post/imageUpload'
    });
    
    CKEDITOR.on('dialogDefinition', function( ev ){
        var dialogName = ev.data.name;
        var dialogDefinition = ev.data.definition;
      
        switch (dialogName) {
            case 'image': //Image Properties dialog
                //dialogDefinition.removeContents('info');
                dialogDefinition.removeContents('Link');
                dialogDefinition.removeContents('advanced');
                break;
        }
    });
</script>
