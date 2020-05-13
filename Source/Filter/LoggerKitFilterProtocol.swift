//
//  FilterProtocol.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-13.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

public protocol FilterProtocol {
    func canLog(details: LogMetaData, message: @autoclosure () -> String) -> Bool
}
