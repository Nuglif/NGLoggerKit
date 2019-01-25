//
//  XCGFileLogger.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-12.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import XCGLogger

public final class XCGFileLogger: LoggerProtocol {
	public let subSystem: String
    public static let defaultDispatchQueue = DispatchQueue(label: "com.loggerKit.XCGFileLogger", qos: .background, attributes: [], autoreleaseFrequency: .inherit, target: nil)

    public var filter: LoggerKit.FilterProtocol

    let destinationIdentifier: String = "XCGFILE_LOGGER_DESTINATION"

	private let xclogger: XCGLogger
	private let formatter: LoggerFormatterProtocol
	private let shouldShowLogDetails: Bool

	public init(subSystem: String,
		 configuration: FileConfiguration,
		 queue: DispatchQueue = defaultDispatchQueue) {
		self.subSystem = subSystem
		self.formatter = configuration.formatter
		self.shouldShowLogDetails = configuration.shouldShowLogDetails
		self.filter = configuration.filter

		self.xclogger = XCGLogger(identifier: XCGFileLogger.staticReuseID, includeDefaultDestinations: false)
		self.xclogger.outputLevel = .none
		createPathIfNeeded(configuration.file)
		configure(with: configuration, and: queue)
	}

	public func log(logLevel: LoggerLevel, category: LogCategoryProtocol, message: @autoclosure () -> String, line: Int, functionName: String, fileName: String) {
		let details: LogMetaData = shouldShowLogDetails ?
			LogMetaData(level: logLevel, category: category, subSystem: subSystem, line: line, functionName: String(describing: functionName), fileName: String(describing: fileName)) :
			LogMetaData(level: logLevel, category: category, subSystem: subSystem)
		guard filter.canLog(details: details, message: message)  else { return }

		let formattedMessage = formatter.format(message: message(), details: details)
		xclogger.logln(formattedMessage)
	}

	private func configure(with configuration: FileConfiguration, and queue: DispatchQueue) {
        xclogger.remove(destinationWithIdentifier: destinationIdentifier)
		let fileDestination: FileDestination = destinationFor(configuration)

		fileDestination.showFileName = false
		fileDestination.showLineNumber = false
		fileDestination.showFunctionName = false
		fileDestination.showDate = false
		fileDestination.showLevel = false
		fileDestination.logQueue = queue
		xclogger.add(destination: fileDestination)
	}

	private func destinationFor(_ configuration: FileConfiguration) -> FileDestination {
		if let autoRotateConfiguration = configuration.autorotateConfiguration {
			return AutoRotatingFileDestination(owner: xclogger,
											   writeToFile: configuration.file,
											   identifier: destinationIdentifier,
											   shouldAppend: true,
											   maxFileSize: UInt64(autoRotateConfiguration.maximumFileSize),
											   maxTimeInterval: TimeInterval(autoRotateConfiguration.rotationTimeInSeconds),
											   targetMaxLogFiles: UInt8(autoRotateConfiguration.maximumNumberOfLogFiles))
		}
		return FileDestination(owner: xclogger,
							   writeToFile: configuration.file,
							   identifier: destinationIdentifier,
							   shouldAppend: true)

	}

	private func createPathIfNeeded(_ fileUrl: URL) {
		do {
			let fileUrlDirectoryURL = fileUrl.deletingLastPathComponent()
			try FileManager.default.createDirectory(atPath: fileUrlDirectoryURL.path,
													withIntermediateDirectories: true,
													attributes: nil)
		} catch {
			print("XCGFileLogger failed to create directory for logs at: \(fileUrl.path) with error: \(error.localizedDescription)")
		}
	}
}

extension XCGFileLogger: FileLoggerProtocol {

    public func logFileURLS() -> [URL] {
		let urls = xclogger.destinations
			.compactMap { ($0 as? FileDestination)?.writeToFileURL }
		let archivedUrls = xclogger.destinations
			.compactMap { ($0 as? AutoRotatingFileDestination)?.archivedFileURLs() }
			.flatMap { $0 }

		return urls + archivedUrls
	}

}

extension XCGFileLogger: ReuseIDProvider {}
