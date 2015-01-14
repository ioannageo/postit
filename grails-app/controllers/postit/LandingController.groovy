package postit

import postit.domain.Post

class LandingController {

    def index() {

        def posts = Post.findAll(params)

        render (view: '/index', model: [params: params])
    }

}
