//
//  QiitaGetItemsRequest.swift
//  reswift-qiita-sample
//
//  Created by rb_de0 on 2016/10/18.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import APIKit
import Unbox

struct QitaGetItemsRequest: QiitaRequestType{
    let page: Int
    let perPage: Int
    
    typealias Response = [QiitaItem]
    
    var method: HTTPMethod{
        return .get
    }
    
    var path: String{
        return "/items"
    }
    
    // RootがArrayなので個別実装
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let responseJson = object as? [UnboxableDictionary] else{
            throw NSError(domain: "Invalud Response", code: -1, userInfo: nil)
        }
        
        let response: Response = try unbox(dictionaries: responseJson)
        return response
    }
    
}
