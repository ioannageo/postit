package postit

import org.bson.types.ObjectId
import postit.domain.Address
import postit.domain.Company
import postit.domain.Post
import postit.domain.User

class PostController {

    def randomService

    /**
     * Render the posts management page to the user. All user posts
     * are show in this page.
     */
    def postsManagement() {
        ObjectId id = session["loggeduser"]?.id
        User user = User.findById(id)
        if (!user) {
            flash.errorMessage = message (code: 'user.login.required')
            redirect(controller: 'landing', action: 'index')
            return
        }

        def posts = user.posts

        render(view: '/post/posts', model: [posts: posts])
    }

    /**
     * Render the post creation/update page to the user without a post instance.
     */
    def create() {
        render (view: '/post/create')
    }

    /**
     * Render the post creation/update page to the user with the post instance.
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

        Post post = Post.get(params.id)
        if (!post) {
            flash.errorMessage = message (code: "user.post.not.found")
            redirect(controller: 'post', action: 'postsManagement')
            return
        }

        render (view: '/post/update', model: [post: post])
    }

    /**
     * If the post exists then it will be updated, otherwise the post will
     * be created.
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

        // instantiate the post record
        Post post

        if (params.id) {
            post = Post.findById(params.id)
        } else {
            Company company = Company.findById(params.companyId)
            post.company = company
            post.user = user
        }

        // bind incoming parameters to the created instance
        bindData(post, params)

        // attempt to validate the company instance prior to creation/update
        if (!post.validate()) {
            log.error "Failed to create/update post instance"
            post.errors.each {
                log.error it
            }
            flash.errorMessage = message (code: "user.post.creation.failed")

            if (params.id) {
                render (view: '/post/update', model: [post: post])
            } else {
                render(view: '/post/update', model: [post: post])
            }
            return
        }

        // if validation is successful then create/update instances
        post.save()

        flash.infoMessage = message (code: 'user.post.updated.success')
        redirect(controller: 'post', action: 'postsManagement')
    }

    /**
     * Delete a post record.
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
        Post post = Post.findById(params.id)
        if (!post) {
            flash.errorMessage = message (code: "user.post.not.found")
            redirect(controller: 'company', action: 'companiesManagemenet')
            return
        }

        post.delete()

        flash.infoMessage = message (code: 'user.post.deleted')
        redirect(controller: 'post', action: 'postsManagement')
    }

    /**
     * Render the new post creation view to the user.
     */
    def postCreation() {
        // retrieve the company instance from the database
        Company company = Company.get(params.companyId)
        if (!company) {
            flash.errorMessage = message (code: "user.company.not.found")
            redirect(controller: 'landing', action: 'index')
            return
        }

        // retrieve the logged in user so that we can define if post is
        // anonymous or not
        ObjectId id = session["loggeduser"]?.id
        User user = User.findById(id)
        boolean anonymous = user ? false : true

        render (view: '/post/newPostCreation', model: [company: company, anonymous: anonymous, post: new Post()])
    }

    /**
     * Create a post instance based on the parameters retrieved. Validate the post
     * instance. If the post instance is invalid we ask the user to fix any errors.
     * If the post is valid then the instance is created in database and the user
     * is redirected to the company details view.
     */
    def createPost() {
        // retrieve the company instance from the database
        Company company = Company.get(params.companyId)
        if (!company) {
            flash.errorMessage = message (code: "user.company.not.found")
            redirect(controller: 'landing', action: 'index')
            return
        }

        // create the post instance
        Post post = new Post()

        // bind the parameters retrieved to the post instance
        bindData(post, params)

        // if the post is not anonymous since a user has logged in
        // we create the post and user relation
        if (!params.anonymous) {
            // retrieve the logged in user
            ObjectId id = session["loggeduser"]?.id
            User user = User.findById(id)
            if (!user) {
                flash.errorMessage = message (code: 'user.login.required')
                redirect(controller: 'landing', action: 'index')
                return
            }

            // set the post and user relation
            post.user = user
        } else {
            // redirect user to another page in order to retrieve the personal question
            // answer
            def randomNumber = randomService.nextLong()
            def encodedRandomNumber = randomNumber.encodeAsMD5()
            session["randomNumber"] = encodedRandomNumber
            session["post"] = post
            session["companyId"] = params.companyId

            render (view: '/post/answerQuestion', model: [randomNumber: session["randomNumber"]])
            return
        }

        // set the post and company relation
        post.company = company

        // validate the post instance
        if (!post.validate()) {
            flash.errorMessage = message (code: "user.post.creation.failed")
            render (view: '/post/newPostCreation', model: [company: company, anonymous: anonymous, post: post])
            return
        }

        // save the post instance in the database
        post.save()

        flash.infoMessage = message (code: 'user.post.creation.success')
        redirect(controller: 'company', action: 'details', id: company.id)
    }

