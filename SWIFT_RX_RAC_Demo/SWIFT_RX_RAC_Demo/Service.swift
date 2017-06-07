//
//  Service.swift
//  SWIFT_RX_RAC_Demo
//
//  Created by chenyihang on 2017/6/6.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ValidationService {

    static let shared = ValidationService()
    
    private init(){}
    
    let minCharactersCount = 6
    
    func validateUsername(_ username: String) -> Observable<Result> {
        
        if username.characters.count == 0 {
            return .just(.empty)
            
        }
        
        if username.characters.count < minCharactersCount {
            
            return .just(.failed(message: "号码长度至少6个字符"))
        }
        
        if usernameValid(username) {
            return .just(.failed(message: "账户已存在"))
        }
        
        return .just(.ok(message:"用户名可用"))
    }
    
    
    func validatePassword(_ password: String) -> Result {
        if password.characters.count == 0 {
            return .empty
        }
        
        if password.characters.count < minCharactersCount {
            return .failed(message: "密码长度至少6个字符")
        }
        
        return .ok(message: "密码可用")
    }

    
    func validateRepeatedPassword(_ password: String, repeatedPasswordword: String) -> Result {
        if repeatedPasswordword.characters.count == 0 {
            return .empty
        }
        
        if repeatedPasswordword == password {
            return .ok(message: "密码可用")
        }
        
        return .failed(message: "两次密码不一样")
    }
    
    func register(_ username: String, password: String) -> Observable<Result> {
        let userDic = [username: password]
        
        if usernameValid(username) {
            return .just(.failed(message:"用户已存在"))
            
        }
        
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        
        if (userDic as NSDictionary).write(toFile: filePath, atomically: true) {
            return .just(.ok(message: "注册成功"))
        }
        return .just(.failed(message: "注册失败"))
    }
    
    //Observable.just
    func usernameValid(_ username: String) -> Bool {
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        
        let usernameArray = userDic!.allKeys as! Array<String>
        
        
        if usernameArray.contains(username) {
            return true
        }else{
            return false
            
        }
        
    }
    
    func loginUsernameValid(_ username: String) -> Observable<Result> {
        
        if username.characters.count == 0  {
            return .just(.empty)
        }
        
        if usernameValid(username) {
            return .just(.ok(message:"用户名可用"))
        }
        
        return .just(.failed(message: "用户名不存在"))
        
    }
    
    
    func login(_ username: String, password: String) -> Observable<Result> {
        
        let filePath = NSHomeDirectory() + "/Documents/users.plist"
        let userDic = NSDictionary(contentsOfFile: filePath)
        
        if let userPass = userDic?.object(forKey: username) as? String {
            
            if userPass == password {
                return .just(.ok(message: "登录成功"))
            }
        }
        return .just(.failed(message: "密码错误"))
    }
    
    
    
}

class SearchService {
    static let shared = SearchService()
    
    private init(){}
    
    func getHeros() -> Observable<[Hero]> {
        let herosString = Bundle.main.path(forResource: "heros", ofType: "plist")
        //类型转换
        let heroArray = NSArray(contentsOfFile: herosString!) as! Array<[String: String]>
        
        var heros = [Hero]()
        
        for heroDic in heroArray{
            
             let hero = Hero(name: heroDic["name"]!, desc: heroDic["intro"]!, icon: heroDic["icon"]!)
            heros.append(hero)
        
        }
        
        return Observable.just(heros).observeOn(MainScheduler.instance)
        
    }
    
    
    func getHeros(withname name: String) -> Observable<[Hero]> {
        if name == "" {
            return getHeros()
        }
        
        let heroString = Bundle.main.path(forResource: "heros", ofType: "plist")
        
        let herosArray = NSArray(contentsOfFile: heroString! ) as! Array<[String:String]>
        
        var heros = [Hero]()
        
        for heroDic in herosArray {
            
            if heroDic["name"]!.contains(name) ||  heroDic["intro"]!.contains(name) {
                let hero = Hero(name: heroDic["name"]!, desc: heroDic["intro"]!, icon: heroDic["icon"]!)
                heros.append(hero)
            }
        }
        
        
        return Observable.just(heros).observeOn(MainScheduler.instance)
        
    }

    
}
