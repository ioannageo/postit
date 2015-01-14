<%--
  Created by IntelliJ IDEA.
  User: ioannageo
  Date: 1/12/15
  Time: 20:10
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>
        <g:message code="page.title.posts"/>
    </title>
</head>

<body>

<div class="container">

    <div class="page-header">
        <h3>
            <g:message code="page.header.posts"/>
        </h3>
    </div>

    <g:if test="${!posts || !(posts?.size() > 0)}">
        <h5>
            <g:message code="user.no.posts.created"/>
        </h5>
    </g:if>
    <g:else>
        <div class="table-responsive">
            <table class="table">
                <thead>
                <th>

                </th>
                <th>
                    <g:message code="form.field.company"/>
                </th>
                <th>
                    <g:message code="form.field.comment"/>
                </th>
                <th>
                    <g:message code="form.field.post.rating"/>
                </th>
                <th>
                    <g:message code="form.field.date.created"/>
                </th>
                <th>
                    <g:message code="form.field.last.updated"/>
                </th>
                <th>

                </th>
                </thead>
                <g:each in="${posts}" var="post">
                    <tr>
                        <td>
                            <g:if test="${post?.company?.photos.size() > 0}">
                                <g:img class="thumbnail img-responsive" style="max-width: 100px; max-height: 100px;" uri="${createLink(controller: 'photo', action: 'renderImageById', id: post?.company?.getCompanyMainPhoto()?.id)}"/>
                            </g:if>
                        </td>
                        <td style="vertical-align: middle">
                            ${post?.company?.name}
                        </td>
                        <td style="vertical-align: middle">
                            ${post?.comment}
                        </td>
                        <td style="vertical-align: middle">
                            <input type="number" value="${post?.rating}" id="postid${post?.id}">
                            <div class="rateit" data-rateit-readonly="true" data-rateit-backingfld="#postid${post?.id}" readonly="true"></div>
                        </td>
                        <td style="vertical-align: middle">
                            <g:formatDate date="${post?.dateCreated}" format="dd/MM/yyyy"/>
                        </td>
                        <td style="vertical-align: middle">
                            <g:formatDate date="${post?.lastUpdated}" format="dd/MM/yyyy"/>
                        </td>
                        <td style="vertical-align: middle">
                            <div class="btn-group">
                                <g:link controller="post" action="edit" id="${post?.id}" class="btn btn-default">
                                    <span class="glyphicon glyphicon-pencil"></span>
                                </g:link>
                                <g:link controller="post" action="delete" id="${post?.id}" class="btn btn-danger delete-comment">
                                    <span class="glyphicon glyphicon-remove"></span>
                                </g:link>
                            </div>
                        </td>
                    </tr>
                </g:each>
            </table>
        </div>
    </g:else>

    <g:javascript>

        $(function() {
            // find all elements that have a delete-comment class
            // remove any click event handlers then add one click event handler
            // we also provide the code to execute on the click event
            $('.delete-comment').off('click').on('click', function(event) {
                // don't allow to execute default action on link clicked
                event.preventDefault();

                // provide confirmation message to user and await feedback
                var userMessage = '<g:message code="user.message.delete.post.feedback"/>';

                // get the actual url to which the link directs to
                var url = $(this).attr('href');

                // get user feedback on confirmation message
                var userInput = confirm(userMessage);

                // if user is ok then proceed with the post deletion
                if (userInput == true) {
                    window.location = url;
                }
            })
        })
    </g:javascript>
</div>
</body>
</html>