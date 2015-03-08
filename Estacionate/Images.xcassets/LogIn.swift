//
//  LogIn.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class LogIn: UIViewController,UITextFieldDelegate {
 
    
    @IBOutlet weak var tf_email: UITextField!
    
    @IBOutlet weak var tf_pass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTextField([tf_pass,tf_email])
        let center = NSNotificationCenter.defaultCenter()
        self.navigationItem.title = "Registro"
        
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
        self.view.frame.origin.y = -210
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.alpha = 0
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
        switch textField {
        case tf_email:
            tf_pass.becomeFirstResponder()
            break;
        case tf_pass:
            tf_pass.resignFirstResponder()
            entrar()
            break;
        default:
            break;
        }
        return true;
    }
    
    
    
    @IBAction func entrar() {
        if (tf_email.text == "a" && tf_pass.text == "a") {
            let nView = self.storyboard?.instantiateViewControllerWithIdentifier("menu") as MyNavigationController
            self.navigationController?.presentViewController(nView, animated: true,completion:nil)
            self.sideMenuController()?.sideMenu?.toggleMenu()
        }else{
            println("error")
        }
        
    }

}
