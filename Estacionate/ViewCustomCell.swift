//
//  ViewCustomCell.swift
//  DogOrNot
//
//  Created by Aldo Antonio Martinez Avalos on 25/02/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class ViewCustomCell: UITableViewCell {
    
    var img:UIImageView!
    var lbl:UILabel!
    var notif:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setCell(img_name:String, lbl_name:String,notif_name:String){
        
        self.backgroundColor = UIColor.clearColor()
        
        img = UIImageView()
        lbl = UILabel()
        notif = UIImageView()
        
        self.img.image = UIImage(named:img_name)
        self.lbl.text = lbl_name
        self.notif.image = UIImage(named: notif_name)
        
        self.img.frame = CGRect(x:20,y:15,width:20,height:20)
        self.lbl.frame = CGRect(x:50,y:15,width:150,height:30)
        self.notif.frame = CGRect(x: 190, y: 10, width: 10, height: 10)
        
        self.contentView.addSubview(img)
        self.contentView.addSubview(lbl)
        self.contentView.addSubview(notif)
    }
    
}

