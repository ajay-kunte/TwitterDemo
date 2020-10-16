//
//  APIRouter.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkRouter: URLRequestConvertible {
    static var baseURLPath: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
}

public enum APIRouter: NetworkRouter {
    
    static var baseURLPath: String {
        return "https://api.twitter.com"
    }
    
    case getUserFriendListData(parameter: Parameters)
    case getUserDetailsData(parameter: Parameters)
    case getUserImage(parameter: Parameters)
    case getAccessToken

    var method: HTTPMethod {
        switch self {
        case .getAccessToken:
            return .post
        default:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getUserImage:
            return "/1.1/users/profile_banner.json"
        case .getUserDetailsData:
            return "/1.1/users/show.json"
        case .getUserFriendListData:
            return "/1.1/friends/list.json"
        case .getAccessToken:
            return "/oauth2/token"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        //Setting the request with all the necessary parameters for the call
        
        let url = try APIRouter.baseURLPath.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = method.rawValue
        request.timeoutInterval = TimeInterval(30)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if method == .post {
            let encodedConsumerKeyString:String = "Sh4JYw4aQ773emLJTL9zlFFF2".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
            let encodedConsumerSecretKeyString:String = "KYZk6x2O0HO8e1ClUyqDDMjXOnYJhjwHBXrY4PJ6M7OFBxkE7z".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed)!
            let combinedString = "\(encodedConsumerKeyString):\(encodedConsumerSecretKeyString)"
            let data = combinedString.data(using: .utf8)
            request.setValue("Basic \(data?.base64EncodedString() ?? "")", forHTTPHeaderField: "Authorization")
            request.setValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            let bodyData = "grant_type=client_credentials".data(using: .utf8)!
            request.setValue("\(bodyData.count)", forHTTPHeaderField: "Content-Length")
            request.httpBody = bodyData
        } else {
            request.setValue("Bearer \(User.authToken)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .getUserImage(let parameters):
            var urlRequestLocal = request
            if let stringUrl = request.url?.absoluteString{
                if let screenName = parameters["screen_name"] {
                    let urlString = "\(stringUrl)?screen_name=\(screenName)"
                    urlRequestLocal.url = URL(string: urlString)
                }
            }
            return try JSONEncoding.default.encode(urlRequestLocal, with: nil)
            
        case .getUserDetailsData(let parameters):
            var urlRequestLocal = request
            if let stringUrl = request.url?.absoluteString{
                if let screenName = parameters["screen_name"] {
                    let urlString = "\(stringUrl)/?screen_name=\(screenName)"
                    urlRequestLocal.url = URL(string: urlString)
                }
            }
            return try JSONEncoding.default.encode(urlRequestLocal, with: nil)
            
        case .getUserFriendListData(let parameters):
            var urlRequestLocal = request
            if let stringUrl = request.url?.absoluteString{
                if let cursor = parameters["cursor"], let screenName = parameters["screen_name"] {
                    let urlString = "\(stringUrl)?cursor=\(cursor)&screen_name=\(screenName)&skip_status=true&include_user_entities=false"
                    urlRequestLocal.url = URL(string: urlString)
                }
            }
            return try JSONEncoding.default.encode(urlRequestLocal, with: nil)
            
        case .getAccessToken:
            return try JSONEncoding.default.encode(request, with: nil)
        }
    }
}
