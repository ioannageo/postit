<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        <g:message code="page.title.post.anonymous.edit"/>
    </title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="col-sm-offset-2 col-sm-8">
            <div class="page-header">
                <h3>
                    <g:message code="page.header.post.anonymous.edit"/>
                </h3>
            </div>

            <g:form controller="post" id="${post?.id}">

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
                    <br/>
                    <input type="range" name="rating" min="0" max="5" value="${post?.rating}" step="1.0" id="backing2">

                    <div class="rateit" data-rateit-backingfld="#backing2"></div>
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.token"/>
                    </label>
                    <input type="text" name="secretToken" value="${params.secretToken}" class="form-control"/>
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="user.message.personal.question"/>
                    </label>
                    <g:radioGroup
                            values="['answer.less.18', 'answer.18.25', 'answer.25.35', 'answer.35.45', 'answer.45.55', 'answer.55.65', 'answer.more.65']"
                            name="age" value="1">
                        <p>${it.radio} <g:message code="${it?.label?.trim()?.toLowerCase()?.replace(' ', '.')}"/></p>
                    </g:radioGroup>
                </div>

                <div class="row">
                    <div class="col-sm-12 text-right">
                        <g:actionSubmit value="${message (code: 'button.label.update')}" action="updateAnonymousPost"/>
                        <g:actionSubmit value="${message (code: 'button.label.delete')}" action="deleteAnonymousPost"/>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>