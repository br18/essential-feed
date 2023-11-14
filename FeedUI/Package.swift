// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeedUI",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FeedUI",
            targets: ["FeedUI"]),
    ],
    dependencies: [
          .package(name: "SharedUI", path: "../SharedUI"),
          .package(name: "FeedPresentation", path: "../FeedPresentation"),
          .package(name: "SharedPresentation", path: "../SharedPresentation"),
          .package(name: "SnapshotTesting", path: "../SnapshotTesting")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FeedUI",
            dependencies: ["SharedUI", "FeedPresentation", "SharedPresentation"]),
        .testTarget(
            name: "FeedUITests",
            dependencies: ["FeedUI", "SnapshotTesting"]),
    ]
)
