//
//  UpperHeaderCell.swift
//  BusLayout
//
//  Created by Karthi Rasu on 22/05/23.
//

import UIKit

class UpperHeaderCell: UICollectionReusableView {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var wrapperView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperView.layer.cornerRadius = 5
        wrapperView.layer.borderColor = UIColor.appThemeColor.cgColor
        wrapperView.layer.borderWidth = 1.5
    }
    
}
