<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="twocolumn"/>
    <title>
        <g:message code="application.name"/>
    </title>
</head>

<body>

<content tag="filters">
    <g:form controller="landing" action="index">
            <div class="page-header">
                <g:message code="panel.title.filters"/>
            </div>
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.name"/>
                    </label>
                    <input type="text" class="form-control" name="name" placeholder="Enter company name"
                           value="${params?.name}">
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.owner"/>
                    </label>
                    <input type="text" class="form-control" name="owner" placeholder="Enter owner name"
                           value="${company?.owner}">
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.description"/>
                    </label>
                    <g:textArea name="description" class="form-control" rows="5" cols="20"
                                placeholder="Enter company description"
                                value="${params?.description}"/>
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.address.street1"/>
                    </label>
                    <input type="text" class="form-control" name="address.street1" placeholder="Enter street address"
                           value="${params?.address?.street1}">
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.address.street2"/>
                    </label>
                    <input type="text" class="form-control" name="address.street2" placeholder="Enter street address"
                           value="${params?.address?.street2}">
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.address.area"/>
                    </label>
                    <input type="text" class="form-control" name="address.area" placeholder="Enter area"
                           value="${params?.address?.area}">
                </div>
                
                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.phone"/>
                    </label>
                    <input type="text" class="form-control" name="phone" placeholder="Enter phone"
                           value="${params?.phone}">
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.country"/>
                    </label>
                    <g:countrySelect class="form-control" name="address.country" value="${params?.address?.country}"
                                     noSelection="['': 'Select Country']"/>
                </div>

                <div class="form-group">
                    <label for="exampleInputEmail1">
                        <g:message code="form.field.address.postal.code"/>
                    </label>
                    <input type="text" class="form-control" name="address.postalCode" placeholder="Enter postal code"
                           value="${params?.address?.postalCode}">
                </div>
            </div>

            <div class="panel-footer">
                <button type="submit" class="btn btn-primary">
                    <g:message code="button.label.search"/>
                </button>
                <g:link controller="landing" action="index" class="btn btn-default">
                    <g:message code="button.label.clear" />
                </g:link>
            </div>
        </div>
    </g:form>
</content>


<div class="page-header">
    <g:message code="panel.title.list.of.companies"/>
</div>

<g:include controller="company" action="companiesList"/>

</body>
</html>
