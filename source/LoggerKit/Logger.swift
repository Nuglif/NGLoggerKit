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
    private static let workOnLoggersQeue = DispatchQueue(
        label: "com.nuglif.loggerkit.logger.workOnLoggersQueue",
        attributes: .concurrent)

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
        Logger.workOnLoggersQeue.async(flags: .barrier) { [weak self] in
            if let isIncluded = isIncluded {
                guard let loggersToUpdate = self?.loggers.filter(isIncluded) else {
                    return
                }
                loggersToUpdate.forEach { $0.filter = filter }
            }
            self?.loggers.forEach { $0.filter = filter }
        }
    }

    /// Add a new logger to the list
    /// - Parameter logger: the new logger to add to the list
    public func add(logger: LoggerProtocol) {
        Logger.workOnLoggersQeue.async(flags: .barrier) { [weak self] in
            self?.loggers.append(logger)
        }
    }

    public func remove(where predicate: @escaping (LoggerProtocol) -> Bool) {
        Logger.workOnLoggersQeue.async(flags: .barrier) { [weak self] in
            self?.loggers.filter(predicate).forEach({ logger in
                guard let index = self?.loggers.firstIndex(where: { $0 === logger }) else { return }
                self?.loggers.remove(at: index)
            })
        }
    }

    /// Remove a logger from the list
    /// - Parameter logger: The instance of the logger present in the list
    public func remove(logger: LoggerProtocol) {
        Logger.workOnLoggersQeue.async(flags: .barrier) { [weak self] in
            guard let index = self?.loggers.firstIndex(where: { $0 === logger }) else { return }
            self?.loggers.remove(at: index)
        }
    }

    /// Remove logger at index
    /// - Parameter index: Index of the logger which will be removed from the list
    public func removeLogger(at index: Int) {
        Logger.workOnLoggersQeue.async(flags: .barrier) { [weak self] in
            self?.loggers.remove(at: index)
        }
    }

    public func removeAll() {
        Logger.workOnLoggersQeue.async(flags: .barrier) { [weak self] in
            self?.loggers.removeAll()
        }
    }

    public func find(where predicate: (LoggerProtocol) -> Bool) -> [LoggerProtocol] {
        return Logger.workOnLoggersQeue.sync { [weak self] in
            return self?.loggers.filter(predicate) ?? []
        }
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
    public func log(logLevel: LoggerLevel = .none, category: LogCategoryProtocol, message: @escaping @autoclosure () -> String, details: LogDetails) {
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
    public func log(logLevel: LoggerLevel = .none, category: LogCategoryProtocol, message: @escaping @autoclosure() -> String, line: Int = #line, functionName: String = #function, fileName: String = #file) {
        Logger.workOnLoggersQeue.sync { [weak self] in
            self?.loggers.forEach({ logger in
                logger.log(logLevel: logLevel, category: category, message: message(), line: line, functionName: functionName, fileName: fileName)
            })
        }
    }
}
