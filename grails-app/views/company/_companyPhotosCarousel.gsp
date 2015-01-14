<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">


    <ol class="carousel-indicators">
        <g:each in="${photos?.sort { it.dateCreated }}" var="photo" status="index">
            <g:if test="${index == 0}">
                <li data-target="#carousel-example-generic" data-slide-to="${index}" class="active"></li>
            </g:if>
            <g:else>
                <li data-target="#carousel-example-generic" data-slide-to="${index}"></li>
            </g:else>
        </g:each>
    </ol>

    <div class="carousel-inner" role="listbox">
        <g:each in="${photos?.sort { it.dateCreated }}" var="photo" status="index">
            <g:if test="${index == 0}">
                <div class="item active">
                    <g:img uri="${createLink(controller: 'photo', action: 'renderImageById', id: photo?.id)}"
                           class="img-responsive" style="margin-left: auto; margin-right: auto;"/>
                </div>
            </g:if>
            <g:else>
                <div class="item">
                    <g:img uri="${createLink(controller: 'photo', action: 'renderImageById', id: photo?.id)}"
                           class="img-responsive" style="margin-left: auto; margin-right: auto;"/>
                </div>
            </g:else>
        </g:each>
    </div>


    <!-- Controls -->
    <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">
            <g:message code="button.label.previous"/>
        </span>
    </a>
    <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">
            <g:message code="button.label.next"/>
        </span>
    </a>
</div>