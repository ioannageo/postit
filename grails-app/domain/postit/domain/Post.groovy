package postit.domain

import org.bson.types.ObjectId

class Post {

    ObjectId id                                         // object id in database

    Boolean anonymous = Boolean.FALSE                   // defines if post is anonymous

    String comment                                      // the post's comment

    Date dateCreated                                    // creation date
    Date lastUpdated                                    // update date

    Integer rating                                      // user rating place on post

    static belongsTo = [company: Company, user: User]   // company and user instances related with post

    static constraints = {
        anonymous nullable: false

        comment nullable: false, maxSize: 4000

        company nullable: false
        user nullable: true
    }

    static mapping = {
        comment sqlType: 'text'
    }
}
