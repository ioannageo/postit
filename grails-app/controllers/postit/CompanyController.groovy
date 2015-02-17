package postit

import org.bson.types.ObjectId
import postit.domain.Address
import postit.domain.Company
import postit.domain.Post
import postit.domain.User

class CompanyController {

	def companyService

	/**
	 * Render the companies management page to the user. All user companies
	 * are show in this page.
	 */
	def companiesManagemenet() {
		ObjectId id = session["loggeduser"]?.id
		User user = User.findById(id)
		if (!user) {
			flash.errorMessage = message (code: 'user.login.required')
			redirect(controller: 'landing', action: 'index')
			return
		}

		def companies = user.companies

		render(view: '/company/companies', model: [companies: companies])
	}

	/**
	 * Render the company creation/update page to the user without a company instance.
	 */
	def create() {
		render (view: '/company/create')
	}

	/**
	 * Render the company creation/update page to the user with the company instance.
	 */
	def edit() {
		// retrieve the logged in user
		ObjectId id = session["loggeduser"]?.id
		User user = User.findById(id)
		if (!user) {
			flash.errorMessage = message (code: 'user.login.required')
			redirect(controller: 'landing', action: 'index')
			return
		}

		Company company = Company.get(params.id)
		if (!company) {
			flash.errorMessage = message (code: "user.company.not.found")
			redirect(controller: 'company', action: 'companiesManagemenet')
			return
		}

		render (view: '/company/update', model: [company: company])
	}

	/**
	 * If the company exists then it will be updated, otherwise the company will
	 * be created along with the related address.
	 */
	def update() {
		// retrieve the logged in user
		ObjectId id = session["loggeduser"]?.id
		User user = User.findById(id)
		if (!user) {
			flash.errorMessage = message (code: 'user.login.required')
			redirect(controller: 'landing', action: 'index')
			return
		}

		// instantiate the address and company records
		Company company

		if (params.id) {
			company = Company.findById(params.id)
		} else {
			company = new Company()
			company.address = new Address()
			company.user = user
		}

		// bind incoming parameters to the created instance
		bindData(company, params)

		// attempt to validate the company instance prior to creation/update
		if (!company.validate()) {
			log.error "Failed to create/update company instance"
			company.errors.each { log.error it }
			flash.errorMessage = message (code: "user.company.creation.failed")

			if (params.id) {
				render (view: '/company/update', model: [company: company])
			} else {
				render(view: '/company/update', model: [company: company])
			}
			return
		}

		// if validation is successful then create/update instances
		company.save()

		flash.infoMessage = message (code: 'user.company.creation.success')
		redirect(controller: 'company', action: 'companiesManagemenet')
	}

	/**
	 * Intention to Delete a company record along with its address and any uploaded photos.
	 */
	def delete() {
		// retrieve the logged in user
		ObjectId id = session["loggeduser"]?.id
		User user = User.findById(id)
		if (!user) {
			flash.errorMessage = message (code: 'user.login.required')
			redirect(controller: 'landing', action: 'index')
			return
		}

		// retrieve the selected company record
		Company company = Company.findById(params.id)
		if (!company) {
			flash.errorMessage = message (code: "user.company.not.found")
			redirect(controller: 'company', action: 'companiesManagemenet')
			return
		}
		render(view: '/company/deleteCompany', model: [company: company])
	}
	
	/**
	 * Delete permanently a company record along with all its details after being asked.
	 */

	def deletePerm() {
		// retrieve the logged in user
		ObjectId id = session["loggeduser"]?.id
		User user = User.findById(id)
		if (!user) {
			flash.errorMessage = message (code: 'user.login.required')
			redirect(controller: 'landing', action: 'index')
			return
		}

		// retrieve the selected company record
		Company company = Company.findById(params.id)
		if (!company) {
			flash.errorMessage = message (code: "user.company.not.found")
			redirect(controller: 'company', action: 'companiesManagemenet')
			return
		}

		company.delete()

		flash.infoMessage = message (code: 'user.company.deleted')
		redirect(controller: 'company', action: 'companiesManagemenet')
	}

	def uploadPhoto() {
		// retrieve the logged in user
		ObjectId id = session["loggeduser"]?.id
		User user = User.findById(id)
		if (!user) {
			flash.errorMessage = message (code: 'user.login.required')
			redirect(controller: 'landing', action: 'index')
			return
		}

		// retrieve the selected company record
		Company company = Company.findById(params.id)
		if (!company) {
			flash.errorMessage = message (code: "user.company.not.found")
			redirect(controller: 'company', action: 'companiesManagemenet')
			return
		}

		render(view: '/company/uploadPhoto', model: [company: company])
	}

	/**
	 * Retrieve 10 latest companies created.
	 */
	def latestTenCompanies() {
		def companies = Company.list(max: 10, sort: "lastUpdated", order: "desc")

		render (template: '/company/latestCompaniesList', model: [companies: companies])
	}

