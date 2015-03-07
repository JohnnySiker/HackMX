//
//  MainCell.swift
//  DogOrNot
//
//  Created by Aldo Antonio Martinez Avalos on 25/02/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import Foundation

class MainCell{
    var main_img = "none"
    var lbl_name = "none"
    var rate_img = "none"
    var lbl_edit = "editar"
    
    init(main_img: String, lbl_name:String, rate_img: String, lbl_edit: String){
        self.main_img = main_img
        self.lbl_name = lbl_name
        self.rate_img = rate_img
        self.lbl_edit = lbl_edit
    }
}
