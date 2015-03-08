//
//  Desaparecido.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 08/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class Desaparecido: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var tf_placas: UITextField!
    
    @IBOutlet weak var lb_nombre: UILabel!
    
    @IBOutlet weak var lb_direccion: UILabel!
    
    @IBOutlet weak var lb_colonia: UILabel!
    @IBOutlet weak var lb_delegacion: UILabel!
    
    @IBOutlet weak var lb_cp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField([tf_placas])
        // Do any additional setup after loading the view.
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
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let view = self.storyboard?.instantiateViewControllerWithIdentifier("Estacionarme") as UIViewController
        self.sideMenuController()?.setContentViewController(view)
        self.sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    
    @IBAction func refresh(sender: UIButton) {
    
    }

    
}
