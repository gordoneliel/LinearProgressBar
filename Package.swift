// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "LinearProgressBar",
    platforms: [
        .iOS(.v12),
    ],
    products: [
        .library(
            name: "LinearProgressBar",
            targets: ["LinearProgressBar"]),
    ],
    dependencies: [
        // no dependencies
    ],
    targets: [
        .target(
            name: "LinearProgressBar",
            dependencies: []),
        .testTarget(
            name: "LinearProgressBarTests",
            dependencies: ["LinearProgressBar"]),
    ]
)
