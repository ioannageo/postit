package postit.domain

import org.bson.types.ObjectId

class Company {

    ObjectId id                                     // object id in database

    String name                                     // company name
    String owner                                    // owner's name

    String description                              // company description

    Date dateCreated                                // creation date
    Date lastUpdated                                // update date

    static hasOne = [address: Address]              // company address

    static hasMany = [photos: Photo, posts: Post]   // company photos and posts

    static belongsTo = [user: User]                 // user that created the company

    static constraints = {
        name nullable: false, maxSize: 100
        owner nullable: true, maxSize: 100

        description nullable: true, maxSize: 2000

        address nullable: false

        user nullable: false
    }

    Photo getCompanyMainPhoto() {
        return photos.sort { it?.dateCreated }[0]
    }
}
