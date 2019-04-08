// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "IBOutletRewriter",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/apple/swift-syntax.git", .exact("0.50000.0")),
        .package(url: "https://github.com/Carthage/Commandant.git", from: "0.8.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "IBOutletRewriter",
            dependencies: ["IBOutletRewriterCore", "Commandant"]),
        .target(
            name: "IBOutletRewriterCore",
            dependencies: ["SwiftSyntax"]),
        .testTarget(
            name: "IBOutletRewriterTests",
            dependencies: ["IBOutletRewriter"]),
        .testTarget(
            name: "IBOutletRewriterCoreTests",
            dependencies: ["IBOutletRewriterCore", "SwiftSyntax"]),
    ]
)