    /**
     * Render the secret token and personal question view. If all is ok
     * then the user is shown the secret token and his answer is retrieved
     * to encrypt his token.
     */
    def createAnonymousPost() {
        // user must provide an answer
        if (!params.age) {
            flash.errorMessage = message (code: 'user.message.age.required')
            render (view: '/post/answerQuestion', model: [randomNumber: session["randomNumber"]])
            return
        }

        // retrieve the company instance from the database
        Company company = Company.get(session["companyId"])
        if (!company) {
            flash.errorMessage = message (code: "user.company.not.found")
            redirect(controller: 'landing', action: 'index')
            return
        }

        // retrieve post instance stored in session
        Post post = (Post) session["post"]

        // retrieve secret token from session, add the age answer provided and
        // generate a new hash
        String randomToken = session["randomNumber"]
        String encryptedToken = (randomToken+params.age).encodeAsMD5()

        // apply the hash to the post
        post.token = encryptedToken

        // the post is defined as anonymous
        post.anonymous = Boolean.TRUE

        // create the relation between the post and the company
        post.company = company

        // validate the post instance
        if (!post.validate()) {
            flash.errorMessage = message (code: "user.post.creation.failed")
            render (view: '/post/answerQuestion', model: [randomNumber: session["randomNumber"]])
            return
        }

        // create the post instance
        post.save()

        flash.infoMessage = message (code: 'user.post.creation.success')
        redirect(controller: 'company', action: 'details', id: company.id)
    }

    def editAnonymousPost() {

        Post post = Post.findById(params.id)
        if (!post) {
            flash.errorMessage = message (code: "user.post.not.found")
            redirect(controller: 'company', action: 'companiesManagemenet')
            return
        }

        render (view: '/post/editAnonymousPost', model: [post: post])

    }

    def updateAnonymousPost() {
        Post post = Post.findById(params.id)
        if (!post) {
            flash.errorMessage = message (code: "user.post.not.found")
            redirect(controller: 'landing', action: 'index')
            return
        }

        // user must provide an answer
        if (!params.age) {
            flash.errorMessage = message (code: 'user.message.age.required')
            render (view: '/post/editAnonymousPost', model: [post: post, age: params.age, secretToken: params.secretToken])
            return
        }

        if (!params.secretToken) {
            flash.errorMessage = message (code: 'user.message.secret.token.required')
            render (view: '/post/editAnonymousPost', model: [post: post, age: params.age, secretToken: params.secretToken])
            return
        }

        // retrieve secret token from session, add the age answer provided and
        // generate a new hash
        String secretToken = params.secretToken
        String ageSelection = params.age

        String encryptedToken = (secretToken+params.age).encodeAsMD5()

        if (post?.token?.equals(encryptedToken)) {
            bindData(post, params)

            // validate the post instance
            if (!post.validate()) {
                flash.errorMessage = message (code: "user.post.creation.failed")
                redirect(controller: 'company', action: 'details', id: post?.company?.id)
                return
            }

            // create the post instance
            post.save()

            flash.infoMessage = message (code: 'user.post.updated.success')
            redirect(controller: 'company', action: 'details', id: post?.company.id)
        } else {
            flash.errorMessage = message (code: 'user.message.you.are.not.the.owner')
            render (view: '/post/editAnonymousPost', model: [post: post])
        }
    }

    def deleteAnonymousPost() {
        Post post = Post.findById(params.id)
        if (!post) {
            flash.errorMessage = message (code: "user.post.not.found")
            redirect(controller: 'landing', action: 'index')
            return
        }

        // user must provide an answer
        if (!params.age) {
            flash.errorMessage = message (code: 'user.message.age.required')
            render (view: '/post/editAnonymousPost', model: [post: post, age: params.age, secretToken: params.secretToken])
            return
        }

        if (!params.secretToken) {
            flash.errorMessage = message (code: 'user.message.secret.token.required')
            render (view: '/post/editAnonymousPost', model: [post: post, age: params.age, secretToken: params.secretToken])
            return
        }

        // retrieve secret token from session, add the age answer provided and
        // generate a new hash
        String secretToken = params.secretToken
        String ageSelection = params.age

        String encryptedToken = (secretToken+params.age).encodeAsMD5()

        // compare the token provided with the persisted one on the post
        log.error post?.token
        log.error encryptedToken

        if (post?.token?.equals(encryptedToken)) {
            // delete the post
            post.delete()

            flash.infoMessage = message (code: 'user.post.deleted')
            redirect(controller: 'company', action: 'details', id: post?.company.id)
        } else {
            flash.errorMessage = message (code: 'user.message.you.are.not.the.owner')
            render (view: '/post/editAnonymousPost', model: [post: post])
        }
    }

    /**
     * Retrieve 10 latest posts created.
     */
    def latestTenPosts() {
        def posts = Post.list(max: 10, sort: "lastUpdated", order: "desc")

        render (template: '/post/latestPostsList', model: [posts: posts])
    }
}
