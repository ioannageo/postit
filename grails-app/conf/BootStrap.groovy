import org.bson.types.ObjectId
import postit.domain.Address
import postit.domain.Company
import postit.domain.Photo
import postit.domain.User

class BootStrap {

    int users2Create = 5                // number of test users to create
    int companies2Create = 100          // number of test companies to create

    def init = { servletContext ->
//        createTestUsers()               // execute user creation
//        createTestCompanies()           // execute companies creation
    }
    def destroy = {
    }

    def createTestUsers() {

        String username = "testuser"
        String password = "testpass"
        String email = "test1@test.com"
        String firstname = "test"
        String lastname = "test"

        User user
        for (int i=0; i<users2Create; i++) {
            user = User.findByUsername(username)
            if (!user) {
                user = new User()
                user.username = username+i
                user.password = password+i
                user.email = email.replaceAll("@", i+"@")
                user.firstname = firstname+i
                user.lastname = lastname+i
                user.save(flush: true)
            }
        }
    }

    def createTestCompanies() {

        // test data for company
        String name = "test company "
        String owner = "test owner "
        String description = "test description "
        String street1 = "test street "
        String area = "test area "
        String country = "grc"
        String postalCode = "12345"

        User user
        for (int i = 1; i < companies2Create; i++) {
            int userId = i % users2Create
            user = User.findByUsername("testuser"+userId)

            if (!user) {
                continue
            }

            Company company = Company.findByName(name + i)
            if (!company) {
                Address address = new Address()
                address.street1 = street1 + i
                address.area = area + i
                address.country = country
                address.postalCode = postalCode

                company = new Company()
                company.name = name + i
                company.owner = owner + i
                company.description = description + i
                company.address = address

                Photo photo = Photo.findById(new ObjectId('54b4efe87d84544f03904d1a'))
                if (!photo) {
                    photo = Photo.findById(new ObjectId('54b464c2a4da22b54d9bdd8b'))
                    if (!photo) {
                        photo = Photo.list(max: 1)
                    }
                }
                photo.id = null

                company.addToPhotos(photo)
                company.user = user

                company.save(flush: true)
            }
        }
    }
}
