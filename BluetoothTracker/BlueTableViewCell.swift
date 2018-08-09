//
//  BlueTableViewCell.swift
//  BluetoothTracker
//
//  Created by 洋蔥胖 on 2018/8/9.
//  Copyright © 2018年 ChrisYoung. All rights reserved.
//

import UIKit

class BlueTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
