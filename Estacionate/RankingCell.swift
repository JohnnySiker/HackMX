//
//  RankingCell.swift
//  Estacionate
//
//  Created by Israel Velazquez Sanchez on 07/03/15.
//  Copyright (c) 2015 Clipp. All rights reserved.
//

import UIKit

class RankingCell: UITableViewCell {

    @IBOutlet weak var lb_rank: UILabel!
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lb_score: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(content: [String]){
        lb_rank.text = content[0]
        lb_name.text = content[1]
        lb_score.text = content[2]
    }

}
