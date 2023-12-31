// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SharedUI",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SharedUI",
            targets: ["SharedUI"]),
    ],
    dependencies: [
          .package(name: "SharedPresentation", path: "../SharedPresentation"),
          .package(name: "SharedTestHelpers", path: "../SharedTestHelpers"),
          .package(name: "SnapshotTesting", path: "../SnapshotTesting")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SharedUI",
            dependencies: ["SharedPresentation"]),
        .testTarget(
            name: "SharedUITests",
            dependencies: ["SharedUI", "SharedTestHelpers", "SnapshotTesting"]),
    ]
)
