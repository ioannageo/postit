<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        <g:message code="page.title.companies"/>
    </title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <h3>
            <g:message code="page.header.companies"/>
            <g:link controller="company" action="create" class="btn btn-default pull-right">
                <g:message code="button.label.create"/>
            </g:link>
        </h3>
    </div>

    <g:if test="${!companies || !(companies.size() > 0)}">
        <h5>
            <g:message code="user.no.companies.created"/>
        </h5>
    </g:if>
    <g:else>
        <div class="table-responsive">
            <table class="table">
                <thead>
                <th>

                </th>
                <th>
                    <g:message code="form.field.name"/>
                </th>
                <th>
                    <g:message code="form.field.owner"/>
                </th>
                <th>
                    <g:message code="form.field.phone"/>
                </th>
                <th>
                    <g:message code="form.field.address.street1"/>
                </th>
                <th>
                    <g:message code="form.field.address.street2"/>
                </th>
                <th>
                    <g:message code="form.field.address.area"/>
                </th>
                <th>
                    <g:message code="form.field.country"/>
                </th>
                <th>
                    <g:message code="form.field.address.postal.code"/>
                </th>
                <th>

                </th>
                </thead>
                <g:each in="${companies}" var="company">
                    <tr>
                        <td>
                            <g:if test="${company?.photos.size() > 0}">
                                <g:img class="thumbnail img-responsive" style="max-width: 100px; max-height: 100px;" uri="${createLink(controller: 'photo', action: 'renderImageById', id: company?.getCompanyMainPhoto()?.id)}"/>
                            </g:if>
                        </td>
                        <td style="vertical-align: middle">
                            ${company?.name}
                        </td>
                        <td style="vertical-align: middle">
                            ${company?.owner}
                        </td>
                        <td style="vertical-align: middle">
                            ${company?.phone}
                        </td>
                        <td style="vertical-align: middle">
                            ${company?.address?.street1}
                        </td>
                        <td style="vertical-align: middle">
                            ${company?.address?.street2}
                        </td>
                        <td style="vertical-align: middle">
                            ${company?.address?.area}
                        </td>
                        <td style="vertical-align: middle">
                            <g:country code="${company?.address?.country}"/>
                        </td>
                        <td style="vertical-align: middle">
                            ${company?.address?.postalCode}
                        </td>
                        <td style="vertical-align: middle">
                            <div class="btn-group">
                                <g:link controller="company" action="edit" id="${company?.id}" class="btn btn-default">
                                    <span class="glyphicon glyphicon-pencil"></span>
                                </g:link>
                                <g:link controller="company" action="uploadPhoto" id="${company?.id}" class="btn btn-primary">
                                    <span class="glyphicon glyphicon-upload"></span>
                                </g:link>
                                <g:link controller="company" action="delete" id="${company?.id}" class="btn btn-danger">
                                    <span class="glyphicon glyphicon-remove"></span>
                                </g:link>
                            </div>
                        </td>
                    </tr>
                </g:each>
            </table>
        </div>
    </g:else>
</div>
</body>
</html>