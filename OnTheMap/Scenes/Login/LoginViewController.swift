//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by Amr on 173//19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var passsword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func alertMessage(title: String , error: String){
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
    
    @IBAction func login(_sender: UIButton) {
        if username.text == "" || passsword.text == "" {
           self.alertMessage(title: "Error", error: "Please, enter your E-mail or password")
        } else {
            let apiServece = DataProviderService()

            apiServece.authenticate(username: username.text ?? "", password: passsword.text ?? "") { (authModel, error) in
                DispatchQueue.main.async {
                    if  error != nil {
                        let alert = UIAlertController(title: "Error", message: "\(error?.localizedDescription)", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        if let authModel = authModel, let isRegestred = authModel.account?.registered  {
                            if isRegestred {
                                // Navegate To Home Screen
                                if let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") {
                                    self.present(homeViewController, animated: true, completion: nil)
                                } else {
                                    let alert = UIAlertController(title: "Oh Sorry!", message: "You seem like not regestred yet ", preferredStyle: .alert)
                                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                                    alert.addAction(okAction)
                                    self.present(alert, animated: true, completion: nil)
                                }
                                
                            }
                        }
                    }
                }
                
        }
    }
    
    }
    @IBAction func signup(_ sender: UIButton) {
        let url = URL(string: "https://auth.udacity.com/sign-up")!
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
}
