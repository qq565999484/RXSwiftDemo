//
//  RefreshViewController.swift
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
//  Created by chenyihang on 2017/6/8.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
    import RxDataSources
#endif

class RefreshViewController: UIViewController {

    let refreshViewModel = RefreshViewModel()
    
    let disposeBag = DisposeBag()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        refreshViewModel.data.drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)){
            _, speaker, cell in
            
            cell.textLabel?.text = speaker.name

        }.addDisposableTo(disposeBag)
        
        
        
    
     _ = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
                .takeUntil(self.rx.deallocated)
                .take(60)
        .subscribe(onNext: {[unowned self] ( count) in
           
            self.title = "........\(60 - count)"
            
            
            print("........\(60 - count)")
        })
        
        
        // Do any additional setup after loading the view.
    }
    
    deinit {
    
        
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
