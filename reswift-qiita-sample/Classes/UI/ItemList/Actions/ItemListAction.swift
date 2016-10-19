//
//  ItemListAction.swift
//  reswift-qiita-sample
//
//  Created by rb_de0 on 2016/10/18.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import ReSwift
import RxSwift

struct ItemListAction {
    
    struct RequestStartAction: Action{}
    
    struct ResuestFinishedAction: Action{}
    
    struct RecievedItemsAction: Action{
        let items: [QiitaItem]
    }
    
    struct Creator{
        
        static func loadItems(disposeBag: DisposeBag) -> Store<ItemListState>.AsyncActionCreator {
            return { (state, store, callback) in
                
                if state.isLoading{
                    return
                }
                
                callback{ _, _ in RequestStartAction() }
                
                QitaGetItemsRequest(page: state.currentPage, perPage: 20)
                    .response()
                    .subscribe(
                        onNext: {items in
                            callback{ _, _ in RecievedItemsAction(items: items) }
                        },
                        onError: {_ in
                            callback{ _, _ in ResuestFinishedAction() }
                        }
                    ).addDisposableTo(disposeBag)
                
            }
        }
    }
}


