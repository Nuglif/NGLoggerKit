//
//  Logger.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-05.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import Foundation

public typealias LogDetails = (line: Int, functionName: String, fileName: String)

public final class Logger {
    // Objc enum
    enum CategoryBridge: LogCategoryProtocol {
        case custom(String)

        var name: String {
            switch self {
            case .custom(let val): return val.capitalized
            }
        }
    }

    // MARK: Public properties
    public let subSystem: String
    // Display only this level if set
    public var filter: FilterProtocol = FilterLevel(minLevel: .verbose, isStrict: false) {
        didSet { update(filter: filter) }
    }

    // MARK: Private properties
    private var loggers: ContiguousArray<LoggerProtocol> = []
    private let loggerQueue: DispatchQueue

    // MARK: Public methods
    public init(subSystem: String) {
        self.subSystem = subSystem
        self.loggerQueue = DispatchQueue(label: "com.nuglif.NGLoggerKit.\(subSystem)", qos: .utility)
    }

    public init(subSystem: String, loggers: ContiguousArray<LoggerProtocol>? = nil) {
        if let loggers = loggers {
            self.loggers = loggers
        }

        self.subSystem = subSystem
        self.loggerQueue = DispatchQueue(label: "com.nuglif.NGLoggerKit.\(subSystem)", qos: .utility)
    }

    public func update(filter: FilterProtocol, where isIncluded: ((LoggerProtocol) -> Bool)? = nil) {
        loggerQueue.async {
            self.loggers
                .filter(isIncluded ?? { _ in true })
                .forEach { $0.filter = filter }
        }
    }

    /// Add a new logger to the list
    /// - Parameter logger: the new logger to add to the list
    public func add(logger: LoggerProtocol) {
        loggerQueue.async {
            self.loggers.append(logger)
        }
    }

    public func remove(where predicate: @escaping (LoggerProtocol) -> Bool) {
        loggerQueue.async {
            self.loggers.removeAll(where: predicate)
        }
    }

    /// Remove a logger from the list
    /// - Parameter logger: The instance of the logger present in the list
    public func remove(logger: LoggerProtocol) {
        loggerQueue.async {
            self.loggers.removeAll(where: { $0 === logger })
        }
    }

    /// Remove logger at index
    /// - Parameter index: Index of the logger which will be removed from the list
    public func remove(at index: Int) {
        loggerQueue.async {
            self.loggers.remove(at: index)
        }
    }

    public func removeAll() {
        loggerQueue.async {
            self.loggers.removeAll()
        }
    }

    public func find(where predicate: @escaping (LoggerProtocol) -> Bool, completion: @escaping ([LoggerProtocol]) -> Void) {
        loggerQueue.async {
            completion(self.loggers.filter(predicate))
        }
    }
}

// MARK: - LoggerProtocol
extension Logger: LoggerProtocol {

    /// convenient method to log
    ///
    /// - Parameters:
    ///   - logLevel: level of the log
    ///   - category: category of the log
    ///   - message: message to log
    ///   - details: Details of the call, see the sample to see how to use it
    public func log(logLevel: LoggerLevel = .none, category: LogCategoryProtocol, _ message: @escaping @autoclosure () -> String, details: LogDetails) {
        loggerQueue.async {
            self.loggers.forEach { $0.log(logLevel: logLevel, category: category, message: message(), line: details.line, functionName: details.functionName, fileName: details.fileName) }
        }
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
    public func log(logLevel: LoggerLevel = .none, category: LogCategoryProtocol, message: @escaping @autoclosure() -> String, line: Int = #line, functionName: String = #function, fileName: String = #file) {
        loggerQueue.async {
            self.loggers.forEach { $0.log(logLevel: logLevel, category: category, message: message(), line: line, functionName: functionName, fileName: fileName) }
        }
    }
}
