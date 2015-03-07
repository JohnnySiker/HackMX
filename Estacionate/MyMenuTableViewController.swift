//
//  MyMenuTableViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

class MyMenuTableViewController: UITableViewController {
    var selectedMenuItem : Int = 0
    var counter : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.scrollEnabled = false
       // let c = CustomMainCell()
        tableView.rowHeight = 600.0
        //tableView.allowsSelection = false
        // Customize apperance of table view
        tableView.contentInset = UIEdgeInsetsMake(64.0, 0, 0, 0) //
        tableView.separatorStyle = .None
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollsToTop = false
        tableView.delegate = self
        
        // Preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: selectedMenuItem, inSection: 0), animated: false, scrollPosition: .Middle)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var default_cell = ViewCustomCell()
        default_cell.setCell("", lbl_name:"",notif_name:"")

        
        return default_cell;
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 300.0
        }
 
        
        return 50.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        selectedMenuItem = indexPath.row
        
        //Present new view controller
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main",bundle: nil)
        var destViewController : UIViewController
        
        switch(selectedMenuItem){
        case 0:
            println("0")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("UserProfile") as UIViewController
            
        case 1:
            println("1")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MyPets") as UIViewController
            
        case 2:
            println("2")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ChatSol") as UIViewController
            
        case 3:
            println("3")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Likes") as UIViewController
            
        case 4:
            println("4")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Opciones") as UIViewController
            
            
        default:
            println("Default")
            destViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LogIn") as UIViewController
            break
            
        }
        sideMenuController()?.setContentViewController(destViewController)
    }
    
    
}

