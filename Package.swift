// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "NumberedLabel",
	platforms: [.iOS(.v17)],
	products: [
		.library(name: "NumberedLabel", targets: ["NumberedLabel"]),
	],
	targets: [
		.target(name: "NumberedLabel"),
	]
)
