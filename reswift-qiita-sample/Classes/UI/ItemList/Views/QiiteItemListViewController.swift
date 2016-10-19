//
//  QiiteItemListViewController.swift
//  reswift-qiita-sample
//
//  Created by rb_de0 on 2016/10/18.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import UIKit

import ReSwift
import RxSwift

class QiiteItemListViewController: UIViewController, StoreSubscriber {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let itemListStore = Store<ItemListState>(
        reducer: ItemListReducer(),
        state: nil
    )
    
    fileprivate var visibleItems = [QiitaItem]()
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        tableView.rx_reachedBottom.subscribe(onNext: {[unowned self] in
            self.itemListStore.dispatch(ItemListAction.Creator.loadItems(disposeBag: self.disposeBag))
        }).addDisposableTo(disposeBag)
        
        itemListStore.dispatch(ItemListAction.Creator.loadItems(disposeBag: disposeBag))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemListStore.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        itemListStore.unsubscribe(self)
    }
    
    func newState(state: ItemListState) {
        
        if state.fetchedItemCount == 0 {
            return
        }
        
        DispatchQueue.main.async {
            self.visibleItems = state.items
            self.tableView.reloadData()
        }
    }
}

extension QiiteItemListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: QiitaItemCell.self), for: indexPath) as! QiitaItemCell
        cell.configure(title: visibleItems[indexPath.row].title, body: visibleItems[indexPath.row].body)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleItems.count
    }
}
