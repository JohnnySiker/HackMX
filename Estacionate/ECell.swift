//
//  ECell.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class ECell: UITableViewCell {

    @IBOutlet weak var lb_news: UILabel!
    
    @IBOutlet weak var btn_report: UIButton!
    @IBOutlet weak var btn_photo: UIButton!
    @IBOutlet weak var btn_like: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(news: String){
        
            lb_news.text = news
       
        
    }

}
