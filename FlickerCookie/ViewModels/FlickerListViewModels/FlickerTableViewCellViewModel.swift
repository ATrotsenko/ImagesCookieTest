//
//  FlickerTableViewCellViewModel.swift
//  FlickerCookie
//
//  Created by Alexey on 24.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

enum State {
    case loading
    case error
    case success
}

class FlickerTableViewCellViewModel {
    
    let model: FlickerModel
    
    private let networkService: NetworkServiceProtocol
    private var state: State = .loading {
        didSet {
            self.stateBlock?(self.state)
        }
    }
    
    var stateBlock: ((State) -> Void)?
    var dataBlock: EmptyBlock?
    
    var imageData: Data? {
        return model.imageData
    }
    var authorName: String? {
        return model.pictureData?.owner
    }
    
    init(_ model: FlickerModel, networkService: NetworkServiceProtocol) {
        self.model = model
        self.networkService = networkService
    }
    
    func startImageDownload() {
        self.state = .loading
        guard let imageURL = model.pictureData?.file  else { return }

        networkService.downloadImageData(imageURL) { [weak self] (data) in
            guard let data = data else {
                self?.state = .error
                return
            }
            self?.state = .success
            self?.model.imageData = data
            self?.dataBlock?()
        }
    }
    
    func stopImageDownload() {
        guard let imageURL = model.pictureData?.file else { return }
        networkService.cancelDownloadImageData(imageURL)
    }
}
