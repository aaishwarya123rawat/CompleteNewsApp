//
//  SmallViewTableViewCell.swift
//  loginSignup
//
//  Created by apple on 12/6/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class SmallViewTableViewCell: UITableViewCell {

    @IBOutlet var samallCellImg: UIImageView!
    
    @IBOutlet var smallCellTitleLbl: UILabel!
    
    @IBOutlet var smallCellSourceLbl: UILabel!
    
    
    @IBOutlet var smallCellDateLbl: UILabel!
    
    
    @IBOutlet var samllCellCardViewBgLbl: UIView!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
