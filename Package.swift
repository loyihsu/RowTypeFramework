// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RowTypeFramework",
    products: [
        .library(name: "RowTypeFramework", targets: ["RowTypeFramework"]),
        .library(name: "RowTypeTableView", targets: ["RowTypeFramework", "RowTypeTableView"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "RowTypeFramework", dependencies: []),
        .target(name: "RowTypeTableView", dependencies: ["RowTypeFramework"]),
        .testTarget(name: "RowTypeFrameworkTests", dependencies: ["RowTypeFramework"]),
    ]
)
