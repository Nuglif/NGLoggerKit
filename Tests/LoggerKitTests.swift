//
//  LoggerKitTests.swift
//  LoggerKitTests
//
//  Created by Werck, Ayrton on 18-07-03.
//  Copyright (c) 2018 Nuglif. All rights reserved.
//

import XCTest
@testable import NGLoggerKit

class LoggerKitTests: XCTestCase {

    private func curry(_ fn: @escaping (Bool, LoggerLevel) -> FilterProtocol) -> (Bool) -> (LoggerLevel) -> FilterProtocol {
        return { isStrict in
            return { level in
                return fn(isStrict, level)
            }
        }
    }

    lazy var filterStrict = curry(makeFilter)(true)
    lazy var filterNotStrict = curry(makeFilter)(false)

    private struct TestCategory: LogCategoryProtocol {
        var name: String {
            return "TestCategory"
        }
    }

    func test_FilterLevel_strict() {
        XCTAssertEqual(filterStrict(.info).canLog(details: meta(.info), message: ""), true)
        XCTAssertEqual(filterStrict(.info).canLog(details: meta(.error), message: ""), false)
        XCTAssertEqual(filterStrict(.verbose).canLog(details: meta(.error), message: ""), false)
        XCTAssertEqual(filterStrict(.custom("Jimmy")).canLog(details: meta(.custom("yoyo")), message: ""), false)
        XCTAssertEqual(filterStrict(.custom("Jimmy")).canLog(details: meta(.custom("Jimmy")), message: ""), true)
    }

    func test_FilterLevel_not_strict() {
        XCTAssertEqual(filterNotStrict(.info).canLog(details: meta(.info), message: ""), true)
        XCTAssertEqual(filterNotStrict(.info).canLog(details: meta(.error), message: ""), true)
        XCTAssertEqual(filterNotStrict(.error).canLog(details: meta(.verbose), message: ""), false)
        XCTAssertEqual(filterNotStrict(.custom("Jimmy")).canLog(details: meta(.custom("yoyo")), message: ""), true)

    }

    private func makeFilter(isStrict: Bool, with level: LoggerLevel) -> FilterProtocol {
        return FilterLevel(minLevel: level, isStrict: isStrict)
    }

    private func meta(_ withLevel: LoggerLevel) -> LogMetaData {
        return LogMetaData(level: withLevel, category: TestCategory(), subSystem: "meta tests")
    }
}
