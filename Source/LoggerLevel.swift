//
//  LoggerLevel.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-04.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation

public enum LoggerLevel: Equatable, Comparable {

    case verbose
    case info
    case warning
    case error
    case custom(String)
    case none

    public var name: String {
        switch self {
        case .custom(let val): return val.capitalized
        default: return String(describing: self).capitalized
        }
    }

    public var order: Int {
        switch self {
        case .verbose: return 0
        case .info: return 1
        case .warning: return 2
        case .error: return 3
        case .custom: return 4
        case .none: return 5
        }
    }

    public static func < (lhs: LoggerLevel, rhs: LoggerLevel) -> Bool {
            return lhs.order < rhs.order
    }
}

extension LoggerLevel: RawRepresentable {
    public typealias RawValue = String

    public init?(rawValue: String) {
        let loweredRawValue = rawValue.lowercased()
        switch loweredRawValue {
        case "error":
            self = .error
        case "warning":
            self = .warning
        case "verbose":
            self = .verbose
        case "info":
            self = .info
        case "none":
            self = .none
        default:
            return nil
        }
    }

    public var rawValue: String {
        return String(describing: self)
    }
}
