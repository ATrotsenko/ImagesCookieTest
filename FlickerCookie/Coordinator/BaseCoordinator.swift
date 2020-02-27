//
//  BaseCoordinator.swift
//  FlickerCookie
//
//  Created by Alexey on 27.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

class BaseCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var isCompleted: EmptyBlock?
    
    func start() {
        fatalError("Children should implement `start`.")
    }
}

