import PackageDescription

let package = Package(
    name: "KituraFlock",
    dependencies: [
        .Package(url: "../Flock", majorVersion: 0, minor: 0)
    ]
)
