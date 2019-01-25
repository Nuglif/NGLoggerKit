//
//  JsonLoader.swift
//  NGTools
//
//  Created by Werck, Ayrton on 2018-11-05.
//  Copyright © 2018 Nuglif. All rights reserved.
//

import Foundation

public func += <KeyType, ValueType> (left: inout [KeyType: ValueType], right: [KeyType: ValueType]) {
    for (key, value) in right {
        left.updateValue(value, forKey: key)
    }
}

public protocol JsonLoader {
    func decodeJson<T: Decodable>(decoder: JSONDecoder, for type: T.Type) -> T?
}

public extension JsonLoader {
    public func decodeJson<T: Decodable>(decoder: JSONDecoder = JSONDecoder(), for type: T.Type = T.self) -> T? {
        var result: T?
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            result = try decoder.decode(type, from: data)
            return result
        } catch {
            return nil
        }
    }
}

extension Dictionary: JsonLoader {}
extension NSDictionary: JsonLoader {}
