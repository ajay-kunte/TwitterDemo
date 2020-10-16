//
//  User.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//


import Foundation
import UIKit

class User {
 
    static var authToken: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "authToken")
        }
        get {
            return UserDefaults.standard.string(forKey: "authToken") ?? ""
        }
    }
    
    static var userId: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
        get {
            return UserDefaults.standard.string(forKey: "userId") ?? ""
        }
    }
        
    static var name: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "name")
        }
        get {
            return UserDefaults.standard.string(forKey: "name") ?? ""
        }
    }
    
    static var userEmail: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "userEmail")
        }
        get {
            return UserDefaults.standard.string(forKey: "userEmail") ?? ""
        }
    }
    
    static var accessToken: String {
        set {
            UserDefaults.standard.set(newValue, forKey: "accessToken")
        }
        get {
            return UserDefaults.standard.string(forKey: "accessToken") ?? ""
        }
    }
}

