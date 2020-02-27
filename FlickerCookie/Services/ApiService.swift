//
//  ApiService.swift
//  FlickerCookie
//
//  Created by Alexey on 25.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

class APIService {
    
    private let session: URLSession
    private let baseURL: URL
    private let taskService: TasksServiceProtocol

    init(session: URLSession, baseURL: URL,
         taskService: TasksServiceProtocol) {
        self.session = session
        self.baseURL = baseURL
        self.taskService = taskService
    }

    enum APIError: Error {
        case noResponse
        case jsonDecodingError
        case networkError(error: Error)
    }
    
    enum Endpoint {
        case pictureData(idx: Int)
        case pictureImage(url: String)

        func path() -> String {
            switch self {
            case .pictureData(let idx): return "json/320/240/sea?lock=\(idx)"
            case .pictureImage(let url): return url
            }
        }
    }
    
    func GET<T: Codable>(endpoint: Endpoint, result: ((T?, APIError?) -> Void)?) {
        
        let queryURL = URL(string: "\(baseURL)\(endpoint.path())")!
        let components = URLComponents(url: queryURL, resolvingAgainstBaseURL: true)!
        var request = URLRequest(url: components.url!)

        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = self.session.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                result?(nil, APIError.networkError(error: error))
                return
            }
            
            guard let data = data, let object = try? JSONDecoder().decode(T.self, from: data) else {
                result?(nil, APIError.jsonDecodingError)
                return
            }
            
            result?(object, nil)
        }
        
        task.resume()
    }
    
    func downloadImage(endpoint: Endpoint, result: ((Data?, Error?) -> Void)?) {

        let queryURL = URL(string: endpoint.path())!
        
        let task = self.session.dataTask(with: queryURL) { (data, _, error) in
            if let error = error {
                result?(nil, APIError.networkError(error: error))
                return
            }
            result?(data, nil)
        }
        task.resume()
        taskService.add(task, endpoint: endpoint)
    }
    
    func cancelDownloadImage(endpoint: Endpoint) {
        taskService.cancel(endpoint)
    }
}
