//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    var firstName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if (session != nil) {
                self.firstName = session?.userName ?? ""
                User.authToken = session?.authToken ?? ""
                let client = TWTRAPIClient.withCurrentUser()
                client.requestEmail { email, error in
                    self.dismiss(animated: true)
                    User.userEmail = email ?? ""
                    if (email != nil) {
                        print("signed in as \(String(describing: session?.userName))");
                        let userDetailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailsViewController") as! UserDetailsViewController
                        userDetailsViewController.userScreenName = (session?.userName ?? "").capitalized
                        self.navigationController?.pushViewController(userDetailsViewController, animated: true)
                    }else {
                        print("error: \(String(describing: error?.localizedDescription))");
                    }
                }
            }else {
                print("error: \(String(describing: error?.localizedDescription))");
            }
        }
    }
}
