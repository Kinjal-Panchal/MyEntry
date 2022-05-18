//
//  EditTableTblCell.swift
//  MyEntry
//
//  Created by Vipul Dungranee on 26/02/22.
//

import UIKit

class EditTableTblCell: UITableViewCell {

    @IBOutlet weak var lblIndex: UILabel!
    
    @IBOutlet weak var btnName: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onBtnClick(_ sender: Any) {
    }
    
}

extension EditTableTblCell {
    func configureCellData(data: TableDataSource) {
        lblIndex.text = "\(data.index ?? 0)"
        btnName.setTitle("\(data.name ?? "")", for: .normal)
    }
}

struct TableDataSource {
    var index: Int?
    var name: String?
}
