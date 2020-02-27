//
//  CacheSevice.swift
//  FlickerCookie
//
//  Created by Alexey on 26.02.2020.
//  Copyright © 2020 home. All rights reserved.
//

import Foundation

struct CacheService {
    let cache = NSCache<NSString, NSData>()
    
    func saveData(_ data: Data, key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func data(key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }

}
