<nav class="navbar navbar-default">
    <div class="container">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <g:link controller="landing" action="index" class="navbar-brand">
                    <g:message code="application.name"/>
                </g:link>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <g:if test="${session["loggeduser"]}">
                        <li>
                            <g:link controller="company" action="companiesManagemenet">
                                <g:message code="menu.companies.management"/>
                            </g:link>
                        </li>
                        <li>
                            <g:link controller="post" action="postsManagement">
                                <g:message code="menu.posts.management"/>
                            </g:link>
                        </li>
                    </g:if>
                </ul>

                <g:if test="${session["loggeduser"]}">
                    <form class="navbar-form navbar-right">
                        <g:message code="user.message.signed.in.as" args="[session['loggeduser'].username]"/>
                        <g:link controller="user" action="deauthentication" class="btn btn-default">
                            <g:message code="button.label.logout"/>
                        </g:link>
                    </form>
                </g:if>
                <g:else>
                    <g:form controller="user" action="authentication" class="navbar-form navbar-right" role="login">
                        <div class="form-group">
                            <input type="text" name="username" class="form-control" placeholder="Username">
                        </div>
                        <div class="form-group">
                            <input type="password" name="password" class="form-control" placeholder="Password">
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <g:message code="button.label.login"/>
                        </button>
                        <g:link controller="user" action="register" class="btn btn-default">
                            <g:message code="button.label.register"/>
                        </g:link>
                    </g:form>
                </g:else>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </div>
</nav>