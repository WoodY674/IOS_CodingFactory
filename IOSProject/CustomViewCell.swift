//
//  CustomViewCell.swift
//  IOSProject
//
//  Created by admin on 02/03/2022.
//

import UIKit

class CustomViewCell: UITableViewCell {

    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var countrynameLabel: UILabel!
    @IBOutlet weak var countryFlag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
