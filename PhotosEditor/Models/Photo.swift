//
//  Photo.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import UIKit

struct Photo {
    var id: String
    var image: UIImage
    var creationDate: Date
    var description: String?
    
    init(id: String, image: UIImage, creationDate: Date, description: String? = nil) {
        self.id = id
        self.image = image
        self.creationDate = creationDate
        self.description = description
    }
}
