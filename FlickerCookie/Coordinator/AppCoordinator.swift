//
//  AppCoordinator.swift
//  FlickerCookie
//
//  Created by Alexey on 24.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    let window: UIWindow
    
    init(_ window: UIWindow) {
        self.window = window
        super.init()
    }
    
    override func start() {
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController)
        let listCoordinator = FlickerListCoordinator(router: router)
        
        self.store(coordinator: listCoordinator)
        listCoordinator.start()
        
        router.push(listCoordinator, isAnimated: true) { [weak self, weak listCoordinator] in
            guard let strongSelf = self, let listCoordinator = listCoordinator else { return }
            strongSelf.free(coordinator: listCoordinator)
        }
                
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}
