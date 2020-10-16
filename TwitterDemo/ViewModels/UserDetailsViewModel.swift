//
//  UserDetailsViewModel.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import Foundation

protocol UserDetailsViewModelDelegate: class {
    func getUserDetailsDataSuccessful(model: UserDetailsModel)
    func getUserImageDataSuccessful(model: UserImageModel)
    func getUserFriendsListDataSuccessful(model: FriendsListDataModel)
}

extension UserDetailsViewModelDelegate {
    func getUserDetailsDataSuccessful(model: UserDetailsModel) {}
    func getUserImageDataSuccessful(model: UserImageModel) {}
    func getUserFriendsListDataSuccessful(model: FriendsListDataModel) {}
}

class UserDetailsViewModel {
    
    // MARK: - Delegates
    
    weak var delegate: UserDetailsViewModelDelegate?
    
    // MARK: - Methods
    
    ///
    /// Returns the user's friend list
    ///
    
    func getUserFriendsList(cursor: String = "0", screenName: String) {
        let parameters = ["cursor": cursor, "screen_name": screenName] as [String : Any]
        APIService.getUserFriendListData(requestEndPoint: .getUserFriendListData(parameter: parameters)) { (model: FriendsListDataModel?, error: Error?) in
            if let model = model {
                self.delegate?.getUserFriendsListDataSuccessful(model: model)
            }
        }
    }
    
    ///
    /// Returns the user details
    ///
    
    func getUserDetails(screenName: String) {
        let parameters = ["screen_name": screenName] as [String : Any]
        APIService.getUserFriendListData(requestEndPoint: .getUserDetailsData(parameter: parameters)) { (model: UserDetailsModel?, error: Error?) in
            if let model = model {
                self.delegate?.getUserDetailsDataSuccessful(model: model)
            }
        }
    }
    
    ///
    /// Returns the user details
    ///
    
    func getUserImage(screenName: String) {
        let parameters = ["screen_name": screenName] as [String : Any]
        APIService.getUserFriendListData(requestEndPoint: .getUserImage(parameter: parameters)) { (model: UserImageModel?, error: Error?) in
            if let model = model {
                self.delegate?.getUserImageDataSuccessful(model: model)
            }
        }
    }
}
