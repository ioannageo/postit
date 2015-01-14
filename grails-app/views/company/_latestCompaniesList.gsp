<ul class="list-group">
    <g:each in="${companies}" var="company">
        <li class="list-group-item">
            <g:link controller="company" action="details" id="${company?.id}" style="text-decoration: none">
                <h5 class="list-group-item-heading">
                    ${company?.name}
                    <span class="badge pull-right">
                        ${company?.posts?.size()}
                    </span>
                </h5>

                <p class="list-group-item-text">
                    ${company?.description}
                </p>
            </g:link>
        </li>
    </g:each>
</ul>