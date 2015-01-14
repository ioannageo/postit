package postit

import org.bson.types.ObjectId
import org.springframework.web.multipart.commons.CommonsMultipartFile
import postit.domain.Company
import postit.domain.Photo
import postit.domain.User
import sun.misc.BASE64Decoder
import sun.misc.BASE64Encoder

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

class PhotoController {

    def uploadPhoto() {
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

        // read the file bytes, encode them as base64 and store the data in the photo instance
        CommonsMultipartFile file = params.myFile
        String contentType = file.contentType
        String data = this.encodeByteArraytoB64(file.inputStream.bytes)
        String filename = file.getName()

        // create a new photo instance
        Photo photo = new Photo(filename: filename, contentType: contentType, b64PhotoData: data, company: company)

        if (!photo.save()) {
            flash.errorMessage = message(code: 'user.company.photo.upload.failed')
        } else {
            flash.infoMessage = message(code: 'user.company.photo.uploaded.ok')
        }

        redirect(controller: 'company', action: 'uploadPhoto', params: [id: company.id])
    }

    /**
     * Send an image to the client. The image is found by its id.
     */
    def renderImageById() {
        Photo photo = Photo.findById(params.id)
        if (!photo) {
            log.error 'Photo not found!'
            return
        }

        byte[] imageBytes = decodeB64ToByteArray(photo.b64PhotoData)
        response.setHeader('Content-length', imageBytes.length.toString())
        response.contentType = photo.contentType ? photo.contentType : 'image/jpg' // or the appropriate image content type
        response.outputStream << imageBytes
        response.outputStream.flush()
    }

    private String encodeByteArraytoB64(byte[] data) {
        BASE64Encoder encoder = new BASE64Encoder()
        return encoder.encode(data)
    }

    private String encodeImageToB64(BufferedImage image, String type) {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ImageIO.write(image, type, bos);
        byte[] imageBytes = bos.toByteArray();
        BASE64Encoder encoder = new BASE64Encoder()
        bos.close()
        return encoder.encode(imageBytes)
    }

    private byte[] decodeB64ToByteArray(String data) {
        BASE64Decoder decoder = new BASE64Decoder();
        return decoder.decodeBuffer(data);
    }
}
