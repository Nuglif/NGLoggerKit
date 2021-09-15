// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NGLoggerKit",
    platforms: [.iOS(.v10)],
    products: [
        .library(
            name: "NGLoggerKit",
            targets: ["NGLoggerKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/DaveWoodCom/XCGLogger", from: "7.0.0"),
    ],
    targets: [
        .target(
            name: "NGLoggerKit",
            dependencies: [
                .product(name: "XCGLogger", package: "XCGLogger"),
                .product(name: "ObjcExceptionBridging", package: "XCGLogger")
            ],
            path: "Sources",
            publicHeadersPath: ".",
            cSettings: [.headerSearchPath("ObjC")]),
        .testTarget(
            name: "NGLoggerKitTests",
            dependencies: ["NGLoggerKit"],
            path: "Tests",
            exclude: ["LoggerKitTests.m"])
    ]
)
