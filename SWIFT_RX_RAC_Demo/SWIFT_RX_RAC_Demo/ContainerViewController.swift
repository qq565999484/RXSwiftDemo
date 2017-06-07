//
//  ContainerViewController.swift
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

import UIKit
#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

import CoreSpotlight


//range转换为NSRange
extension String {
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
}


extension Range{
    //转换成NSRange
    var toNSRange:NSRange{
        return NSRangeFromString(self.description);
    }
}




//NSRange转化为range
extension String {
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}

class ContainerViewController: UIViewController {
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    var searchCurrText: String = ""
    var  viewModel:ContaimerViewModel!
    
    var searchBarText: Observable<String>{
        return searchBar.rx.text.orEmpty
            .throttle(0.3,scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        searchBar.rx.text.orEmpty.subscribe { [unowned self] (text) in
            
            self.searchCurrText = text.element!
            
            
        }.addDisposableTo(disposeBag)
        
        viewModel = ContaimerViewModel(withSearchText: searchBarText, service: SearchService.shared)
        viewModel.models
            .drive(tableView.rx.items(cellIdentifier: "cell",cellType:UITableViewCell.self)){[unowned self] (row,element,cell) in

                
                cell.textLabel?.text = element.name
                
       
                cell.textLabel?.attributedText = self.changeRangeTextColor(self.searchCurrText, allText: element.name, changeColor: UIColor.yellow)
                    
                
                cell.detailTextLabel?.text = element.desc
                
                cell.detailTextLabel?.attributedText = self.changeRangeTextColor(self.searchCurrText, allText: element.desc, changeColor: UIColor.yellow)
                
                cell.imageView?.image = UIImage(named: element.icon)
        
        }
        .addDisposableTo(disposeBag)

        
        

        // Do any additional setup after loading the view.
    }

    //add spotlight
    
//    func setupSearchableContent() {
//        
//        
//        var searchableItems = [CSSearchableItem]()
//        
//        
//        for i in 0...(viewModel.models - 1) {
//            
//            let movie = moviesInfo[i] as! [String: String]
//            
//            let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
//            
//            //set the title
//            searchableItemAttributeSet.title = movie["Title"]!
//            
//            //set the image
//            let imagePathParts = movie["Image"]!.components(separatedBy: ".")
//            searchableItemAttributeSet.thumbnailURL = Bundle.main.url(forResource: imagePathParts[0], withExtension: imagePathParts[1])
//            
//            // Set the description.
//            searchableItemAttributeSet.contentDescription = movie["Description"]!
//            
//            var keywords = [String]()
//            let movieCategories = movie["Category"]!.components(separatedBy: ", ")
//            for movieCategory in movieCategories {
//                keywords.append(movieCategory)
//            }
//            
//            let stars = movie["Stars"]!.components(separatedBy: ", ")
//            for star in stars {
//                keywords.append(star)
//            }
//            
//            searchableItemAttributeSet.keywords = keywords
//            
//            let searchableItem = CSSearchableItem(uniqueIdentifier: "com.appcoda.SpotIt.\(i)", domainIdentifier: "movies", attributeSet: searchableItemAttributeSet)
//            
//            searchableItems.append(searchableItem)
//            
//            
//        }
//        
//        
//        CSSearchableIndex.default().indexSearchableItems(searchableItems) { (error) -> Void in
//            if error != nil {
//                print(error?.localizedDescription)
//            }
//            
//            
//            
//        }
//        
//    }
//    
//    override func restoreUserActivityState(_ activity: NSUserActivity) {
//        
//        if activity.activityType == CSSearchableItemActionType {
//            if let userInfo = activity.userInfo {
//                let selectedMovie = userInfo[CSSearchableItemActivityIdentifier] as! String
//                selectedMovieIndex = Int(selectedMovie.components(separatedBy: ".").last!)
//                performSegue(withIdentifier: "idSegueShowMovieDetails", sender: self)
//            }
//        }
//    }
//    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func changeRangeTextColor(_ subString: String,allText rangeStr:String!, changeColor color: UIColor) -> NSMutableAttributedString {
        
        let textAttr = NSMutableAttributedString(string: rangeStr, attributes: [:])
        
        if let start = rangeStr.range(of: subString)?.lowerBound, let end = rangeStr.range(of: self.searchCurrText)?.upperBound, subString.characters.count > 0  {
            
            let range = start...end
            
             textAttr.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(NSRangeFromString(range.description).location, subString.characters.count))
        }
        return textAttr
        
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
