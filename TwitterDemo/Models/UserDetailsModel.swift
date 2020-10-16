//
//  UserDetailsModel.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import Foundation
import SwiftyJSON


class UserDetailsModel : BaseModel {

    var followersCount : Int!
    var following : Int!
    var friendsCount : Int!
    var idStr : String!
    var name : String!
    var profileBackgroundImageUrl : String!
    var profileBackgroundImageUrlHttps : String!
    var profileBannerUrl : String!
    var profileImageUrl : String!
    var profileImageUrlHttps : String!
    var screenName : String!

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    required init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }

        followersCount = json["followers_count"].intValue
        following = json["following"].intValue
        friendsCount = json["friends_count"].intValue
        idStr = json["id_str"].stringValue
        name = json["name"].stringValue
        profileBackgroundImageUrl = json["profile_background_image_url"].stringValue
        profileBackgroundImageUrlHttps = json["profile_background_image_url_https"].stringValue
        profileBannerUrl = json["profile_banner_url"].stringValue
        profileImageUrl = json["profile_image_url"].stringValue
        profileImageUrlHttps = json["profile_image_url_https"].stringValue
        screenName = json["screen_name"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()

        if followersCount != nil{
            dictionary["followers_count"] = followersCount
        }
        if following != nil{
            dictionary["following"] = following
        }
        if friendsCount != nil{
            dictionary["friends_count"] = friendsCount
        }
        if idStr != nil{
            dictionary["id_str"] = idStr
        }
        if profileBackgroundImageUrl != nil{
            dictionary["profile_background_image_url"] = profileBackgroundImageUrl
        }
        if profileBackgroundImageUrlHttps != nil{
            dictionary["profile_background_image_url_https"] = profileBackgroundImageUrlHttps
        }
        if profileBannerUrl != nil{
            dictionary["profile_banner_url"] = profileBannerUrl
        }
        if profileImageUrl != nil{
            dictionary["profile_image_url"] = profileImageUrl
        }
        if profileImageUrlHttps != nil{
            dictionary["profile_image_url_https"] = profileImageUrlHttps
        }

        if screenName != nil{
            dictionary["screen_name"] = screenName
        }
        return dictionary
    }
}
