//
//  QiitaItem.swift
//  reswift-qiita-sample
//
//  Created by rb_de0 on 2016/10/18.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import Unbox

struct QiitaItem: Unboxable{
    let id: String
    let title: String
    let url: String
    let body: String
    let isPrivate: Bool
    let userImage: String
    
    init(unboxer: Unboxer) throws{
        id = try unboxer.unbox(key: "id")
        title = try unboxer.unbox(key: "title")
        url = try unboxer.unbox(key: "url")
        body = try unboxer.unbox(key: "body")
        isPrivate = try unboxer.unbox(key: "private")
        userImage = try unboxer.unbox(keyPath: "user.profile_image_url")
    }
}
