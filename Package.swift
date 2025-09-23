// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EitriContracts",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "EitriContracts",
            targets: ["EitriContracts"]
        )
    ],
    targets: [
        .target(
            name: "EitriContracts"
        ),
        .testTarget(
            name: "EitriContractsTests",
            dependencies: ["EitriContracts"]
        )
    ]
)
