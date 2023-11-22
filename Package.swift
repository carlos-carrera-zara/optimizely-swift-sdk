// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Optimizely",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Optimizely",
                 targets: ["Optimizely"])
    ],
    targets: [
        .target(name: "Optimizely", path: "Sources"),
        .testTarget(name: "OptimizelyTests-iOS", dependencies: [
            .target(name: "Optimizely")
        ])
    ],
    swiftLanguageVersions: [.v5]
)
