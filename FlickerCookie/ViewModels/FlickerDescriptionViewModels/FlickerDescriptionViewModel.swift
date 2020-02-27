//
//  FlickerDescriptionViewModel.swift
//  FlickerCookie
//
//  Created by Alexey on 27.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

class FlickerDescriptionViewModel {
    
    private let model: FlickerModel

    var imageData: Data? {
        return model.imageData
    }
    
    var authorName: String? {
        return model.pictureData?.owner
    }
    
    var fileURL: String? {
        return model.pictureData?.file
    }
    
    init(model: FlickerModel) {
        self.model = model
    }
}
