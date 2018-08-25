// swift-tools-version:4.0
// Managed by ice

import PackageDescription

let package = Package(
    name: "TyperTool",
    products: [
        .executable(name: "typer", targets: ["TyperTool"])
    ],
    dependencies: [
        .package(url: "https://github.com/Samasaur1/Typer.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "TyperTool", dependencies: ["Typer"]),
    ]
)
