//
//  LoggerProtocol.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-03.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public protocol LoggerProtocol: class {
    var filter: FilterProtocol { get set }
    var subSystem: String { get }

    func log(logLevel: LoggerLevel, category: LogCategoryProtocol, message: @autoclosure () -> String, line: Int, functionName: String, fileName: String)
}

extension LoggerProtocol {

    public func info(_ category: LogCategoryProtocol, _ message: @autoclosure () -> String, line: Int = #line, functionName: String = #function, fileName: String = #file) {
        log(logLevel: .info, category: category, message: message(), line: line, functionName: functionName, fileName: fileName)
    }

    public func warning(_ category: LogCategoryProtocol, _ message: @autoclosure () -> String, line: Int = #line, functionName: String = #function, fileName: String = #file) {
        log(logLevel: .warning, category: category, message: message(), line: line, functionName: functionName, fileName: fileName)
    }

    public func error(_ category: LogCategoryProtocol, _ message: @autoclosure () -> String, line: Int = #line, functionName: String = #function, fileName: String = #file) {
        log(logLevel: .error, category: category, message: message(), line: line, functionName: functionName, fileName: fileName)
    }

    public func verbose(_ category: LogCategoryProtocol, _ message: @autoclosure () -> String, line: Int = #line, functionName: String = #function, fileName: String = #file) {
        log(logLevel: .verbose, category: category, message: message(), line: line, functionName: functionName, fileName: fileName)
    }
}
