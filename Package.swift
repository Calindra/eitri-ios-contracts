// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EitriIOSContracts",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "EitriIOSContracts",
            targets: ["EitriIOSContracts"]
        )
    ],
    targets: [
        .target(
            name: "EitriIOSContracts"
        ),
        .testTarget(
            name: "EitriIOSContractsTests",
            dependencies: ["EitriIOSContracts"]
        )
    ]
)
