//
//  CreateTableVC.swift
//  MyEntry
//
//  Created by Kinjal panchal on 13/02/22.
//

import UIKit
import SwiftUI


class tableCollectionCell : UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    func setData(tableType: TableType,isSelected:Bool) {
        self.borderColor = isSelected ? .systemBlue : .white
        self.borderWidth = isSelected ? 2 : 0
        //setImage(tableType: tableType)
    }
    
//    func setImage(tableType: TableType) {
//        switch tableType {
//
//        case .circle:
//            imageView.image = UIImage(named: "ic_shape_circle")
//        case .square:
//            imageView.image = UIImage(named: "ic_shape_square")
//        case .rectangle:
//            imageView.image = UIImage(named: "ic_shape_rectangle")
//        }
//    }
}

class CreateTableVC: UIViewController {

    @IBOutlet weak var tableCollectionView: UICollectionView!
    @IBOutlet weak var circularView: UIView!
    
    var selectedTableShape : TableType = .rectangle
    
    var tableData: CreateTableReqModel = CreateTableReqModel()
    
    var totalSits : Int {
        switch selectedTableShape {
        case .circle:
            return 6
        case .square:
            return 6
        case .rectangle:
            return 8
        }
        return 6
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initaliseModel()
        
        setTableView()
        // Do any additional setup after loading the view.
        
        self.tableCollectionView.isScrollEnabled = false
    }
    
    func initaliseModel() {
        
        tableData.totalSit = totalSits
        tableData.notes = ""
        tableData.table_id = 1
        tableData.tableType = TableType.circle.rawValue
    }
    
    func updateTableData() {
        tableData.totalSit = totalSits
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setTableView() {
        
        if let view = circularView.subviews.filter({ $0.tag == 1000}).first {
            view.removeFromSuperview()
        }
        
        switch selectedTableShape {
        case .circle:
            setupCircularTableView()
        case .square:
            setupSquareTableView()
        case .rectangle:
            setupRectangleTableView()
        }
    }
    
    private func setupCircularTableView(tableType: TableType = .circle) {
        let sheats: [Sheat] = [.init(title: "1", isFilled: false), .init(title: "2", isFilled: true), .init(title: "3", isFilled: false), .init(title: "VIP", isFilled: false), .init(title: "4", isFilled: false), .init(title: "5", isFilled: false)]
        let circleTable = CircleTableView(seats: sheats) { index, sheat in
            if let vc = AddGuestVC.instantiate(appStoryboard: .main) as? AddGuestVC {
                vc.isFromAddTableScreen = true
                
                vc.selectedGuest = { guest in
                    print("selected user for sit \(index) : \(guest?.username)")
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
                sheat.isFilled.toggle()
            }
        }.frame(width: circularView.frame.width, height: circularView.frame.height)
        guard let finalView = UIHostingController(rootView: circleTable).view else { return  }
        circularView.addSubview(finalView)
        finalView.backgroundColor = .clear
        finalView.translatesAutoresizingMaskIntoConstraints = false
        finalView.setAllSideContraints(.zero)
        finalView.tag = 1000

    }
    
    
    private func setupSquareTableView(tableType: TableType = .circle) {
        let sheats: [Sheat] = [
                .init(title: "1", isFilled: false),
                .init(title: "2", isFilled: true),
                .init(title: "3", isFilled: false),
                .init(title: "4", isFilled: false),
                .init(title: "5", isFilled: false),
                .init(title: "6", isFilled: false),
                .init(title: "7", isFilled: false),
                .init(title: "8", isFilled: false)]
    
        let squareTable = SquareTableView(seats: sheats) { index, sheat in
            if let vc = AddGuestVC.instantiate(appStoryboard: .main) as? AddGuestVC {
                vc.isFromAddTableScreen = true
                
                vc.selectedGuest = { guest in
                    print("selected user for sit \(index) : \(guest?.username)")
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
                sheat.isFilled.toggle()
            }
        }.frame(width: circularView.frame.width, height: circularView.frame.height)
        guard let finalView = UIHostingController(rootView: squareTable).view else { return  }
        circularView.addSubview(finalView)
        finalView.backgroundColor = .clear
        finalView.translatesAutoresizingMaskIntoConstraints = false
        finalView.setAllSideContraints(.zero)
        finalView.tag = 1000
    }
    
    
    private func setupRectangleTableView(tableType: TableType = .rectangle) {
        let sheats: [Sheat] = [
                .init(title: "1", isFilled: false),
                .init(title: "2", isFilled: true),
                .init(title: "3", isFilled: false),
                .init(title: "4", isFilled: false),
                .init(title: "5", isFilled: false),
                .init(title: "6", isFilled: false),
                .init(title: "7", isFilled: false),
                .init(title: "8", isFilled: false)]
    
        let rectangleTable = RectangleTableView(seats: sheats) { index, sheat in
            if let vc = AddGuestVC.instantiate(appStoryboard: .main) as? AddGuestVC {
                vc.isFromAddTableScreen = true
                
                vc.selectedGuest = { guest in
                    print("selected user for sit \(index) : \(guest?.username)")
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
                sheat.isFilled.toggle()
            }
        }.frame(width: circularView.frame.width, height: circularView.frame.height)
        guard let finalView = UIHostingController(rootView: rectangleTable).view else { return  }
        circularView.addSubview(finalView)
        finalView.backgroundColor = .clear
        finalView.translatesAutoresizingMaskIntoConstraints = false
        finalView.setAllSideContraints(.zero)
        finalView.tag = 1000

    }

}

extension CreateTableVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tableCollectionCell", for: indexPath) as? tableCollectionCell {
            
            var isSelected : Bool = (indexPath.row + 1) == selectedTableShape.rawValue
            cell.setData(tableType: TableType(rawValue: indexPath.row + 1) ?? .circle,isSelected:isSelected)
            return cell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        selectedTableShape = TableType.init(rawValue: (indexPath.row + 1)) ?? TableType.circle
        
        print("selected Shape index :",indexPath)
        print("selectedTableShape :",selectedTableShape)
        print("total sits = ",totalSits)
        
        self.tableCollectionView.reloadData()
        setTableView()
    }
    
}

extension UIView {
    func setAllSideContraints(_ edges: UIEdgeInsets) {
        guard let superview = self.superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: edges.left),
             self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: edges.right),
             self.topAnchor.constraint(equalTo: superview.topAnchor, constant: edges.top),
             self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: edges.bottom)])
    }
}

