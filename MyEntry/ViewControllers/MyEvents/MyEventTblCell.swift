//
//  MyEventTblCell.swift
//  MyEntry
//
//  Created by Kinjal Panchal on 20/10/21.
//

import UIKit

class MyEventTblCell: UITableViewCell {
    
    @IBOutlet weak var imgTemplate: UIImageView!
    @IBOutlet weak var userCollectionview: UICollectionView!
    @IBOutlet weak var lblEventTime: ThemTitleLabel!
    @IBOutlet weak var lblHosted: ThemTitleLabel!
    @IBOutlet weak var lblEventName: ThemTitleLabel!
    
    
    var btnClicked : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userCollectionview.dataSource = self
        userCollectionview.delegate = self
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func btnActionDetail(_ sender: UIButton) {
        if let clicked = btnClicked{
            clicked()
        }
    }
}

extension MyEventTblCell : UICollectionViewDataSource , UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCollectionviewCell", for: indexPath) as! UserCollectionviewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: userCollectionview.frame.width/3, height: userCollectionview.frame.height)
    }
    
    
}
