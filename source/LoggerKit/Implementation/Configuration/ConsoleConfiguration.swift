//
//  ConsoleConfiguration.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-05.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public struct ConsoleConfiguration: LoggerConfigurationProtocol {
    public let formatter: LoggerFormatterProtocol
    public let shouldShowLogDetails: Bool
	public let filter: FilterProtocol

    public init(formatter: LoggerFormatterProtocol, shouldShowLogDetails: Bool, filter: FilterProtocol) {
        self.formatter = formatter
        self.shouldShowLogDetails = shouldShowLogDetails
        self.filter = filter
    }
}
