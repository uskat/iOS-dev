
import UIKit

struct Photo {
    
    var imageName: UIImage
    
    static func addPhotos() -> [Photo] {
        var photos: [Photo] = []
        for index in 0..<21 {
            index < 9 ? photos.append(Photo(imageName: UIImage(named: "pic0\(index + 1)")!)) : photos.append(Photo(imageName: UIImage(named: "pic\(index + 1)")!))
        }
        return photos
    }
}
