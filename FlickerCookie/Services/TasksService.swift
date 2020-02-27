//
//  TasksService.swift
//  FlickerCookie
//
//  Created by Alexey on 26.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

protocol TasksServiceProtocol {
    func add(_ task: URLSessionDataTask, endpoint: APIService.Endpoint)
    func cancel(_ endpoint: APIService.Endpoint)
}

class TasksService: TasksServiceProtocol {
    
    struct Task {
        let task: URLSessionDataTask
        let endpoint: String
    }
    
    private var imageTasks = [Task]()
    private let internalQueue: DispatchQueue = DispatchQueue(label:"LockingQueue")

    func add(_ task: URLSessionDataTask, endpoint: APIService.Endpoint) {
        let imageTask = Task(task: task, endpoint: endpoint.path())
        
        internalQueue.sync {
            imageTasks.append(imageTask)
        }
    }
    
    func cancel(_ endpoint: APIService.Endpoint) {
        internalQueue.sync {
            if let index = imageTasks.firstIndex(where: { $0.endpoint == endpoint.path() }) {
                imageTasks[index].task.suspend()
                imageTasks.remove(at: index)
            }
        }
    }
}
