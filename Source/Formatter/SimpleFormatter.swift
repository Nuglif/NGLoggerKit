//
//  SimpleFormatter.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-13.
//  Copyright © 2018 Nuglif. All rights reserved.
//

import Foundation

public struct SimpleFormatter: LoggerFormatterProtocol {

    public init() {}

    public func format(message: String, details: LogMetaData) -> String {
        var messageToFormat = message

        if let line = details.line,
            let fileName = details.fileName,
            let functionName = details.functionName {
            formatDetails(output: &messageToFormat, line: line, fileName: fileName, functionName: functionName)
        }
        return messageToFormat
    }

    private func formatDetails(output: inout String, line: Int, fileName: String, functionName: String) {
        let trimmedFileName = fileName.components(separatedBy: "/").last ?? ""
        output = "[\(trimmedFileName), \(functionName), \(line)] \(output)"
    }
}
