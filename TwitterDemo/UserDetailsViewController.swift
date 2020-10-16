//
//  UserDetailsViewController.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import UIKit
import AlamofireImage

class UserDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var userDetailsTableView: UITableView!
    @IBOutlet weak var friendsButton: UIButton!
    
    // MARK: - Properties
    var userScreenName: String = ""
    let viewModel = UserDetailsViewModel()
    var friendsData: FriendsListDataModel?
    var friendsList: [UserDetailsModel] = []
    var userData: UserDetailsModel?
    var nextData: String = "0"
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - View Controller Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup view
        self.profileImageView.layer.cornerRadius = 8.0
        self.friendsButton.layer.cornerRadius = 4.0
        self.userDetailsTableView.delegate = self
        self.userDetailsTableView.dataSource = self
        self.userDetailsTableView.alpha = 0
        
        // Fetch user data
        fetchUserDetails(screenName: userScreenName)
    }
    
    // MARK: - Methods
    func fetchUserDetails(screenName: String = "") {
        viewModel.delegate = self
        startLoading()
        viewModel.getUserDetails(screenName: screenName)
    }
    
    func updateUserInfo(userDetails: UserDetailsModel) {
        self.followersLabel.text = "Followers: \(userDetails.followersCount ?? 0)"
        self.followingLabel.text = "Following: \(userDetails.following ?? 0)"
        self.userName.text = userScreenName
        self.userEmail.text = User.userEmail
        
        if let imageUrl:String = userDetails.profileBackgroundImageUrl, imageUrl != "" {
            let url = URL(string: imageUrl)!
            let placeholderImage = UIImage(named: "placeHolder")!
            self.profileImageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }
    
    func fetchUserFriendsList(cursor: String, screenName: String) {
        viewModel.delegate = self
        startLoading()
        viewModel.getUserFriendsList(cursor: cursor, screenName: screenName)
    }
    
    // MARK: - IBActions
    @IBAction func friendsButtonTapped(_ sender: Any) {
        fetchUserFriendsList(cursor: nextData, screenName: userScreenName)
    }
    
    // MARK: - Table View Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserDetailsTableViewCell", for: indexPath) as! UserDetailsTableViewCell
        if !friendsList.isEmpty {
            cell.nameLabel.text = friendsList[indexPath.row].name
            if let imageUrl:String = friendsList[indexPath.row].profileBackgroundImageUrl, imageUrl != "" {
                let url = URL(string: imageUrl)!
                let placeholderImage = UIImage(named: "placeholderImage")!
                cell.profileIconImageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let userImageViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserImageViewController") as! UserImageViewController
        userImageViewController.userScreenName = userScreenName
        self.navigationController?.pushViewController(userImageViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Fetch Next Data
        if indexPath.row == friendsList.count - 1 && !nextData.isEmpty {
            fetchUserFriendsList(cursor: nextData, screenName: userScreenName)
        }
    }
}

// MARK: - UserDetailsViewModelDelegate
extension UserDetailsViewController: UserDetailsViewModelDelegate {
    func getUserDetailsDataSuccessful(model: UserDetailsModel) {
        updateUserInfo(userDetails: model)
        stopLoading()
    }
    
    func getUserFriendsListDataSuccessful(model: FriendsListDataModel) {
        nextData = model.nextCursorStr
        friendsList = model.users as? [UserDetailsModel] ?? []
        if !friendsList.isEmpty {
            self.userDetailsTableView.alpha = 1
            self.userDetailsTableView.reloadData()
        }
        stopLoading()
    }
}

// MARK: - UserDetailsViewController extension
extension UserDetailsViewController {
    
    func startLoading() {
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.style = UIActivityIndicatorView.Style.medium;
        view.addSubview(activityIndicator);

        activityIndicator.startAnimating();
        self.userDetailsTableView.isUserInteractionEnabled = false
    }

    func stopLoading() {
        activityIndicator.stopAnimating();
        self.userDetailsTableView.isUserInteractionEnabled = true
    }
}
