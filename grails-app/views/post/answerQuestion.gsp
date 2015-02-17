<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        <g:message code="page.title.post.answer.question"/>
    </title>
</head>

<body>
<div class="container">
    <div class="row">
        <div class="col-sm-offset-2 col-sm-8">
            <g:form controller="post" action="createAnonymousPost">
                <div class="row">
                    <div class="col-sm-12 alert alert-warning">
                        <h5>
                            <g:message code="user.information.store.token"/>
                        </h5>
                        <blockquote>
                            <h1>
                                ${randomNumber}
                            </h1>
                        </blockquote>
                    </div>
                </div>

                <div class="page-header">
                    <h3>
                        <g:message code="page.header.post.answer.question"/>
                    </h3>
                </div>

                <div class="row post-row">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label>
                                <g:message code="user.message.personal.question"/>
                            </label>
                            <g:radioGroup
                                    values="['answer.less.18', 'answer.18.25', 'answer.25.35', 'answer.35.45', 'answer.45.55', 'answer.55.65', 'answer.more.65']"
                                    name="age" value="1">
                                <p>${it.radio} <g:message
                                        code="${it?.label?.trim()?.toLowerCase()?.replace(' ', '.')}"/></p>
                            </g:radioGroup>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <button type="submit" class="btn btn-default">
                            <g:message code="button.label.create"/>
                        </button>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>