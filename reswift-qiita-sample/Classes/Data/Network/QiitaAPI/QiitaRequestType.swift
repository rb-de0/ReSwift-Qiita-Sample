//
//  QiitaRequestType.swift
//  reswift-qiita-sample
//
//  Created by rb_de0 on 2016/10/18.
//  Copyright © 2016年 rb_de0. All rights reserved.
//

import Foundation
import UIKit

import APIKit
import Unbox
import RxSwift

protocol QiitaRequestType: Request{}

extension QiitaRequestType{
    var baseURL: URL{
        return URL(string: "http://qiita.com/api/v2")!
    }
    
    func response() -> Observable<Response>{
        
        return Observable.create{(observer: AnyObserver) in
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            Session.send(self){result in
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch result{
                case .success(let response):
                    observer.onNext(response)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create{
                Session.cancelRequests(with: type(of: self))
            }
        }
    }
}
