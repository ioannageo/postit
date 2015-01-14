package postit.domain

import org.bson.types.ObjectId

class Photo {

    ObjectId id                             // object id in database

    String filename                         // image filename
    String contentType                      // image type (jpg, png, etc)
    String b64PhotoData                     // image data base64 encoded

    Date dateCreated                        // creation date
    Date lastUpdated                        // update date

    static belongsTo = [company: Company]   // the company of the photo

    static constraints = {
        contentType nullable: true
        b64PhotoData nullable: false
    }

    static mapping = {
        b64PhotoData sqlType: 'text'
    }
}
