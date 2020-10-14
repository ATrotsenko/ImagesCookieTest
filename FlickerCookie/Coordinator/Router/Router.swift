//
//  Router.swift
//  FlickerCookie
//
//  Created by Alexey on 27.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

typealias NavigationBackClosure = EmptyBlock

protocol RouterProtocol: class {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
}

class Router: NSObject, RouterProtocol {
    
    let navigationController: UINavigationController
    private var closures = [String: NavigationBackClosure]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }
    
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }
        
        print(self.navigationController.viewControllers.count)
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        
        self.navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func pop(_ isAnimated: Bool) {
        self.navigationController.popViewController(animated: isAnimated)
    }
    
    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}

extension Router : UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {

        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }
}
