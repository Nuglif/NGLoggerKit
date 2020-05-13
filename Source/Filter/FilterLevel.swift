//
//  FilterLevel.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-13.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public struct FilterLevel: FilterProtocol {

    private let minLevel: LoggerLevel
    private let isStrict: Bool

    public init(minLevel: LoggerLevel, isStrict: Bool) {
        self.minLevel = minLevel
        self.isStrict = isStrict
    }

    public func canLog(details: LogMetaData, message: @autoclosure () -> String) -> Bool {
        return isStrict ? details.level == minLevel : details.level >= minLevel
    }
}
