//
//  ObjcBridge+Tests.swift
//  NGLoggerKit
//
//  Created by Fournier, Olivier on 2021-01-18.
//  Copyright © 2021 Nuglif. All rights reserved.
//

import Foundation

@testable import NGLoggerKit

@objc public extension ObjcBridge {

    static func setupDefault() {
        logger.add(logger: LoggerBuilder().buildDefault(subSystem: "Shared Logger"))
    }
}
