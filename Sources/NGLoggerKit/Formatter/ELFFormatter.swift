//
//  ELFFormatter.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-04.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation

public struct ELFFormatter: LoggerFormatterProtocol {

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MM-dd HH:mm:ss:SSS"

        return dateFormatter
    }

    public init () {}

    public func format(message: String, details: LogMetaData) -> String {
        var formattedMessage = "[\(details.level.name)] [\(details.category.name)] -> \(message)"

        if let line = details.line,
           let fileName = details.fileName,
           let functionName = details.functionName {
            formatDetails(output: &formattedMessage, line: line, fileName: fileName, functionName: functionName)
        }
        return "[\(dateFormatter.string(from: Date()))] [\(details.subSystem)] " + formattedMessage
    }

    private func formatDetails(output: inout String, line: Int, fileName: String, functionName: String) {
        let trimmedFileName = fileName.components(separatedBy: "/").last ?? ""

        output = "[\(trimmedFileName), \(functionName), \(line)]:\r \t\(output)"
    }
}
