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
            state.fetchedItemCount = 0
            
        case _ as ItemListAction.ResuestFinishedAction:
            
            state.isLoading = false
            state.fetchedItemCount = 0
            
        case let action as ItemListAction.RecievedItemsAction:
            
            state.isLoading = false
            state.currentPage += 1
            state.items += action.items
            state.fetchedItemCount = action.items.count
            
        default:
            break
        }
        
        return state
    }
}
