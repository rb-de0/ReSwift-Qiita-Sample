//
//  ItemListReducer.swift
//  reswift-qiita-sample
//
//  Created by rb_de0 on 2016/10/18.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import ReSwift

struct ItemListReducer: Reducer{
    
    func handleAction(action: Action, state: ItemListState?) -> ItemListState{
        var state = state ?? ItemListState()
        
        switch action {
        case _ as ItemListAction.RequestStartAction:
            state.isLoading = true
        case _ as ItemListAction.ResuestFinishedAction:
            state.isLoading = false
        case _ as ItemListAction.RecievedItemsAction:
            state.currentPage += 1
            state.items += (action as! ItemListAction.RecievedItemsAction).items
        default:
            break
        }
        
        return state
    }
}
