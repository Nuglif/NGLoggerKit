//
//  LoggerFormatterProtocol.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-06.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public struct LogMetaData {
    public let level: LoggerLevel
    public let category: LogCategoryProtocol
    public let subSystem: String

    public let userInfo: [String: Any]?
    public let line: Int?
    public let functionName: String?
    public let fileName: String?

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
