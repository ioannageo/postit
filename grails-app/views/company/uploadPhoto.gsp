<%--
  Created by IntelliJ IDEA.
  User: vbledar
  Date: 1/10/15
  Time: 16:08
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        <g:message code="page.title.create.company"/>
    </title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <h3>
            <g:message code="page.header.companies.photos"/>
        </h3>
    </div>

    <div class="well well-sm">
            <g:uploadForm controller="photo" action="uploadPhoto" id="${company.id}" name="myUpload">
                <input type="file" class="form-control" name="myFile" />
                <br />
                <div class="btn-group">
                    <button class="btn btn-primary" type="submit">
                        <g:message code="button.label.upload.new"/>
                    </button>
                    <g:link controller="company" action="companiesManagemenet" class="btn btn-danger">
                        <g:message code="button.label.cancel"/>
                    </g:link>
                </div>
            </g:uploadForm>
    </div>

    <g:if test="${!company || !(company?.photos?.size() > 0)}">
        <h5>
            <g:message code="user.no.photo.companies.upload"/>
        </h5>
    </g:if>
    <g:else>
        <g:each in="${company?.photos?.sort {it.dateCreated} }" var="photo">
            <div class="col-xs-6 col-md-3">
                <a href="#" class="thumbnail">
                    <g:img uri="${createLink(controller: 'photo', action: 'renderImageById', id: photo.id)}"/>
                </a>
            </div>
        </g:each>
    </g:else>
</div>
</body>
</html>