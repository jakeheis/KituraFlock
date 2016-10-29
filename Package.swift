import PackageDescription

let package = Package(
    name: "KituraFlock",
    dependencies: [
        .Package(url: "https://github.com/jakeheis/Flock", majorVersion: 0, minor: 0)
    ]
)
