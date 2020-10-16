//
//  AccessTokenModel.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 16/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import Foundation
import SwiftyJSON


class AccessToken : BaseModel {

    var accessToken : String!
    var tokenType : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    required init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        accessToken = json["access_token"].stringValue
        tokenType = json["token_type"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accessToken != nil{
            dictionary["access_token"] = accessToken
        }
        if tokenType != nil{
            dictionary["token_type"] = tokenType
        }
        return dictionary
    }
}
