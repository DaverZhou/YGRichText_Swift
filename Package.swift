// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let YGRichTextVersion = "1.1.0"

let package = Package(
    name: "YGRichText_Swift",
    platforms: [.iOS(.v10)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "YGRichText_Swift",
            targets: ["YGRichText_Swift"]),
    ]

    
)
