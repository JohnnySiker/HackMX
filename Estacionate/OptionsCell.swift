//
//  OptionsCell.swift
//  Estacionate
//
//  Created by Aldo Antonio Martinez Avalos on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class OptionsCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setText(text:String){
        self.lbl.text = text
    }


}
