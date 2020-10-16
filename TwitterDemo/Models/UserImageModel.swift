//
//  UserImageModel.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserImageModel : BaseModel {

    var url : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    
    required init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        
        let sizesJson = json["sizes"]
        let hdImage = sizesJson["1500x500"]
        url = hdImage["url"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if url != nil{
            dictionary["url"] = url
        }
        return dictionary
    }
}
