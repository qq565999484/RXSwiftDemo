//
//  LoginViewModel.swift
//  SWIFT_RX_RAC_Demo
//
//  Created by chenyihang on 2017/6/6.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class LoginViewModel: NSObject {

    //output:
    
    let usernameUsable: Driver<Result>
    let loginButtonEnabled: Driver<Bool>
    let loginResult: Driver<Result>
    init(input: (username: Driver<String>,passwd: Driver<String>,loginTaps: Driver<Void>),service: ValidationService){
        usernameUsable = input.username
            .flatMapLatest{ username in
                return service.loginUsernameValid(username)
                .asDriver(onErrorJustReturn: .failed(message: "连接server失败"))
        }
        
        let usernameAndPassword = Driver.combineLatest(input.username,input.passwd){
            ($0,$1)
        }
        
        loginResult = input.loginTaps.withLatestFrom(usernameAndPassword).flatMapLatest{(username,password) in
            return service.login(username, password: password)
            .asDriver(onErrorJustReturn: .failed(message: "连接server失败"))
        }
        
        loginButtonEnabled = input.passwd
            .map{ $0.characters.count > 0}
            .asDriver()
        
    }
    
}
