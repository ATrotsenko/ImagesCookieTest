//
//  FlickerModel.swift
//  FlickerCookie
//
//  Created by Alexey on 25.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

// MARK: - FlickerModel
class FlickerModel {
    let index: Int
    var imageData: Data?
    var pictureData: PictureDataModel?
    
    init(idx: Int) {
        self.index = idx
    }
}

class PictureDataModel: Codable {
    
    let file: String
    let license: String
    let owner: String
    let width: Int
    let height: Int
    let filter: String
    let tags: String
    let tagMode: String

    init(file: String, license: String, owner: String, width: Int, height: Int, filter: String, tags: String, tagMode: String) {
        self.file = file
        self.license = license
        self.owner = owner
        self.width = width
        self.height = height
        self.filter = filter
        self.tags = tags
        self.tagMode = tagMode
    }
}
