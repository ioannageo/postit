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
    <div class="row">
        <div class="col-sm-offset-2 col-sm-10">
            <div class="page-header">
                <h3>
                    <g:message code="page.header.create.company"/>
                </h3>
            </div>

            <g:hasErrors bean="${company}">
                <div class="alert alert-danger">
                    <g:eachError><p><g:message error="${it}"/></p></g:eachError>
                </div>
            </g:hasErrors>

            <g:form controller="company" action="update">

                <g:hiddenField name="id" value="${company?.id}"/>
                <g:hiddenField name="address.id" value="${company?.address?.id}"/>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.name"/>
                    </label>
                    <input type="text" class="form-control" name="name" placeholder="Enter company name"
                           value="${company?.name}">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.owner"/>
                    </label>
                    <input type="text" class="form-control" name="owner" placeholder="Enter owner name"
                           value="${company?.owner}">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.address.street1"/>
                    </label>
                    <input type="text" class="form-control" name="address.street1" placeholder="Enter street address"
                           value="${company?.address?.street1}">
                </div>
                
                <div class="form-group">
                    <label>
                        <g:message code="form.field.address.street2"/>
                    </label>
                    <input type="text" class="form-control" name="address.street2" placeholder="Enter street address"
                           value="${company?.address?.street2}">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.address.area"/>
                    </label>
                    <input type="text" class="form-control" name="address.area" placeholder="Enter area"
                           value="${company?.address?.area}">
                </div>
                
                <div class="form-group">
                    <label>
                        <g:message code="form.field.phone"/>
                    </label>
                    <input type="text" class="form-control" name="phone" placeholder="Enter phone"
                           value="${company?.phone}">
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.country"/>
                    </label>
                    <g:countrySelect class="form-control" name="address.country" value="${company?.address?.country}"
                                     noSelection="['': 'Select Country']"/>
                </div>

                <div class="form-group">
                    <label>
                        <g:message code="form.field.address.postal.code"/>
                    </label>
                    <input type="text" class="form-control" name="address.postalCode" placeholder="Enter postal code"
                           value="${company?.address?.postalCode}">
                </div>

                <div class="btn-group pull-right">
                    <button type="submit" class="btn btn-default">
                        <g:message code="button.label.create.or.update"/>
                    </button>
                    <g:link controller="company" action="companiesManagemenet" type="button" class="btn btn-danger">
                        <g:message code="button.label.cancel"/>
                    </g:link>
                </div>
            </g:form>

        </div>
    </div>
</div>
</body>
</html>