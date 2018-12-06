//
//  LeftViewControllerCell.swift
//  loginSignup
//
//  Created by apple on 11/28/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class LeftViewControllerCell: UITableViewCell {

    
    @IBOutlet var leftControllerCell: UIView!
    @IBOutlet var leftControllerLable: UILabel!
    @IBOutlet var leftControllerImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
