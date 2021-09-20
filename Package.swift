// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "CNChart",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "CNChart",
                 targets: ["CNChart"])
    ],
    targets: [
        .target(name: "CNChart",
                path: "CNChart/Classes")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
