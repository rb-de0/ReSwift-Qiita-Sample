//
//  QiitaItemCell.swift
//  reswift-qiita-sample
//
//  Created by rb_de0 on 2016/10/18.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import UIKit

class QiitaItemCell: UITableViewCell{
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var body: UILabel!
    
    func configure(title: String, body: String){
        self.title.text = title
        self.body.text = body
    }
    
}
