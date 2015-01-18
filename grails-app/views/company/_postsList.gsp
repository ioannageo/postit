%{--<g:javascript plugin="remote-pagination" library="remoteNonStopPageScroll"/>--}%

<div id="postsList">
    <g:each in="${posts}" var="post">

        <div class="row post-row">

            <div class="col-sm-9">
                <h4>
                    ${post?.comment}
                </h4>

                <g:if test="${post?.anonymous}">
                    <g:link controller="post" action="editAnonymousPost" id="${post?.id}" class="btn btn-default">
                        <g:message code="button.label.update"/>
                    </g:link>
                </g:if>
            </div>
            <div class="col-sm-3">
                <div class="col-sm-12 text-right">
                    <h6>
                        <input type="number" value="${post?.rating}" id="postid${post?.id}">
                        <div class="rateit" data-rateit-readonly="true" data-rateit-backingfld="#postid${post?.id}" readonly="true"></div>
                    </h6>
                </div>
                <div class="col-sm-12 text-right">
                    <h6>
                        <g:message code="user.added.by"/>
                        <strong style="color: darkorange">
                            <g:if test="${post?.anonymous}">
                                <g:message code="user.anonymous"/>
                            </g:if>
                            <g:else>
                                ${post?.user?.username}
                            </g:else>
                        </strong>
                    </h6>
                </div>

                <div class="col-sm-12 text-right">
                    <h6>
                        <g:message code="form.field.updated.on"/>
                        <strong style="color: darkorange">
                            <g:formatDate date="${post?.lastUpdated}" format="dd/MM/yyyy"/>
                        </strong>
                    </h6>
                </div>
            </div>

        </div>

    </g:each>
</div>

<util:remoteNonStopPageScroll
        controller="company"
        action="postsList"
        id="${companyId}"
        total="${postsCount[0]}"
        update="postsList"
        heightOffset="10"
        loadingHtml="spinner"/>