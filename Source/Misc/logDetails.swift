//
//  logDetails.swift
//  LoggerKit
//
//  Created by Werck, Ayrton on 18-07-09.
//  Copyright © 2018 Nuglif. All rights reserved.
//

/// Helper to gather basic information about the context in which the method is called
///
/// - Parameters:
///   - line: Line of the file where the method is called
///   - function: Name of the function where the method is called
///   - file: Name of the file where the method is called
/// - Returns: triple with line/functioname/filename
public func ld(_ line: Int = #line, _ function: String = #function, file: String = #file) -> (line: Int, functionName: String, fileName: String) {
    return (line, function, file)
}
