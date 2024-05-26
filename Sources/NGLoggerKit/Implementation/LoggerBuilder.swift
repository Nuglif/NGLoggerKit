//
//  LoggerBuilder.swift
//
//
//  Created by Werck, Ayrton on 18-07-10.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public final class LoggerBuilder {

	typealias BuildLoggers = (String) -> [LoggerProtocol]
	typealias BuildLogger = (String) -> LoggerProtocol

	public struct ConsoleLoggerMode: OptionSet {
		public let rawValue: Int

		public init(rawValue: Int) {
			self.rawValue = rawValue
		}

		public static let console = ConsoleLoggerMode(rawValue: 1 << 0)
		public static let oslog = ConsoleLoggerMode(rawValue: 1 << 1)
	}

	private var buildConsoleLoggers: BuildLoggers?
	private var buildFileLogger: BuildLogger?
	private var customLoggers: [LoggerProtocol]?

    public init() {}

	@discardableResult
	public func set(configuration: ConsoleConfiguration?, withMode mode: ConsoleLoggerMode) -> LoggerBuilder {
		self.buildConsoleLoggers = makeConsoleLoggers(mode: mode, suggestedConfiguration: configuration)
		return self
	}

	@discardableResult
	public func set(fileConfiguration: FileConfiguration) -> LoggerBuilder {
		self.buildFileLogger = makeFileLogger(configuration: fileConfiguration)
		return self
	}

	@discardableResult
	public func set(customLoggers: [LoggerProtocol]) -> LoggerBuilder {
		self.customLoggers = customLoggers
		return self
	}

	public func build(subSystem: String) -> [LoggerProtocol] {
		var loggers: [LoggerProtocol] = []
		if let buildConsoleLoggers = buildConsoleLoggers {
			loggers.append(contentsOf: buildConsoleLoggers(subSystem))
		}
		if let buildFileLogger = buildFileLogger {
			loggers.append(buildFileLogger(subSystem))
		}
		if let customLoggers = customLoggers?.filter({ $0.subSystem == subSystem }) {
			loggers.append(contentsOf: customLoggers)
		}
		return loggers
	}

	public func buildDefault(subSystem: String) -> Logger {
        let consoleLoggers = ContiguousArray(makeConsoleLoggers(mode: .oslog, suggestedConfiguration: nil)(subSystem))
		return Logger(subSystem: subSystem, loggers: consoleLoggers)
	}

	private func makeConsoleLoggers(mode: ConsoleLoggerMode, suggestedConfiguration: ConsoleConfiguration?) -> (String) -> [LoggerProtocol] {
		return { (subSystem) -> [LoggerProtocol] in
			var loggers: [LoggerProtocol] = []
			let configuration = suggestedConfiguration ??
                ConsoleConfiguration(formatter: ConsoleFormatter(includeDate: false),
                                     shouldShowLogDetails: false,
                                     filter: FilterLevel(minLevel: .info, isStrict: false))
			if mode.contains(.console) {
				loggers.append(ConsoleLogger(subSystem: subSystem, configuration: configuration))
			}
			if mode.contains(.oslog) {
				loggers.append(OSLogger(subSystem: subSystem, configuration: configuration))
			}
			return loggers
		}
	}

	private func makeFileLogger(configuration: FileConfiguration) -> (String) -> LoggerProtocol {
		return { (subsystem) -> LoggerProtocol in
			print("Logs will be stored at: \(configuration.file)")
			return XCGFileLogger(subSystem: subsystem, configuration: configuration)
		}
	}
}
