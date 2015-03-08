//
//  Options.swift
//  Estacionate
//
//  Created by Aldo Antonio Martinez Avalos on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class Options: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lbl_distance: UILabel!
    var distancia:Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.slider.maximumValue = 3000
        self.slider.minimumValue = 50
        distancia = Double(prefs.integerForKey("Distance"))
        self.slider.value = Float(distancia * 2.0)*10
        self.lbl_distance.text = "\(Int(self.slider.value)) m"
        
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
        prefs.setInteger(Int(self.slider.value), forKey: "Distance")
    }

    @IBAction func back(sender: UIButton) {
        let view = storyboard?.instantiateViewControllerWithIdentifier("Map") as UIViewController
        self.sideMenuController()?.setContentViewController(view)
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    
    
}
