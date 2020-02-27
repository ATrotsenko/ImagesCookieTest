//
//  UITableView+Extension.swift
//  FlickerCookie
//
//  Created by Alexey on 26.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

extension UITableView {
    func registerWithoutXib(cls: AnyClass) {
        let identifire = String(describing: cls.self)
        register(cls, forCellReuseIdentifier: identifire)
    }
    
    func dequeueCell<T>(cls: T.Type, index: IndexPath) -> T {
        let identifire = String(describing: cls.self)
        return dequeueReusableCell(withIdentifier: identifire, for: index) as! T
    }
}

