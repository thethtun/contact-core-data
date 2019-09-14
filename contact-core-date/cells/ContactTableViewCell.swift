//
//  ContatTableViewCell.swift
//  contact-core-date
//
//  Created by Thet Htun on 9/14/19.
//  Copyright © 2019 padc. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelUserName : UILabel!

    //obj
    var data : ContactVO? {
        didSet {
            if let data = data {
                labelUserName.text = data.username
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier : String {
        return String(describing : self)
    }

}
