<div class="page-header">
    <h3>
        <g:message code="page.header.user.posts"/>
        <span class="pull-right">
            <g:link controller="post" action="postCreation" params="[companyId: company?.id]" class="btn btn-default">
                <g:message code="button.label.review"/>
            </g:link>
        </span>
    </h3>
</div>

<g:if test="${postsCount == 0}">
    <h5>
        <g:message code="user.no.posts.for.company.created"/>
    </h5>
</g:if>
<g:else>
    <g:render template="/company/postsList" model="[posts: posts, postsCount: postsCount]"/>
</g:else>