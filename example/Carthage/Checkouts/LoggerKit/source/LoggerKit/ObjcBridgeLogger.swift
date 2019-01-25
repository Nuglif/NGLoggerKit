//
//  ObjcLogger.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-10.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation

public final class ObjcBridgeLogger: NSObject {
    @objc public static let shared = ObjcBridgeLogger()

    public let logger = Logger(subSystem: "Shared Logger")

    @objc public func verbose(_ message: String, category: String) {
        logger.log(logLevel: .verbose, category: Logger.CategoryBridge.custom(category), message: message)
    }

    @objc public func error(_ message: String, category: String) {
        logger.log(logLevel: .error, category: Logger.CategoryBridge.custom(category), message: message)
    }

    @objc public func warning(_ message: String, category: String) {
        logger.log(logLevel: .warning, category: Logger.CategoryBridge.custom(category), message: message)
    }

    @objc public func info(_ message: String, category: String) {
        logger.log(logLevel: .info, category: Logger.CategoryBridge.custom(category), message: message)
    }

    @objc public func log(_ message: String, level: String, category: String) {
        logger.log(logLevel: .custom(level), category: Logger.CategoryBridge.custom(category), message: message)
    }

}
