//
//  FileConfiguration.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-12.
//  Copyright © 2018 Nuglif. All rights reserved.
//

import Foundation

public struct FileConfiguration: LoggerConfigurationProtocol {

	public struct AutoRotateConfiguration {
		let maximumFileSize: Int
		let maximumNumberOfLogFiles: Int
		let logLevel: LoggerLevel
		let rotationTimeInSeconds: Int

        public init(maximumFileSize: Int, maximumNumberOfLogFiles: Int, logLevel: LoggerLevel, rotationTimeInSeconds: Int) {
            self.maximumFileSize = maximumFileSize
            self.maximumNumberOfLogFiles = maximumNumberOfLogFiles
            self.logLevel = logLevel
            self.rotationTimeInSeconds = rotationTimeInSeconds
        }
	}

	public let formatter: LoggerFormatterProtocol
    public let shouldShowLogDetails: Bool
    public let file: URL
	public let filter: FilterProtocol
	public let autorotateConfiguration: AutoRotateConfiguration?

	public var autoRotateFile: Bool { autorotateConfiguration != nil }

	public init?(fileName: String,
		  formatter: LoggerFormatterProtocol,
		  filter: FilterProtocol,
		  shouldShowLogDetails: Bool,
		  autorotateConfiguration: AutoRotateConfiguration?) {
		let cacheDirectoryUrl: URL? = {
			let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
			return urls.last
		}()
		guard let cacheDirectory = cacheDirectoryUrl else {
			return nil
		}
		self.file = cacheDirectory.appendingPathComponent("\(fileName).log")
		self.formatter = formatter
		self.shouldShowLogDetails = shouldShowLogDetails
		self.filter = filter
		self.autorotateConfiguration = autorotateConfiguration
	}
}
