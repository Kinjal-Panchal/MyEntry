//
//  ManageTblCell.swift
//  MyEntry
//
//  Created by Vipul Dungranee on 24/02/22.
//

import UIKit
import SwiftUI

class ManageTblCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var shapeContainerView: UIView!
    @IBOutlet weak var lblTables: UILabel!
    @IBOutlet weak var lblSeats: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    
    
    @IBOutlet weak var imgCircleAssigned: UIImageView!
    @IBOutlet weak var lblAssigned: UILabel!

    @IBOutlet weak var imgCircleVacant: UIImageView!
    @IBOutlet weak var lblVacant: UILabel!
    
    var onEditClick: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupUI() {
        
        containerView.cornerRadius = 18
        containerView.layer.masksToBounds = true
        
        btnEdit.cornerRadius = 18
        
    }
    
    
    @IBAction func onEditBtnClick(_ sender: Any) {
        self.onEditClick?()
    }
    
}

extension ManageTblCell {
    func congifureCellData(tableData: TableData) {
        self.lblTables.text = "\(String(describing: tableData.tableName ?? ""))" + ""
        self.lblSeats.text = "\(String(describing: tableData.totalSeats ?? 0)) Seats"

        self.lblAssigned.text = "\(String(describing: tableData.assignedSeats ?? 0)) assigned"
        self.lblVacant.text = "\(String(describing: tableData.vacantSeats ?? 0)) vacant"
        
        setShapeData()

    }
    
    func setShapeData() {
        let sheats: [Sheat] = [.init(title: "1", isFilled: false), .init(title: "2", isFilled: true), .init(title: "3", isFilled: false), .init(title: "VIP", isFilled: false), .init(title: "4", isFilled: false), .init(title: "5", isFilled: false)]
        let circleTable = CircleTableView(seats: sheats) { _, _ in
        }.frame(width: shapeContainerView.frame.width, height: shapeContainerView.frame.height)
        guard let finalView = UIHostingController(rootView: circleTable).view else { return  }
        shapeContainerView.addSubview(finalView)
        finalView.backgroundColor = .clear
        finalView.translatesAutoresizingMaskIntoConstraints = false
        finalView.setAllSideContraints(.zero)
    }
}


struct TableData {
    var tableName: String?
    var totalSeats: Int?
    var assignedSeats: Int?
    var vacantSeats: Int?
}
