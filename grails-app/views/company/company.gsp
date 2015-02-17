<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<meta name="layout" content="main" />
<title><g:message code="page.title.company.with.name"
		args="[company?.name]" /></title>
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
				<g:render template="/company/companyPhotosCarousel"
					model="[photos: company?.photos]" />
			</g:if>
		</div>
		<div class="col-sm-8">
			<div class="row">
				<div class="col-sm-12">
					<blockquote>
						<p>
							<g:if test="${company?.owner}">
								${company?.owner}
							</g:if>
							<g:else>
								<g:message code="user.no.owner.provided" />
							</g:else>
						</p>
						<footer>
							<g:message code="form.field.owner" />
						</footer>
					</blockquote>
					<blockquote>
						<p>
							<address>
								<strong>
									${company?.address?.area}
								</strong><br>
								${company?.address?.street1}<br>
								${company?.address?.street2}<br>
								<g:country code="${company?.address?.country}" />
								, PS
								${company?.address?.postalCode}<br> <abbr title="Phone">P:</abbr>
								${company?.phone}
							</address>
						</p>
						<footer>
							<g:message code="form.field.address" />
						</footer>
					</blockquote>
					<blockquote>
						<p>
							<g:if test="${company?.description}">
								${company?.description}
							</g:if>
							<g:else>
								<g:message code="user.no.description.provided" />
							</g:else>
						</p>
						<footer>
							<g:message code="form.field.description" />
						</footer>
					</blockquote>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-12">
			<g:include controller="company" action="companiesPosts"
				id="${company?.id}" />
		</div>
	</div>
</body>
</html>