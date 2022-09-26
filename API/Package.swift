// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "API",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "API",
            targets: ["API"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/apollographql/apollo-ios.git",
            .upToNextMajor(from: "0.5.0") // or `.upToNextMinor
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "API",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios")
            ],
            resources: [
                .process("GraphQL/schema.json"),
                .process("GraphQL/LaunchesQuery.graphql"),
                .process("GraphQL/LaunchDetailQuery.graphql")]),
        .testTarget(
            name: "APITests",
            dependencies: ["API"])
    ]
)
