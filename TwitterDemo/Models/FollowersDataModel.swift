//
//  FollowersDataModel.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import Foundation
import SwiftyJSON


class FriendsListDataModel : BaseModel {

    var nextCursor : Int!
    var nextCursorStr : String!
    var previousCursor : Int!
    var previousCursorStr : String!
    var users : [Any]!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    
    required init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        nextCursor = json["next_cursor"].intValue
        nextCursorStr = json["next_cursor_str"].stringValue
        previousCursor = json["previous_cursor"].intValue
        previousCursorStr = json["previous_cursor_str"].stringValue
        
        users = [UserDetailsModel]()
        let usersArray = json["users"].arrayValue
        for usersJson in usersArray{
            users.append(usersJson)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if nextCursor != nil{
            dictionary["next_cursor"] = nextCursor
        }
        if nextCursorStr != nil{
            dictionary["next_cursor_str"] = nextCursorStr
        }
        if previousCursor != nil{
            dictionary["previous_cursor"] = previousCursor
        }
        if previousCursorStr != nil{
            dictionary["previous_cursor_str"] = previousCursorStr
        }
        if users != nil{
            dictionary["users"] = users
        }
        return dictionary
    }
}
