//
//  reflect.swift
//  NGTools
//
//  Created by Werck, Ayrton on 2018-11-05.
//  Copyright © 2018 Nuglif. All rights reserved.
//

/// Allows to pretty log optionnal types unboxing them and logging real description
/// or provided default value if 'nil'
///
/// - Parameters:
///   - subject: optional type that must be unwraped for logging purpose
///   - defaultValue: value to log if subject is nil
/// - Returns: string to log
public func reflect<T>(_ subject: T?, defaultValue: String = "") -> String {
    switch subject {
    case .some(let value):
        return String(reflecting: value)
    case .none:
        return defaultValue
    }
}
