//
//  ContainerViewModel.swift
//  SWIFT_RX_RAC_Demo
//
//  Created by chenyihang on 2017/6/7.
//  Copyright © 2017年 chenyihang. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ContaimerViewModel{

    var models: Driver<[Hero]>
    
    init(withSearchText searchText:Observable<String>,service:SearchService) {
        models = searchText.debug()
            .observeOn(ConcurrentDispatchQueueScheduler(qos:.background))
            .flatMap{ text in
                
                return service.getHeros(withname: text)
                
                
            }.asDriver(onErrorJustReturn: [])
        
    }

}
