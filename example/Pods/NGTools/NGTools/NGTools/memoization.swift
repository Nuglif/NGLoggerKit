//
//  memoization.swift
//  NGTools
//
//  Created by Werck, Ayrton on 2018-11-05.
//  Copyright © 2018 Nuglif. All rights reserved.
//

import Foundation

/// This method trade memory usage for cpu
/// If the input is already cached the output will be fetched from the dictionary else the value will be computed using the function passed as parameters and the results will be saved
/// - Parameter fn: function to be cached
/// - Returns: A function that takes the input of the function passed as parameter and returns the computed value
public func cached<In: Hashable, Out>(_ fn: @escaping (In) -> Out) -> (In) -> Out {
    var cache: [In: Out] = [:]

    return { (input: In) -> Out in
        if let cachedOut = cache[input] {
            return cachedOut
        }
        let out = fn(input)
        cache[input] = out
        return out
    }
}

public func cachedAutoFlush<In: Hashable & AnyObject, Out: AnyObject>(_ fn: @escaping (In) -> Out) -> (In) -> Out {
    let cache: NSCache<In, Out> = NSCache()

    return { (input: In) -> Out in
        if let cachedOut = cache.object(forKey: input) {
            return cachedOut
        }
        let out = fn(input)
        cache.setObject(out, forKey: input)
        return out
    }
}
