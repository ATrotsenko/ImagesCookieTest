//
//  FlickerDescriptionCoordinator.swift
//  FlickerCookie
//
//  Created by Alexey on 27.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class FlickerDescriptionCoordinator: BaseCoordinator {
    
    let router: RouterProtocol
    let controller: FlickerDescriptionViewController!
    
    init(router: RouterProtocol, model: FlickerModel) {
        self.router = router
        let viewModel = FlickerDescriptionViewModel(model: model)
        self.controller = FlickerDescriptionViewController(viewModel: viewModel)
        super.init()
    }
}

extension FlickerDescriptionCoordinator: Drawable {
    var viewController: UIViewController? { return controller }
}
