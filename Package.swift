// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NGLoggerKit",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "NGLoggerKit",
            type: .dynamic,
            targets: ["NGLoggerKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/bmalbuck/XCGLogger", .branch("master"))
    ],
    targets: [
        .target(
            name: "NGLoggerKit",
            dependencies: [
                .product(name: "XCGLogger", package: "XCGLogger")
            ],
            path: "Sources",
            exclude: ["Info.plist"]),
        .testTarget(
            name: "NGLoggerKitTests",
            dependencies: [
                "NGLoggerKit"
            ],
            path: "Tests",
            exclude: ["LoggerKitTests.m",
                      "Info.plist"])
    ]
)
