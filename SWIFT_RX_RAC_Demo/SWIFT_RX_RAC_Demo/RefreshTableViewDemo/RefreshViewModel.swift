//
//  RefreshViewModel.swift
//  SWIFT_RX_RAC_Demo
//
//  Created by chenyihang on 2017/6/8.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct RefreshModel {
    var name:String
    
    
    init(_ name:String) {
        self.name = name
        
    }
}

struct RefreshViewModel {
    //这里定义的都应该是let常亮.
    
    let data = Driver.just(
        [
            RefreshModel("大写的懵逼1"),
            RefreshModel("大写的懵逼2"),
            RefreshModel("大写的懵逼3"),
            RefreshModel("大写的懵逼4"),
            RefreshModel("大写的懵逼5"),
            RefreshModel("大写的懵逼6"),
        ]
    
    )
    init() {
        
    }
    
}
