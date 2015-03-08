//
//  EstacionarmeController.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class EstacionarmeController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tb_timeLine: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tb_timeLine.delegate = self
        tb_timeLine.dataSource = self
        tb_timeLine.showsVerticalScrollIndicator = false
        tb_timeLine.separatorColor = UIColor.clearColor()
        tb_timeLine.backgroundColor = UIColor.clearColor()
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
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tb_timeLine.dequeueReusableCellWithIdentifier("ECell") as ECell
        cell.selectionStyle = .None
        cell.setCell("Noticia \(indexPath.row)")
        return cell
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
    }
  
}
