//
//  OSLogger.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-13.
//  Copyright © 2018 Nuglif. All rights reserved.
//

import os.log

@available(iOS 10.0, *)
public final class OSLogger: LoggerProtocol {
    public let subSystem: String
    public var filter: FilterProtocol

	private var osLogs: [String: OSLog] = [:]

	private let formatter: LoggerFormatterProtocol
	private let shouldShowLogDetails: Bool

	public init(subSystem: String, configuration: ConsoleConfiguration) {
		self.subSystem = subSystem
		self.formatter = configuration.formatter
		self.filter = configuration.filter
		self.shouldShowLogDetails = configuration.shouldShowLogDetails
	}

	public func log(logLevel: LoggerLevel, category: LogCategoryProtocol, message: @autoclosure () -> String, line: Int, functionName: String, fileName: String) {
		let details: LogMetaData = shouldShowLogDetails ?
			LogMetaData(level: logLevel, category: category, subSystem: subSystem, line: line, functionName: String(describing: functionName), fileName: String(describing: fileName)) :
			LogMetaData(level: logLevel, category: category, subSystem: subSystem)
		guard filter.canLog(details: details, message: message)  else { return }
		let formattedMessage = formatter.format(message: message(), details: details)

		if let log = osLogs[category.name] {
			return osLog(message: formattedMessage, log: log, level: logLevel)
		}

		let oslog = OSLog(subsystem: subSystem, category: category.name)
		osLogs[category.name] = oslog
		osLog(message: formattedMessage, log: oslog, level: logLevel)
	}

	private func osLog(message: String, log: OSLog, level: LoggerLevel) {
		switch level {
		case .error: os_log("%{public}@", log: log, type: .fault, message)
		case .info: os_log("%{public}@", log: log, type: .info, message)
		case .warning: os_log("%{public}@", log: log, type: .error, message)
		case .none: os_log("%{public}@", log: log, type: .default, message)
		default: os_log("%{public}@", log: log, type: .debug, message)
		}
	}
}

@available(iOS 10.0, *)
extension OSLogger: ReuseIDProvider {}
