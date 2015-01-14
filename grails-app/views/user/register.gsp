<%--
  Created by IntelliJ IDEA.
  User: ioannageo
  Date: 1/10/15
  Time: 1:14
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">

    <title>
        <g:message code="page.title.registration"/>
    </title>
</head>

<body>

<div class="container">
    <div class="row">
        <div class="col-sm-offset-2 col-sm-8">
            <div class="page-header">
                <h3>
                    <g:message code="page.header.registration"/>
                </h3>
            </div>

            <g:hasErrors bean="${user}">
                <div class="alert alert-danger">
                    <g:eachError><p><g:message error="${it}"/></p></g:eachError>
                </div>
            </g:hasErrors>

            <g:form controller="user" action="doRegister">
                <div class="form-group">
                    <label>
                        <g:message code="form.field.email.address"/>
                    </label>
                    <input type="email" class="form-control" name="email" placeholder="Enter email"
                           value="${user?.email}">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.username"/>
                    </label>
                    <input type="text" class="form-control" name="username" placeholder="Enter username"
                           value="${user?.username}">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.password"/>
                    </label>
                    <input type="password" class="form-control" name="password" placeholder="Enter password">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.repeat.password"/>
                    </label>
                    <input type="password" class="form-control" name="repeatPassword" placeholder="Enter password again">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.firstname"/>
                    </label>
                    <input type="text" class="form-control" name="firstname" placeholder="Enter firstname"
                           value="${user?.firstname}">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.lastname"/>
                    </label>
                    <input type="text" class="form-control" name="lastname" placeholder="Enter lastname"
                           value="${user?.lastname}">
                </div>

                <button type="submit" class="btn btn-default pull-right">
                    <g:message code="button.label.register"/>
                </button>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>