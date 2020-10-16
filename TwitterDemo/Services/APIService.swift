//
//  APIService.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService: NSObject {    
    class func getUserFriendListData<T: BaseModel>(requestEndPoint: APIRouter,
                                         completion: @escaping (_ viewModel :T?, _ error: Error?) -> Void){
        makeRequest(requestEndpoint: requestEndPoint, completion: completion)
    }
    
    class func getUserDetailsData<T: BaseModel>(requestEndPoint: APIRouter,
                                         completion: @escaping (_ viewModel :T?, _ error: Error?) -> Void){
        makeRequest(requestEndpoint: requestEndPoint, completion: completion)
    }
    
    class func getUserImageData<T: BaseModel>(requestEndPoint: APIRouter,
                                         completion: @escaping (_ viewModel :T?, _ error: Error?) -> Void){
        makeRequest(requestEndpoint: requestEndPoint, completion: completion)
    }
    
    class func getAccessToken<T: BaseModel>(requestEndPoint: APIRouter,
                                         completion: @escaping (_ viewModel :T?, _ error: Error?) -> Void){
        makeRequest(requestEndpoint: requestEndPoint, completion: completion)
    }
}

// MARK: Base API Call

extension APIService {
    private class func makeRequest<T: BaseModel>(requestEndpoint: APIRouter,
                                                 completion: @escaping (_ viewModel: T?, _ error: Error?) -> Void) {
        Alamofire
            .request(requestEndpoint)
            .responseJSON { response in
                
                guard let data = response.data else {
                    completion(nil, response.error)
                    return
                }
                
                let swiftyJsonVar = JSON(data)
                let responseModel = T.init(fromJson: swiftyJsonVar)
                completion(responseModel, nil)
        }
    }
}
