//
//  DetailViewCellTableViewCell.swift
//  loginSignup
//
//  Created by apple on 10/29/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class DetailViewCellTableViewCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var backgroundCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
