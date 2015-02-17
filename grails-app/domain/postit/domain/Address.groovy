package postit.domain

import org.bson.types.ObjectId

class Address {

    ObjectId id                             // object id in database

    String street1                          // street information
	String street2
    
	String area                             // area description
    String country                          // country description

    String postalCode                       // area postal code

    static belongsTo = [company: Company]

    static constraints = {
        street1 nullable: false, maxSize: 100
		street2 nullable: true

        area nullable: false, maxSize: 50
        country nullable: false

        postalCode nullable: true

        company nullable: false
    }
}
