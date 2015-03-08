//
//  EstacionarmeController.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class EstacionarmeController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var tf_public: UITextField!
    @IBOutlet weak var tb_timeLine: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tb_timeLine.delegate = self
        tb_timeLine.dataSource = self
        tb_timeLine.showsVerticalScrollIndicator = false
        tb_timeLine.separatorColor = UIColor.clearColor()
        tb_timeLine.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
        configureTextField([tf_public])
        let center = NSNotificationCenter.defaultCenter()
        
        center.addObserver(self,
            selector: "handleKeyboardWillShow:",
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        center.addObserver(self,
            selector: "handleKeyboardWillHide:",
            name: UIKeyboardWillHideNotification,
            object: nil)

        
    }
    
    
    
    func handleKeyboardWillHide(sender: NSNotification){
        
        self.view.frame.origin.y = 0
        
        
    }
    
    
    func handleKeyboardWillShow(notification: NSNotification){
        self.view.frame.origin.y = -270
       // tb_timeLine.frame.height = 40 as CGFloat
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
    func configureTextField(texto: [UITextField]){
        
        var leftPaddingView:UIView!
        for a in texto {
            leftPaddingView  = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            leftPaddingView.backgroundColor = UIColor.clearColor()
            a.leftView = leftPaddingView
            a.leftViewMode = .Always
            a.delegate = self
        }
        for b in texto{
            b.layer.borderColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1).CGColor
            b.layer.borderWidth = 1
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
  
    @IBAction func back(sender: UIButton) {
        
        var refreshAlert = UIAlertController(title: "¿Cómo calificas el lugar donde te estacionaste?", message: "", preferredStyle: UIAlertControllerStyle.Alert)

        refreshAlert.addAction(UIAlertAction(title: "Bueno", style: .Default, handler: { (action: UIAlertAction!) in
            
            let nView = self.storyboard?.instantiateViewControllerWithIdentifier("Map") as UIViewController
            self.sideMenuController()?.setContentViewController(nView)
            self.sideMenuController()?.sideMenu?.toggleMenu()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Malo", style: .Default, handler: { (action: UIAlertAction!) in
                    }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancelar", style: .Cancel, handler: { (action: UIAlertAction!) in
            println("Handle Cancel Logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
     
     
    }
    @IBAction func buscarCoche(sender: UIButton) {
        let nView = self.storyboard?.instantiateViewControllerWithIdentifier("Desaparecido") as UIViewController
        self.navigationController?.pushViewController(nView, animated: true)
        self.sideMenuController()?.sideMenu?.hideSideMenu()
        //self.sideMenuController()?.setContentViewController(nView)
        //self.sideMenuController()?.sideMenu?.toggleMenu()
    }
}
