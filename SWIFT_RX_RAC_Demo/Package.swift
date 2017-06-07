//
//  Package.swift
//  SWIFT_RX_RAC_Demo
//
//  Created by chenyihang on 2017/5/27.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "SWIFT_RX_RAC_Demo",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/ReactiveX/RxSwift.git", majorVersion: 3)
    ]
)
