//
//  Logger.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-05.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation

public typealias LogDetails =  (line: Int, functionName: String, fileName: String)

public final class Logger {
    public let subSystem: String

    public init(subSystem: String) {
        self.subSystem = subSystem
    }

    public init(subSystem: String, loggers: ContiguousArray<LoggerProtocol>? = nil) {
        if let loggers = loggers {
            self.loggers = loggers
        }
        self.subSystem = subSystem
    }

    // MARK: Private properties
    private var loggers: ContiguousArray<LoggerProtocol> = []

    // MARK: Public properties

    // Display only this level if set
    public var filter: FilterProtocol = FilterLevel(minLevel: .verbose, isStrict: false) {
        didSet {
            self.update(filter: filter, where: nil)
        }
    }

    //Objc enum
    enum CategoryBridge: LogCategoryProtocol {
        case custom(String)

        var name: String {
            switch self {
            case .custom(let val): return val.capitalized
            }
        }
    }

    // MARK: Public methods

    public func update(filter: FilterProtocol, where isIncluded: ((LoggerProtocol) -> Bool)?) {
        if let isIncluded = isIncluded {
            let loggersToUpdate = loggers.filter(isIncluded)
            return loggersToUpdate.forEach { $0.filter = filter }
        }
        loggers.forEach { $0.filter = filter }
    }

    /// Add a new logger to the list
    /// - Parameter logger: the new logger to add to the list
    public func add(logger: LoggerProtocol) {
        loggers.append(logger)
    }

    public func remove(where predicate: (LoggerProtocol) -> Bool) {
        loggers.filter(predicate)
            .forEach(remove(logger:))
    }

    /// Remove a logger from the list
    /// - Parameter logger: The instance of the logger present in the list
    public func remove(logger: LoggerProtocol) {
        guard let index = loggers.index(where: { $0 === logger }) else { return }
        removeLogger(at: index)
    }

    /// Remove logger at index
    /// - Parameter index: Index of the logger which will be removed from the list
    public func removeLogger(at index: Int) {
        loggers.remove(at: index)
    }

    public func removeAll() {
        loggers.removeAll()
    }

    public func find(where predicate: (LoggerProtocol) -> Bool) -> [LoggerProtocol] {
        return loggers.filter(predicate)
    }
}

extension Logger: LoggerProtocol {

    /// convenient method to log
    ///
    /// - Parameters:
    ///   - logLevel: level of the log
    ///   - category: category of the log
    ///   - message: message to log
    ///   - details: Details of the call, see the sample to see how to use it
    public func log(logLevel: LoggerLevel = .none, category: LogCategoryProtocol, _ message: @autoclosure () -> String, details: LogDetails) {
        log(logLevel: logLevel, category: category, message: message(), line: details.line, functionName: details.functionName, fileName: details.fileName)
    }

    /// Log to the different loggers registered
    ///
    /// - Parameters:
    ///   - logLevel: Level of the log
    ///   - category: Category of the log
    ///   - message: Message to be logged
    ///   - line: line in the file which call this function
    ///   - functionName: Name of the function which call this function
    ///   - fileName: Name of the file where this function is called
    public func log(logLevel: LoggerLevel = .none, category: LogCategoryProtocol, message: @autoclosure() -> String, line: Int = #line, functionName: String = #function, fileName: String = #file) {
        loggers.forEach({ $0.log(logLevel: logLevel, category: category, message: message, line: line, functionName: functionName, fileName: fileName) })
    }
}
