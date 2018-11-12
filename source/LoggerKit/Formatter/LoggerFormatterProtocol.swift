//
//  LoggerFormatterProtocol.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-06.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public struct LogMetaData {
    let level: LoggerLevel
    let category: LogCategoryProtocol
    let subSystem: String

    let userInfo: [String: Any]?
    let line: Int?
    let functionName: String?
    let fileName: String?

    public init(level: LoggerLevel,
                category: LogCategoryProtocol,
                subSystem: String,
                userInfo: [String: Any]? = nil,
                line: Int? = nil,
                functionName: String? = nil,
                fileName: String? = nil) {
        self.line = line
        self.functionName = functionName
        self.fileName = fileName
        self.level = level
        self.category = category
        self.userInfo = userInfo
        self.subSystem = subSystem
    }
}

public protocol LoggerFormatterProtocol {
    func format(message: String, details: LogMetaData) -> String
}
