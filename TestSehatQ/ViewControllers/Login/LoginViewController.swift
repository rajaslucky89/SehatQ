//
//  LoginViewController.swift
//  TestSehatQ
//
//  Created by Raja on 08/08/19.
//  Copyright © 2019 Raja. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setComponents()
    }
    
    @IBAction func clickLogin(_ sender: UIButton) {
        redirectTo(MasterTabBar())
    }
    
    @IBAction func clickLoginFB(_ sender: UIButton) {
        customFBLogin()
    }
    
    @IBAction func clickLoginGoogle(_ sender: UIButton) {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
}

extension LoginViewController {
    private func setComponents() {
        // Set padding
        emailTextField.setLeftPaddingPoints(10)
        passwordTextField.setLeftPaddingPoints(10)
        
        // Hide NavBar
        navigationController?.isNavigationBarHidden = true
    }
    
    //FACEBOOK
    func customFBLogin(){
        FBSDKLoginManager().logIn(withReadPermissions: ["user_gender", "email"], from: self) { (result, err) in
            if err != nil {
                print("Custom FB Login failed:", err)
                return
            }
            self.showEmailAddress() //If not error, push to new controller, send token and get token from API
        }
    }
    
    func showEmailAddress() {
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, birthday, gender"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err)
                return
            }
            
            let data = result as? NSDictionary
            let email = data?.object(forKey: "email") as? String
            print("Email : \(email)")
            print("token FB: \(FBSDKAccessToken.current().tokenString)")
        }
    }
    
}

extension LoginViewController: GIDSignInUIDelegate, GIDSignInDelegate {
    //GOOGLE
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        //if any error stop and print the error
        if error != nil{
            print(error ?? "google error")
            return
        }
        let idToken = user.authentication.idToken ?? ""
        print("idToken : \(idToken)")
        print("Authentication idToken is \(idToken)")
    }
}
