//
//  ConsoleLogger.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-04.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import LoggerKit
import CocoaLumberjack

final class LumberjackConsoleLogger: LoggerProtocol {
	let subSystem: String

	var filter: FilterProtocol = FilterLevel(minLevel: .verbose, isStrict: false)

	private let configuration: ConsoleConfiguration
	private var formatter: LoggerFormatterProtocol { return configuration.formatter }
	private var shouldShowLogDetails: Bool { return configuration.shouldShowLogDetails }

	public init(subSystem: String, configuration: ConsoleConfiguration) {
		self.subSystem = subSystem
		self.configuration = configuration
	}

	func log(logLevel: LoggerLevel, category: LogCategoryProtocol, message: @autoclosure () -> String, line: Int, functionName: String, fileName: String) {
		let details: LogMetaData = shouldShowLogDetails ?
			LogMetaData(level: logLevel, category: category, subSystem: subSystem, line: line, functionName: String(describing: functionName), fileName: String(describing: fileName)) :
			LogMetaData(level: logLevel, category: category, subSystem: subSystem)
		guard filter.canLog(details: details, message: message)  else { return }

		let formattedMessage = formatter.format(message: message(), details: details)

		switch logLevel {
		case .info: DDLogInfo(formattedMessage)
		case .warning: DDLogWarn(formattedMessage)
		case .error: DDLogError(formattedMessage)
		case .verbose: DDLogVerbose(formattedMessage)
		default: DDLogDebug(formattedMessage)
		}
	}
}
