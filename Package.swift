// swift-tools-version:5.7
// We're hiding dev, test, and danger dependencies with // dev to make sure they're not fetched by users of this package.
import PackageDescription

let package = Package(
    name: "WeScan",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "WeScan", targets: ["WeScan"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "WeScan",
                resources: [
                    .process("Resources")
                ]),
        .testTarget(
            name: "WeScanTests",
            dependencies: [
                "WeScan"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