	/**
	 * Render list of companies. Max list of companies rendered are 20. If the user
	 * scrolls the page down there another 20 companies are rendered alogn with the
	 * previously rendered companies. If the user continues to scroll down then
	 * more companies are rendered accordingly.
	 */
	def companiesList() {
		log.error params
		// if no max parameter is set then set it by default to 20
		if (!params.max) {
			params.max = 20
		}

		// if no page index has been set then set it by default to 0
		if (!params.offset) {
			params.offset = 0
		}

		// retrieve total number companies found in the database
		def companiesCount = getListOfCompanies(params, true)

		// retrieve list of 20 companies based of course on the page index
		// defined by offset
		def companies = getListOfCompanies(params, false)

		render(template: '/company/companiesList', model: [companies: companies, companiesCount: companiesCount])
	}

	/**
	 * Render company details view to the user.
	 */
	def details() {
		// retrieve the company instance from the database
		Company company = Company.get(params.id)
		if (!company) {
			flash.errorMessage = message (code: "user.company.not.found")
			redirect(controller: 'landing', action: 'index')
			return
		}

		render (view: '/company/company', model: [company: company])
	}

	def companiesPosts() {
		// retrieve the company instance from the database
		Company company = Company.get(params.id)
		if (!company) {
			flash.errorMessage = message (code: "user.company.not.found")
			redirect(controller: 'company', action: 'companiesManagemenet')
			return
		}

		// if no max parameter is set then set it by default to 20
		if (!params.max) {
			params.max = 5
		}

		// if no page index has been set then set it by default to 0
		if (!params.offset) {
			params.offset = 0
		}

		// retrieve total number of posts found in the database for company
		def postsCount = getListOfPostsForCompany(params, company, true)

		// retrieve list of 20 posts based of course on the page index
		// defined by offset
		def posts = getListOfPostsForCompany(params, company, false)

		render (template: '/company/companyPostsList', model: [posts: posts, postsCount: postsCount, companyId: company?.id])
	}

	def postsList() {
		// retrieve the company instance from the database
		Company company = Company.get(params.id)
		if (!company) {
			flash.errorMessage = message (code: "user.company.not.found")
			redirect(controller: 'company', action: 'companiesManagemenet')
			return
		}

		// if no max parameter is set then set it by default to 20
		if (!params.max) {
			params.max = 20
		}

		// if no page index has been set then set it by default to 0
		if (!params.offset) {
			params.offset = 0
		}

		// retrieve total number of posts found in the database for company
		def postsCount = getListOfPostsForCompany(params, company, true)

		// retrieve list of 20 posts based of course on the page index
		// defined by offset
		def posts = getListOfPostsForCompany(params, company, false)

		render (template: '/company/postsList', model: [posts: posts, postsCount: postsCount, companyId: company?.id])
	}

	private def getListOfCompanies(def params, boolean counting) {
		// check if any address information is provided and
		// find those addresses first before dealing with companies
		def addresses
		boolean addressParameterDefined = false
		if (params?.address?.street1 || params?.address?.area || params?.address?.country || params?.address?.postalCode) {
			addressParameterDefined = true
			def criteria = Address.createCriteria()
			addresses = criteria.list {
				if (params?.address?.street1) {
					like ('street1', '%' + params.address.street1 + '%')
				}

				if (params?.address?.area) {
					like ('area', '%' + params.address.area + '%')
				}

				if (params?.address?.country) {
					like ('country', '%' + params.address.country + '%')
				}

				if (params?.address?.postalCode) {
					like ('postalCode', '%' + params.address.postalCode + '%')
				}
			}
		}

		def results = Company.createCriteria().list {
			if (!counting) {
				if (params.max) {
					maxResults (params.max instanceof String ? Integer.parseInt(params.max) : params.max)
				} else {
					maxResults 20
				}

				if (params.offset) {
					firstResult (params.offset instanceof String ? Integer.parseInt(params.offset) : params.offset)
				} else {
					firstResult 0
				}
			}

			if (params?.name) {
				like ('name', '%' + params.name + '%')
			}

			if (params?.owner) {
				like ('owner', '%' + params.owner + '%')
			}

			if (params?.description) {
				like ('description', '%' + params.description + '%')
			}

			if (addresses || addressParameterDefined) {
				'in' ('id', addresses*.company*.id)
			}

			if (counting) {
				projections { rowCount() }
			} else {
				order "lastUpdated", "desc"
			}
		}
	}

	private def getListOfPostsForCompany(def params, Company company, boolean counting) {
		def results = Post.createCriteria().list {
			if (!counting) {
				if (params.max) {
					maxResults (params.max instanceof String ? Integer.parseInt(params.max) : params.max)
				} else {
					maxResults 20
				}

				if (params.offset) {
					firstResult (params.offset instanceof String ? Integer.parseInt(params.offset) : params.offset)
				} else {
					firstResult 0
				}
			}

			eq ('company', company)

			if (counting) {
				projections { rowCount() }
			} else {
				order "lastUpdated", "desc"
			}
		}
	}
}
