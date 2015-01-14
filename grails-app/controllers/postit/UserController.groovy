package postit

import postit.domain.User

class UserController {

    /**
     * Render the registration page to the user.
     */
    def register() {
        render(view: '/user/register')
    }

    /**
     * Retrieve provided information for user registration, create a
     * user instance from that information, validate the created instance
     * and finally persist the instance in the database and automatically
     * login the registered user.
     */
    def doRegister() {
        User user = new User()
        bindData(user, params)

        log.error user.password
        log.error params.repeatPassword

        if (!user?.password.equals(params.repeatPassword)) {
            flash.errorMessage = message (code: 'user.registration.failed.password.unequal')
            render(view: '/user/register', model: [user: user])
            return;
        }

        if (!user.save()) {
            log.error 'Failed to save user instance.'
            user.errors.each {
                log.error it;
            }
            flash.errorMessage = message (code: 'user.registration.failed')
            render(view: '/user/register', model: [user: user])
            return;
        }

        session["loggeduser"] = user

        flash.infoMessage = message (code: 'user.registration.complete.verify')
        redirect( controller: 'landing', action: 'index')
    }

    /**
     * Person user authentication with username and password.
     */
    def authentication() {
        String username = params.username
        String password = params.password

        User user = User.findByUsernameAndPassword(username, password)
        if (!user) {
            flash.errorMessage = message (code: "user.login.failed")
            redirect(controller: 'landing', action: 'index')
            return
        }

        session["loggeduser"] = user
        redirect(controller: 'landing', action: 'index')
    }

    /**
     * Logout user by invalidating the user's session.
     */
    def deauthentication() {
        if (session["loggeduser"]) {
            session.invalidate()
        }

        redirect(controller: 'landing', action: 'index')
    }
}
