//
//  ContactTblCell.swift
//  MyEntry
//
//  Created by panchal kinjal  on 05/10/21.
//

import UIKit

class ContactTblCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblNumber: ThemTitleLabel!
    @IBOutlet weak var lblName: ThemTitleLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