// MARK: - Manage Tables Sit's tap
extension CreateTableVC {
    @objc func btnActionAddEvent() {
        let vc = EventTypesVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - webservice call
extension CreateTableVC {
    
    
    func webServiceCallAddTable(){
        let reqModel = CreateTableReqModel()
       /* reqModel.event_id = eventId
        reqModel.user_id = Singleton.sharedInstance.UserId
        reqModel.ticket_title = ticketTitle.text ?? ""
        reqModel.description = txtDescription.text ?? ""
        reqModel.type = txtType.text ?? ""
        reqModel.price = txtPricePerTicket.text ?? ""
        reqModel.quantity = txtQuantity.text ?? ""
        reqModel.price_per_ticket = txtPricePerTicket.text ?? ""
        reqModel.add_to_calendar = switchAddToCalender.isOn == true ? "yes" : "no"
        if viewSeatAllocation.isHidden == false {
            reqModel.seat_allocation = switchSeatAllocation.isOn == true ? "yes" : "no"
        }
        else {
            reqModel.seat_allocation = "no"
        }
        reqModel.maximum_ticket_per_person = txtMaximumPerson.text ?? ""
        reqModel.on_sale_until = txtOnSaleUntil.text ?? ""
        reqModel.allowed = txtType.text == "VIP" ? "yes" : "no"
        */
//        WebServiceSubClass.createTable(reqModel: reqModel) { status, message, response, error in
//            if status {
//                print(response)
//                AlertMessage.showMessageForSuccess(response?.message ?? "")
//            }
//            else {
//                AlertMessage.showMessageForError(message)
//            }
//        }
    }
}
