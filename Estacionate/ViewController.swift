//
//  ViewController.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,FBLoginViewDelegate {

    
    
    @IBOutlet weak var fb_icon: FBLoginView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fb_icon.delegate = self
        fb_icon.readPermissions = ["public_profile", "email", "user_friends"]
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.alpha = 0
    }
    
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        var userEmail = user.objectForKey("email") as String
        var userGender = user.objectForKey("gender") as String
        println("User Email: \(userEmail)")
        
        println("Genero del usuario: \(userGender)")
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignIn(sender: UIButton) {
        let nView = self.storyboard?.instantiateViewControllerWithIdentifier("SignUp") as SignUp
        self.navigationController?.pushViewController(nView, animated: true)
        
    }
    
    
    @IBAction func LogIn(sender: UIButton) {
        let nView = self.storyboard?.instantiateViewControllerWithIdentifier("LogIn") as UIViewController
       self.navigationController?.pushViewController(nView, animated: true)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationController?.navigationBar.alpha = 0
    }

}

