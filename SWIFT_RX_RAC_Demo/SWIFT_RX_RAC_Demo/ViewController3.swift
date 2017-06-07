
//
//  ViewController3.swift
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
//              | | :  `- \`.;`\ _ /`;.`/ - ` : | |
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
//  Created by chenyihang on 2017/6/6.
//  Copyright © 2017年 chenyihang. All rights reserved.
//
import CoreLocation
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

import UIKit


//给UILabel 添加 rx.观察者

private extension Reactive where Base: UILabel
{
    
    var coordinates: UIBindingObserver<Base, CLLocationCoordinate2D>
    {
        return UIBindingObserver(UIElement: base){ label,location in
            label.text = "Lat: \(location.latitude)\nLon: \(location.longitude)"
        }
    }

}



class ViewController3: UIViewController {
    
    @IBOutlet weak private var noGeolocationView: UIView!
    @IBOutlet weak private var button: UIButton!
    @IBOutlet weak private var button2: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let disposeBag = DisposeBag()
        
        view.addSubview(noGeolocationView)
        
        
        let geolocationService = GeolocationService.instance
        
        geolocationService.authorized.drive(noGeolocationView.rx.isHidden)
        .disposed(by: disposeBag)
        
        geolocationService.location.drive(label.rx.coordinates)
        .disposed(by: disposeBag)
        
        button2.addTarget(self, action: #selector(ViewController3.xxx), for: .touchUpInside)


        
     
        button2.rx.tap
            .bind { [weak self] in
                self?.openAppPreferences()
            }
            .disposed(by: disposeBag)
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func xxx() {
        print("xxx")
    }
    
    private func openAppPreferences() {
        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
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
