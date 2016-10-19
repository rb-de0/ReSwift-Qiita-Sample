//
//  ItemListState.swoft
//  reswift-qiita-sample
//
//  Created by rb_de0 on 2016/10/18.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import ReSwift

struct ItemListState: StateType{
    var fetchedItemCount = 0
    var items = [QiitaItem]()
    var isLoading = false
    var currentPage = 0
}
