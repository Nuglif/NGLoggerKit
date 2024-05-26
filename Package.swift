// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NGLoggerKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "NGLoggerKit",
            targets: ["NGLoggerKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/DaveWoodCom/XCGLogger", .branch("main"))
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
