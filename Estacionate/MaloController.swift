//
//  MaloControllerViewController.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 08/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class MaloController: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate,UIPickerViewDataSource {

    
    @IBOutlet weak var scrollView: UIScrollView!
    var oki : UIButton!
    var cancelar: UIButton!
    var experiencias: UIPickerView!
    var problematicas = ["Me llevo la grua", "Hay Franeleros","Personas apartando Calle","Robo de autopartes", "Robo total","Inmobilizaron mi auto","Vandalismo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        experiencias = UIPickerView()
        experiencias.delegate = self
        experiencias.dataSource = self
        // Do any additional setup after loading the view.
        experiencias.frame = CGRect(x: 20, y: 200, width: 300, height: 300)
        scrollView.addSubview(experiencias)
        scrollView.delegate = self
        scrollView.scrollEnabled = false
        scrollView.showsHorizontalScrollIndicator = false

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            }
    

    @IBAction func Bueno(sender: UIButton) {
        let nView = self.storyboard?.instantiateViewControllerWithIdentifier("Map") as UIViewController
        self.dismissViewControllerAnimated(false, completion: nil)

        self.sideMenuController()?.setContentViewController(nView)
        sideMenuController()?.sideMenu?.toggleMenu()
    }
  
    @IBAction func malo(sender: UIButton) {
        
        scrollView.frame.origin.y = -150
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return problematicas[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        println("sfadsfasf")
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return problematicas.count
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    
}
