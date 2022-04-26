//
//  LoggerExtremeTests.swift
//  NGLoggerKit
//
//  Created by Lision, Alexandre (Ordinateur) on 2022-03-28.
//  Copyright © 2022 Nuglif. All rights reserved.
//

import XCTest
import NGLoggerKit

final class LoggerExtremeTests: XCTestCase {

    enum LoggerTestsCategory: LogCategoryProtocol {
        var name: String {
            return String(describing: self)
        }

        case test
    }

    func configurationLogger() -> FileConfiguration? {
        let fileName = "ReplicaLoggerTests"
        let filter = FilterLevel(minLevel: .verbose, isStrict: false)
        let autorotateConfiguration = FileConfiguration.AutoRotateConfiguration(maximumFileSize: 1000,
                                                                                maximumNumberOfLogFiles: 1,
                                                                                logLevel: .verbose,
                                                                                rotationTimeInSeconds: 1)
        let fileConf = FileConfiguration(fileName: "Logs/\(fileName)",
                                         formatter: ELFFormatter(), filter: filter,
                                         shouldShowLogDetails: true,
                                         autorotateConfiguration: autorotateConfiguration)

        return fileConf
    }

    func testStressXCGFileLoggerWithMultipleThreadAndForceRotations() {
        guard let fileconf = configurationLogger() else { return }

        let fileLogger = XCGFileLogger(subSystem: "LoggerTests", configuration: fileconf)
        let fileLogger2 = XCGFileLogger(subSystem: "LoggerTests2", configuration: fileconf)
        let fileLogger3 = XCGFileLogger(subSystem: "LoggerTests3", configuration: fileconf)
        let fileLogger4 = XCGFileLogger(subSystem: "LoggerTests4", configuration: fileconf)
        let fileLogger5 = XCGFileLogger(subSystem: "LoggerTests5", configuration: fileconf)
        let fileLogger6 = XCGFileLogger(subSystem: "LoggerTests6", configuration: fileconf)
        let fileLogger7 = XCGFileLogger(subSystem: "LoggerTests7", configuration: fileconf)

        let queue = DispatchQueue(label: "randomQueue", qos: .utility, attributes: .concurrent)

        for i in 0...1000 {
            queue.async {
                let message = "1: message number \(i)"
                fileLogger.info(LoggerTestsCategory.test, message)
            }
            queue.async {
                let message = "2: message number \(i)"
                fileLogger2.info(LoggerTestsCategory.test, message)
            }
            queue.async {
                let message = "3: message number \(i)"
                fileLogger3.info(LoggerTestsCategory.test, message)
            }
            queue.async {
                let message = "4: message number \(i)"
                fileLogger4.info(LoggerTestsCategory.test, message)
            }
            queue.async {
                let message = "5: message number \(i)"
                fileLogger5.info(LoggerTestsCategory.test, message)
            }
            queue.async {
                let message = "6: message number \(i)"
                fileLogger6.info(LoggerTestsCategory.test, message)
            }
            queue.async {
                let message = "7: message number \(i)"
                fileLogger7.info(LoggerTestsCategory.test, message)
            }
            Thread.sleep(forTimeInterval: 0.01)
        }

        Thread.sleep(forTimeInterval: 10)
    }
}


