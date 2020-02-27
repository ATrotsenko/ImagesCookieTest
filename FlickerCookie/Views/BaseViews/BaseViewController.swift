//
//  BaseViewController.swift
//  FlickerCookie
//
//  Created by Alexey on 27.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 12.0, *) {
            view.backgroundColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        } else {
            view.backgroundColor = .white
        }
    }
}
