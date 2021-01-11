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

    lazy var filterStrict = curry(makeFilter)(true)
    lazy var filterNotStrict = curry(makeFilter)(false)

    func test_FilterLevel_strict() {
        XCTAssertEqual(filterStrict(.info).canLog(details: meta(.info)), true)
        XCTAssertEqual(filterStrict(.info).canLog(details: meta(.error)), false)
        XCTAssertEqual(filterStrict(.verbose).canLog(details: meta(.error)), false)
        XCTAssertEqual(filterStrict(.custom("Jimmy")).canLog(details: meta(.custom("yoyo"))), false)
        XCTAssertEqual(filterStrict(.custom("Jimmy")).canLog(details: meta(.custom("Jimmy"))), true)
    }

    func test_FilterLevel_not_strict() {
        XCTAssertEqual(filterNotStrict(.info).canLog(details: meta(.info)), true)
        XCTAssertEqual(filterNotStrict(.info).canLog(details: meta(.error)), true)
        XCTAssertEqual(filterNotStrict(.error).canLog(details: meta(.verbose)), false)
        XCTAssertEqual(filterNotStrict(.custom("Jimmy")).canLog(details: meta(.custom("yoyo"))), true)
    }

    func test_Logger_thread_safety() {
        let builder = LoggerBuilder()
        let subSystem = "test"
        let logger = Logger(subSystem: subSystem)
        let expectation = XCTestExpectation(description: "Dispatch finished")
        let limit = 1000

        builder.set(configuration: nil, withMode: .oslog)
        builder.build(subSystem: subSystem)
            .forEach(logger.add)

        for i in 1 ... limit {
            DispatchQueue.global().async {
                let category = NamedCategory(name: "category-\(i)")

                logger.info(category, "--- thread testing ---")

                if i == limit {
                    expectation.fulfill()
                }
            }
        }

        wait(for: [expectation], timeout: 5)
    }
}

// MARK: - LoggerKitTests (private)
private extension LoggerKitTests {

    struct TestCategory: LogCategoryProtocol {
        var name: String { "TestCategory" }
    }

    struct NamedCategory: LogCategoryProtocol {
        let name: String
    }

    func curry(_ fn: @escaping (Bool, LoggerLevel) -> FilterProtocol) -> (Bool) -> (LoggerLevel) -> FilterProtocol {
        return { isStrict in
            return { level in
                return fn(isStrict, level)
            }
        }
    }

    func makeFilter(isStrict: Bool, with level: LoggerLevel) -> FilterProtocol {
        return FilterLevel(minLevel: level, isStrict: isStrict)
    }

    func meta(_ withLevel: LoggerLevel) -> LogMetaData {
        return LogMetaData(level: withLevel, category: TestCategory(), subSystem: "meta tests")
    }
}
