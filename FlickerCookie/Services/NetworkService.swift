//
//  NetworkService.swift
//  LoremflickrCookie
//
//  Created by Alexey on 24.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func downloadData(_ models: [FlickerModel], success: EmptyBlock?)
    func downloadImageData(_ url: String, success: ((Data?) -> Void)?)
    func cancelDownloadImageData(_ url: String)
}

class NetworkService {
    
    private let apiService: APIService
    private let cacheService: CacheService

    init(_ apiService: APIService, cacheService: CacheService) {
        self.apiService = apiService
        self.cacheService = cacheService
    }
}

extension NetworkService: NetworkServiceProtocol {
    
    func downloadData(_ models: [FlickerModel], success: (() -> Void)?) {
        let dispatchGroup = DispatchGroup()
        for model in models {
            dispatchGroup.enter()
            apiService.GET(endpoint: APIService.Endpoint.pictureData(idx: model.index)) { (obj: PictureDataModel?, error) in
                dispatchGroup.leave()
                model.pictureData = obj
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            success?()
        }
    }
    
    func downloadImageData(_ url: String, success: ((Data?) -> Void)?) {
        let cacheService = self.cacheService
        
        if let data = cacheService.data(key: url) {
            success?(data)
            return
        }
        
        apiService.downloadImage(endpoint: APIService.Endpoint.pictureImage(url: url)) { (data, error) in
            if let data = data {
                cacheService.saveData(data, key: url)
            }
            DispatchQueue.main.async {
                if let _ = error {
                    success?(nil)
                    return
                }
                success?(data)
            }
        }
    }
    
    func cancelDownloadImageData(_ url: String) {
        apiService.cancelDownloadImage(endpoint: APIService.Endpoint.pictureImage(url: url))
    }
}
