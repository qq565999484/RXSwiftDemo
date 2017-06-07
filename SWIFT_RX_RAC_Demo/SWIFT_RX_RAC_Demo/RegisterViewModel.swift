//
//  RegisterViewModel.swift
//  SWIFT_RX_RAC_Demo
//
//  Created by chenyihang on 2017/6/6.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import UIKit

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif


//应该每次点击注册时候都需要去验证用户名 是否存在

class RegisterViewModel {
    
    //input:
    let username = Variable<String>("")
    let password = Variable<String>("")
    let repeartPassword = Variable<String>("")
    let registerTaps = PublishSubject<Void>()
    
    //output:
    let usernameUsable: Observable<Result>
    
    let passwordUsable: Observable<Result>
    let repeatPasswordUsable: Observable<Result>
    let registerButtonEnabled: Observable<Bool>
    let registerResult: Observable<Result>
    
    init() {
        
    
        let service = ValidationService.shared
        //检测username是否符合要求 是否存在
        usernameUsable = username.asObservable()
            .flatMapLatest{ username in
            return service.validateUsername(username)
                .observeOn(MainScheduler.instance)
                .catchErrorJustReturn(.failed(message:"username检测出错"))
        
            }.shareReplay(1)
   
        
        //只检测密码是否符合要求
        passwordUsable = password.asObservable()
            .map{ password in
        
                return service.validatePassword(password)
                //shareReplay 让多次订阅信号信号只执行一次
            }.shareReplay(1)
        
        repeatPasswordUsable = Observable.combineLatest(password.asObservable(),repeartPassword.asObservable()){
                return service.validateRepeatedPassword($0, repeatedPasswordword: $1)
            }.shareReplay(1)
        
        registerButtonEnabled = Observable.combineLatest(usernameUsable,passwordUsable,repeatPasswordUsable){
            (username,password,repeartPassword) in
            username.isValid && password.isValid && repeartPassword.isValid
            
        }.distinctUntilChanged()
        .shareReplay(1)
        
        
        //封装成元祖
        
        let usernameAndPassword = Observable.combineLatest(username.asObservable(),password.asObservable()){
            ($0,$1)
        }
        
        registerResult = registerTaps.asObservable().withLatestFrom(usernameAndPassword)
            .flatMapLatest{(username,password) in
                return service.register(username, password: password)
                .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message:"注册出错"))
        }.shareReplay(1)
    }
    
    
    
}
