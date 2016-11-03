import PackageDescription

let package = Package(
    name: "JohoFeed",
    dependencies: [
    	.Package(url: "https://github.com/hkellaway/Gloss.git", majorVersion: 1, minor: 1)
    ]
)
