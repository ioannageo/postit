<%--
  Created by IntelliJ IDEA.
  User: vbledar
  Date: 1/10/15
  Time: 3:27
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        <g:message code="page.title.company.with.name" args="[company?.name]"/>
    </title>
</head>

<body>

    <div class="page-header">
        <h3>
            ${company?.name}
        </h3>
    </div>

    <div class="row">
        <div class="col-sm-4">
            <g:if test="${company?.photos && company?.photos?.size() > 0}">
                <g:render template="/company/companyPhotosCarousel" model="[photos: company?.photos]"/>
            </g:if>
        </div>
        <div class="col-sm-8">
            <div class="row">
                <div class="col-sm-12">
                    <blockquote>
                        <p>
                            <g:message code="form.field.owner"/>
                        </p>
                        <footer>
                            <g:if test="${company?.owner}">
                                ${company?.owner}
                            </g:if>
                            <g:else>
                                <g:message code="user.no.owner.provided"/>
                            </g:else>
                        </footer>
                    </blockquote>
                    <blockquote>
                        <p>
                            <g:message code="form.field.description"/>
                        </p>
                        <footer>
                            <g:if test="${company?.description}">
                                ${company?.description}
                            </g:if>
                            <g:else>
                                <g:message code="user.no.description.provided"/>
                            </g:else>
                        </footer>
                    </blockquote>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12">
            <g:include controller="company" action="companiesPosts" id="${company?.id}"/>
        </div>
    </div>
</body>
</html>