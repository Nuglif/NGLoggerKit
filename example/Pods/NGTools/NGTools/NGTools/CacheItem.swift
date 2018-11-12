//
//  CacheItem.swift
//  NGTools
//
//  Created by Goldschmidt, Jérémy on 2018-11-06.
//  Copyright © 2018 Nuglif. All rights reserved.
//

import Foundation

/// CacheItem provides a wrapper around structs so as to store them
/// with NSCache 
public class CacheItem<T>: NSObject {
    public let value: T

    public init(_ item: T) {
        self.value = item
    }
}
