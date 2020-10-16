//
//  UserImageViewController.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import UIKit
import AlamofireImage

class UserImageViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!

    // MARK: - Properties
    var userScreenName: String = ""
    let viewModel = UserDetailsViewModel()
    var userImageData: UserImageModel?
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchUserImage()
    }
    
    // MARK: - Methods
    func fetchUserImage() {
        viewModel.delegate = self
        viewModel.getUserImage(screenName: userScreenName)
    }
    
    func updateUserImage(userImageUrl: String) {
        if !userImageUrl.isEmpty {
            let url = URL(string: userImageUrl)!
            let placeholderImage = UIImage(named: "placeHolder")!
            self.userImageView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        }
    }
}

// MARK: - UserDetailsViewModelDelegate
extension UserImageViewController: UserDetailsViewModelDelegate {
    func getUserImageDataSuccessful(model: UserImageModel) {
        updateUserImage(userImageUrl: model.url)
    }
}

// MARK: - UserImageViewController extension
extension UserImageViewController {
    
    func startLoading() {
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.style = UIActivityIndicatorView.Style.medium;
        view.addSubview(activityIndicator);
        activityIndicator.startAnimating();
    }

    func stopLoading() {
        activityIndicator.stopAnimating();
    }
}
