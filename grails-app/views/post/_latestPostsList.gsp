<ul class="list-group">
    <g:each in="${posts}" var="post">
        <li class="list-group-item">
            <g:link controller="company" action="details" id="${post?.company?.id}" style="text-decoration: none">
                ${post?.comment}
            </g:link>
            <br />
            <h6>
                <input type="number" value="${post?.rating}" id="postid${post?.id}">
                <div class="rateit" data-rateit-readonly="true" data-rateit-backingfld="#postid${post?.id}" readonly="true"></div>
            </h6>
        </li>
    </g:each>
</ul>