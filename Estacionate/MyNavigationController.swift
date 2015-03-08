//
//  MyNavigationController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 30.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class MyNavigationController: ENSideMenuNavigationController, ENSideMenuDelegate {
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.alpha = 0

        sideMenu = ENSideMenu(sourceView: self.view, menuTableViewController: MyMenuTableViewController(),menuPosition:.Left)
        self.navigationController?.navigationBar.hidden = true
        //sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 220.0 // optional, default is 160
        //sideMenu?.bouncingEnabled = false
        
        // make navigation bar showing over side menu
        self.view.bringSubviewToFront(navigationBar)
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "don-iphone-bg")!)
        
        let view = storyboard?.instantiateViewControllerWithIdentifier("Map") as UIViewController
        self.sideMenuController()?.setContentViewController(view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - ENSideMenu Delegate
    func sideMenuWillOpen() {
        println("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        println("sideMenuWillClose")
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
