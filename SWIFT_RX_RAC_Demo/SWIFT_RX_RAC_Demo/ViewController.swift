//
//  ViewController.swift
//  SWIFT_RX_RAC_Demo
//
//  Created by chenyihang on 2017/5/27.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import UIKit
import Foundation
import RxCocoa
import RxSwift
import RxDataSources

struct MySection {
    var header: String
    var items: [Item]
}

extension MySection: AnimatableSectionModelType
{
    typealias Item = Int
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

class ViewController: UIViewController {
    
        
    @IBOutlet weak var rx_tableview: UITableView!
    let disposeBag = DisposeBag()
    
    let reuseIdentifier = "\(UITableViewCell.self)"
    
    var dataSource: RxTableViewSectionedReloadDataSource<MySection>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rx_tableview.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>()
        
        dataSource.configureCell = {
            [unowned self] ds,tv,ip,model in
            
            let cell = tv.dequeueReusableCell(withIdentifier: self.reuseIdentifier) ?? UITableViewCell(style: .default , reuseIdentifier: self.reuseIdentifier)
            
            cell.textLabel?.text = "Item \(model)"
            
            return cell;
        }
        
//        dataSource.titleForHeaderInSection = { ds,index in
//            return ds.sectionModels[index].header
//        }
        
        let sections = [
            MySection(header: "First Section",items: [1 , 2]),
            MySection(header: "Second Section",items: [3 , 4])
        
        ]
        
        
        
        
        Observable.just(sections)
                  .bind(to: rx_tableview.rx.items(dataSource: dataSource))
                  .addDisposableTo(disposeBag)
        
        rx_tableview.rx.setDelegate(self).addDisposableTo(disposeBag)
        
        self.dataSource = dataSource
        
        
        Observable.of(
            rx_tableview.rx.modelSelected(MySection.self)
            )
            .merge()
            .subscribe(onNext: { item in
                print("Let me guess, it's .... It's \(item), isn't it? Yeah, I've got it.")
            })
            .addDisposableTo(disposeBag)

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let item = dataSource?[indexPath],
//            let _ = dataSource?[indexPath.section] 
//        else {
//            return 0.0;
//        }
        return CGFloat(40 + 1 )
    }


}

