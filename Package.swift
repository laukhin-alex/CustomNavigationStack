// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomNavigationStack",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "CustomNavigationStack",
            targets: ["CustomNavigationStack"]),
    ],
    dependencies: [
            .package(url: "https://github.com/laukhin-alex/CustomNavigationStack.git", from: "1.0.2")
        ],
    targets: [
        .target(
            name: "CustomNavigationStack",
            path: "Sources/CustomNavigationStack"
        ),
        .target(
            name: "Example",
            path: "Example/CustomNavigationExampleApp"
        ),
    ]
)
