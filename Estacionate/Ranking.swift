//
//  Ranking.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class Ranking: UIViewController,UITableViewDelegate, UITableViewDataSource{
    var nombres:[String]!
    
    @IBOutlet weak var tb_ranking: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombres = ["Maritza Basilio Acosta","Narcisa Caridad Ureña","Cruz Rosario Roldán","Reyes Chus Asis","María Guadalupe Zapatero","Chus Reyes Santillian","Odalis Ale Pérez","Guiomar Rosario Santos","Guadalupe Fran Gonzalez","Ale Cruz Iñíguez","Cruz Guadalupe Alvarado","Cruz Guadalupe Alvarado","Guadalupe Ale Albuquerque","Ale Cruz Guadarrama","Trinidad Fran Ruiz"]
        tb_ranking.delegate = self
        tb_ranking.dataSource = self
        tb_ranking.showsVerticalScrollIndicator = false
        
        tb_ranking.separatorColor = UIColor.clearColor()
        
        tb_ranking.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tb_ranking.dequeueReusableCellWithIdentifier("RCell") as RankingCell
        cell.selectionStyle = .None
            cell.setCell(["\(indexPath.row+1)",nombres[indexPath.row],"\(1000-indexPath.row*34) pts"])
            return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }

    @IBAction func back(sender: UIButton) {
        let nView = self.storyboard?.instantiateViewControllerWithIdentifier("Map") as UIViewController
        self.sideMenuController()?.setContentViewController(nView)
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
}
