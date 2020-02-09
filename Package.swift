// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Trias",
    platforms: [
        .iOS(.v10), .macOS(.v10_12), .watchOS(.v3), .tvOS(.v10)
    ],
    products: [
        .library(
            name: "Trias",
            targets: ["Trias"]),
    ],
    dependencies: [
        .package(url: "https://github.com/MaxDesiatov/XMLCoder.git", from: "0.9.0"),
    ],
    targets: [
        .target(
            name: "Trias",
            dependencies: ["XMLCoder"]),
        .testTarget(
            name: "TriasTests",
            dependencies: ["Trias"]),
    ]
)
