//
//  BusTypeCell.swift
//  BusLayout
//
//  Created by Karthi Rasu on 14/05/23.
//

import UIKit

class BusTypeCell: UICollectionViewCell {
    
    @IBOutlet weak var wrapperView : UIView!
    @IBOutlet weak var busImgView : UIImageView!
    @IBOutlet weak var busTypeLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperView.setupCornersWithShadow(cornerRadius: 12)
    }
    
    func setupCell(data:BusType){
        busTypeLbl.text = data.info.name
        busImgView.image = UIImage(named: data.info.image)
    }
}
