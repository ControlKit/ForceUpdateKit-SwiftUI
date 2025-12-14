// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ForceUpdateKit-SwiftUI",
    platforms: [
         .iOS(.v15)
    ],
    products: [
        .library(
            name: "ForceUpdateKit-SwiftUI",
            targets: ["ForceUpdateKit-SwiftUI"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ControlKit/ControlKitBase.git",
            branch: "main"
        )
    ],
    targets: [
        .target(
            name: "ForceUpdateKit-SwiftUI",
            dependencies: ["ControlKitBase"],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "ForceUpdateKit-SwiftUITests",
            dependencies: ["ForceUpdateKit-SwiftUI"]),
    ]
)
