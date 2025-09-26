// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EitriContracts",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "EitriContracts",
            targets: ["EitriContracts", "EitriContractsDependencies"]),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "EitriContractsDependencies",
            dependencies: [
                
            ]),

        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .binaryTarget(
            name: "EitriContracts", 
            path: "EitriContracts.xcframework"
        )
    ]
)
