//
//  ConsoleLogger.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-05.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public final class ConsoleLogger: LoggerProtocol {

    public let subSystem: String
	public var filter: FilterProtocol

	private let formatter: LoggerFormatterProtocol
	private let shouldShowLogDetails: Bool

	public init(subSystem: String, configuration: ConsoleConfiguration) {
		self.subSystem = subSystem
		self.formatter = configuration.formatter
		self.filter = configuration.filter
		self.shouldShowLogDetails = configuration.shouldShowLogDetails
	}

	public func log(logLevel: LoggerLevel, category: LogCategoryProtocol, message: () -> String, line: Int, functionName: String, fileName: String) {
		let details: LogMetaData = shouldShowLogDetails ?
			LogMetaData(level: logLevel, category: category, subSystem: subSystem, line: line, functionName: functionName, fileName: fileName) :
			LogMetaData(level: logLevel, category: category, subSystem: subSystem)

		guard filter.canLog(details: details)  else { return }

		let formattedMessage = formatter.format(message: message(), details: details)
		print(formattedMessage)
	}

}

extension ConsoleLogger: ReuseIDProvider {}
