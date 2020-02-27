//
//  UIImage+Extension.swift
//  FlickerCookie
//
//  Created by Alexey on 26.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setColor(_ color: UIColor) {
        image?.withRenderingMode(.alwaysTemplate)
        tintColor = color
    }
    
    func setImageData(_ data: Data?) {
        guard let data = data else {
            image = nil
            return
        }
        UIView.transition(with: self,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: { self.image = UIImage(data: data) },
                          completion: nil)
    }
}
