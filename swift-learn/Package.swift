// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Test",
    products: [
        .library(
            name: "Test",
            targets: ["Test"]),
        .library(
            name: "PythonKit",
            targets: ["PythonKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pvieito/PythonKit.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Test",
            dependencies: []),
        .target(
            name: "PythonKit",
            dependencies: ["Sources/PythonKit"]),
        .testTarget(
            name: "TestTests",
            dependencies: ["Test"]),
    ]
)
