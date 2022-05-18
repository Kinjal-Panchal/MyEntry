//
//  EditTableVC.swift
//  MyEntry
//
//  Created by Vipul Dungranee on 26/02/22.
//

import UIKit
import SwiftUI
class EditTableVC: UIViewController {

    
    @IBOutlet weak var shapeView: UIView!
    @IBOutlet weak var tblContainerView: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    var tableData: [TableDataSource] = [TableDataSource]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircularTableView()
        
        tblView.register(UINib(nibName: "ManageTblCell", bundle: nil), forCellReuseIdentifier: "ManageTblCell")
        setDummyTableData()
        
        tblContainerView.cornerRadius = 20
        tblContainerView.layer.masksToBounds = true

    }
    
    

    func setDummyTableData(){
        for i in 0...5 {
            var data = TableDataSource()
            data.name = "Table \(i)"
            data.index = i + 1
            tableData.append(data)
        }
        
        tblView.reloadData()
    }
    
    @IBAction func btnActionBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
        }.frame(width: shapeView.frame.width, height: shapeView.frame.height)
        guard let finalView = UIHostingController(rootView: circleTable).view else { return  }
        shapeView.addSubview(finalView)
        finalView.backgroundColor = .clear
        finalView.translatesAutoresizingMaskIntoConstraints = false
        finalView.setAllSideContraints(.zero)
    }
    
    
    private func setupSquareTableView(tableType: TableType = .square) {
        //setup square table here
    }
    
    
    private func setupRectangleTableView(tableType: TableType = .rectangle) {
        //setup rectangle table here
    }

}


// MARK: - Manage Tables Sit's tap
extension EditEventVC {
    @objc func btnActionAddEvent() {
        let vc = EventTypesVC.instantiate(appStoryboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - webservice call
extension EditTableVC {
    
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



// MARK: UITableViewDataSource
extension EditTableVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "EditTableTblCell") as? EditTableTblCell {
            
            cell.configureCellData(data: tableData[indexPath.row])
            print("table[\(indexPath.row)] \(tableData[indexPath.row])")
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

// MARK: UITableViewDataSource
extension EditTableVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
