<%@ page contentType="text/html;charset=UTF-8" %>
<g:applyLayout name="main">

    <div class="container">

        <div class="row">

            <div class="col-xs-12 col-sm-3">
                <g:if test="${pageProperty(name: "page.filters")}">
                    <g:pageProperty name="page.filters" />
                </g:if>
            </div>

            <div class="col-xs-12 col-sm-6">
                <g:layoutBody/>
            </div>

            <div class="hidden-xs col-sm-3">

                <div class="page-header">
                    <g:message code="panel.title.latest.ten.companies"/>
                </div>

                <g:include controller="company" action="latestTenCompanies"/>

                <br />

                <div class="page-header">
                    <g:message code="panel.title.latest.ten.posts"/>
                </div>

                <g:include controller="post" action="latestTenPosts"/>
            </div>

        </div>

    </div>
</g:applyLayout>