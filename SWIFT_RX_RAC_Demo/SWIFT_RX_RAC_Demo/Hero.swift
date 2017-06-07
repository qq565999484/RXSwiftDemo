//
//  Hero.swift
//  SWIFT_RX_RAC_Demo
//
//  Created by chenyihang on 2017/6/6.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import Foundation

class Hero: NSObject {
    
    var name: String
    var desc: String
    var icon: String
    init(name: String,desc: String,icon: String) {
        self.name = name
        self.desc = desc
        self.icon = icon
    }
}
