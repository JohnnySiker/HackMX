//
//  Options.swift
//  Estacionate
//
//  Created by Aldo Antonio Martinez Avalos on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class Options: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lbl_distance: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.maximumValue = 1000
        self.slider.minimumValue = 10
        
        table.delegate = self
        table.dataSource = self
        
        table.separatorColor = UIColor.clearColor()
        table.showsVerticalScrollIndicator = false
        table.scrollEnabled = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.row){
            case 0:
                let cell = table.dequeueReusableCellWithIdentifier("optionsCell") as OptionsCell
                cell.selectionStyle = .None
                cell.setText("Notificaciones")
                return cell
            case 1:
                let cell = table.dequeueReusableCellWithIdentifier("optionsCell") as OptionsCell
                cell.selectionStyle = .None
                cell.setText("Mi cuenta")
                return cell
            case 2:
                let cell = table.dequeueReusableCellWithIdentifier("optionsCell") as OptionsCell
                cell.selectionStyle = .None
                cell.setText("Acerca de esta app")
                return cell
            default:
                let cell = table.dequeueReusableCellWithIdentifier("optionsCell") as OptionsCell
                cell.selectionStyle = .None
                cell.setText("")
                return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    }
    
    
    @IBAction func action_slider(sender: UISlider) {
        self.lbl_distance.text = "\(Int(self.slider.value)) m"

    }

    @IBAction func back(sender: UIButton) {
        let view = storyboard?.instantiateViewControllerWithIdentifier("Map") as UIViewController
        self.sideMenuController()?.setContentViewController(view)
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    
}
