//
//  ObjcBridge.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-10.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation

public final class ObjcBridge: NSObject {

    public static let logger = Logger(subSystem: "Shared Logger")
}

// MARK: - Statics
@objc public extension ObjcBridge {

    static func verbose(_ message: String, category: String) {
        logger.log(logLevel: .verbose, category: Logger.CategoryBridge.custom(category), message: { message })
    }

    static func error(_ message: String, category: String) {
        logger.log(logLevel: .error, category: Logger.CategoryBridge.custom(category), message: { message })
    }

    static func warning(_ message: String, category: String) {
        logger.log(logLevel: .warning, category: Logger.CategoryBridge.custom(category), message: { message })
    }

    static func info(_ message: String, category: String) {
        logger.log(logLevel: .info, category: Logger.CategoryBridge.custom(category), message: { message })
    }

    static func log(_ message: String, level: String, category: String) {
        logger.log(logLevel: .custom(level), category: Logger.CategoryBridge.custom(category), message: { message })
    }
}

extension Logger {

    enum CategoryBridge: LogCategoryProtocol {
        case custom(String)

        var name: String {
            switch self {
            case .custom(let val): return val.capitalized
            }
        }
    }
}
