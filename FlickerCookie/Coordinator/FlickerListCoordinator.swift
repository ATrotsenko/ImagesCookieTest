//
//  FlickerListCoordinator.swift
//  FlickerCookie
//
//  Created by Alexey on 27.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class FlickerListCoordinator: BaseCoordinator {
    
    let router: RouterProtocol
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    lazy var controller: FlickerListViewController = {
        let apiService = APIService(session: URLSession.shared,
                                    baseURL: URL(string: "https://loremflickr.com/")!,
                                    taskService: TasksService())
        
        let networkService = NetworkService(apiService, cacheService: CacheService())
        let viewModel = FlickerListViewModel(networkService)
        let viewController = FlickerListViewController(viewModel: viewModel)
        
        return viewController
    }()
    
    override func start() {
        self.controller.viewModel.showFlicker = { [weak self] (model) in
            guard let strongSelf = self else { return }
            strongSelf.showItemDescription(model: model)
        }
    }

    private func showItemDescription(model: FlickerModel) {
        let descriptionCoordinator = FlickerDescriptionCoordinator(router: self.router, model: model)
        self.store(coordinator: descriptionCoordinator)
        self.router.push(descriptionCoordinator, isAnimated: true) { [weak self, weak descriptionCoordinator] in
            guard let strongSelf = self, let descriptionCoordinator = descriptionCoordinator else { return }
            strongSelf.free(coordinator: descriptionCoordinator)
        }
    }
}

extension FlickerListCoordinator: Drawable {
    var viewController: UIViewController? { return controller }
}
