// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageCommentsPresentation",
    defaultLocalization: "en",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ImageCommentsPresentation",
            targets: ["ImageCommentsPresentation"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ImageCommentsPresentation"),
        .testTarget(
            name: "ImageCommentsPresentationTests",
            dependencies: ["ImageCommentsPresentation"],
            resources: [.process("Resources")]),
    ]
)
