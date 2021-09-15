//
//  ConsoleFormatter.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-05.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation

public struct ConsoleFormatter: LoggerFormatterProtocol {

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MM-dd HH:mm:ss:SSS"
        return dateFormatter
    }
    private let includeDate: Bool

    public init (includeDate: Bool) {
        self.includeDate = includeDate
    }

    public func format(message: String, details: LogMetaData) -> String {
        let heart: Character

        switch details.level {
        case .error: heart = "💔"
        case .warning: heart = "🧡"
        case .info: heart = "💛"
        case .verbose: heart = "🖤"
        default: heart = "💙"
        }
        var formattedMessage = "\(heart) [\(details.level.name)] [\(details.category.name)] -> \(message)"

        if let line = details.line,
           let fileName = details.fileName,
           let functionName = details.functionName {
            formatDetails(output: &formattedMessage, line: line, fileName: fileName, functionName: functionName)
        }

        return includeDate ? "[\(dateFormatter.string(from: Date()))] [\(details.subSystem)] " + formattedMessage : formattedMessage
    }

    private func formatDetails(output: inout String, line: Int, fileName: String, functionName: String) {
        let trimmedFileName = fileName.components(separatedBy: "/").last ?? ""
        output = "[\(trimmedFileName), \(functionName), \(line)] \(output)"
    }
}
