package postit.domain

import org.bson.types.ObjectId

class User implements Serializable {

    ObjectId id                             // object id in database

    String username                         // username for authentication
    String password                         // password for authentication

    String firstname                        // user first name
    String lastname                         // user last name
    
    String email                            // user email address is required and must be verified

    static hasMany = [companies: Company, posts: Post]

    static constraints = {
        username nullable: false, minSize: 6, maxSize: 12
        password nullable: false, minSize: 6, maxSize: 20, display: false

        firstname nullable: true, maxSize: 50
        lastname nullable: true, maxSize: 50

        email nullable: false

        companies nullable: true
        posts nullable: true
    }

    static mapping = {
        companies (sort: 'id', order: 'desc')
    }
}
