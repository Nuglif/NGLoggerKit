//
//  LoggerFactory.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-04.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public final class LoggerFactory {

    private var loggerAssembly: [String: (LoggerConfigurationProtocol) -> LoggerProtocol?]

    public init() {
        loggerAssembly = [:]
    }

    public func makeLogger<T: ReuseIDProvider>(for type: T.Type, with configuration: LoggerConfigurationProtocol) -> LoggerProtocol? {
        return loggerAssembly[type.staticReuseID]?(configuration)
    }

    public func registerLogger<T: ReuseIDProvider>(type: T.Type, factory: @escaping (LoggerConfigurationProtocol) -> LoggerProtocol?) {
        loggerAssembly[type.staticReuseID] = factory
    }

    public func registeredLogger() -> [String] {
        return loggerAssembly.keys.map { $0 }
    }
}
