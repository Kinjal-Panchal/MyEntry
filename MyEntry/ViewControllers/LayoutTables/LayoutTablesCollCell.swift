//
//  LayoutTablesCollCell.swift
//  MyEntry
//
//  Created by Vipul Dungranee on 25/02/22.
//

import UIKit
import SwiftUI

class LayoutTablesCollCell: UICollectionViewCell {

    @IBOutlet weak var ContentView: UIView!
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

}

extension LayoutTablesCollCell {
    func congifureCellData(tableData: TableData) {
        setShapeData()
    }
    
    func setShapeData() {
        let sheats: [Sheat] = [.init(title: "1", isFilled: false), .init(title: "2", isFilled: true), .init(title: "3", isFilled: false), .init(title: "VIP", isFilled: false), .init(title: "4", isFilled: false), .init(title: "5", isFilled: false)]
        let circleTable = CircleTableView(seats: sheats) { _, _ in
        }.frame(width: containerView.frame.width, height: containerView.frame.height)
        guard let finalView = UIHostingController(rootView: circleTable).view else { return  }
        containerView.addSubview(finalView)
        finalView.backgroundColor = .clear
        finalView.translatesAutoresizingMaskIntoConstraints = false
        finalView.setAllSideContraints(.zero)
    }
}

