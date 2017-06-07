//
//  ViewController2.swift
//  SWIFT_RX_RAC_Demo
//    -----------------------分割线来袭-----------------------
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                           O\  =  /O
//                        ____/`---'\____
//                      .'  \\|     |//  `.
//                     /  \\|||  :  |||//  \
//                    /  _||||| -:- |||||-  \
//                    |   | \\\  -  /// |   |
//                    | \_|  ''\---/''  |   |
//                    \  .-\__  `-`  ___/-. /
//                   ___`. .'  /--.--\  `. . __
//                ."" '<  `.___\_<|>_/___.'  >'"".
//              | | :  `- \`.;`\ 粗 /`;.`/ - ` : | |
//              \  \ `-.   \_ __\ /__ _/   .-` /  /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？
//    -----------------------分割线来袭-----------------------
//
//  Created by chenyihang on 2017/5/27.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import UIKit
//import Moya
//import Alamofire
//import ObjectMapper
import RxCocoa
import RxSwift

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let error = NSError(domain: "Test", code: -1, userInfo: nil)
        
        let erroredSequence = Observable<Int>.error(error)
        
        _ = erroredSequence.subscribe{ event in print(event)}
        
        
        let _: Observable<Int> = Observable.deferred{
        
            print("creating")
            return Observable.create{     observer in
            
                 observer.onNext(0)
                 observer.onNext(1)
                 observer.onNext(2)
                
                return Disposables.create {
                    
                }
                
                

            }
        
        }
        
        
        
        
        
        let myJust = { (singleElement:Int) -> Observable<Int> in
            
            return Observable.create{ observer in
                observer.onNext(singleElement)
                observer.onCompleted()
                return Disposables.create {
                    
                }
                
                
            }
            
        
        }
        
        _ = myJust(5).subscribe{ event in
                print(event)
        }
        
        
        
        let URL = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/d8bb95982be8a11a2308e779bb9a9707ebe42ede/sample_json"
        
        
//        Alamofire.request(URL).response { (response) in
//            print(response)
//        
//            
//        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
