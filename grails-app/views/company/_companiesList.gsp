<g:javascript plugin="remote-pagination" library="remoteNonStopPageScroll"/>

<div id="companiesList">
    <g:each in="${companies}" var="company">
        <div class="col-xs-12 col-sm-6 col-md-6">
            <div class="thumbnail">
                <g:if test="${company?.photos && company?.photos?.size() > 0}">
                    <g:img uri="${createLink(controller: 'photo', action: 'renderImageById', id: company?.getCompanyMainPhoto()?.id)}"/>
                </g:if>
                <div class="caption">
                    <h5>
                        ${company?.name}
                    </h5>
                    <p>
                        ${company?.description}
                    </p>
                    <p class="text-right">
                        <g:link controller="company" action="details" id="${company?.id}" class="btn btn-default">
                            <g:message code="button.label.details"/>
                        </g:link>
                    </p>
                </div>
            </div>
        </div>
    </g:each>

    <util:remoteNonStopPageScroll
            controller="company"
            action="companiesList"
            params="${params}"
            total="${companiesCount[0]}"
            update="companiesList"
            heightOffset="10"
            loadingHtml="spinner"/>



</div>