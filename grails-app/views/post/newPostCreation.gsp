<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    
    <meta name="layout" content="main">
    <title>
        <g:message code="page.title.post.creation"/>
    </title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="col-sm-offset-2 col-sm-8">
            <div class="page-header">
                <h3>
                    <g:message code="page.header.create.post.for.company" args="[company?.name]"/>
                </h3>
            </div>

            <g:hasErrors bean="${post}">
                <div class="alert alert-danger">
                    <g:eachError><p><g:message error="${it}"/></p></g:eachError>
                </div>
            </g:hasErrors>

            <g:form controller="post" action="createPost">

                <g:hiddenField name="companyId" value="${company?.id}"/>
                <g:checkBox name="anonymous" class="hidden" value="${anonymous}"/>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.comment"/>
                    </label>
                    <g:textArea name="comment" class="form-control" rows="5" cols="20"
                                placeholder="Enter post comment"
                                value="${post?.comment}"/>
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.rating"/>
                    </label>
                    <br />
                    <input type="range" name="rating" min="0" max="5" value="0" step="1.0" id="backing2">
                    <div class="rateit" data-rateit-backingfld="#backing2"></div>
                </div>

                <g:if test="${anonymous}">
                    <h4>
                        <g:message code="user.post.anonymous"/>
                    </h4>
                </g:if>

                <button type="submit" class="btn btn-default pull-right">
                    <g:message code="button.label.create"/>
                </button>
            </g:form>

        </div>
    </div>
</div>

</body>
</html>