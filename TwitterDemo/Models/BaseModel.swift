//
//  BaseModel.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol BaseModel {
    init(fromJson json: JSON!)
}
