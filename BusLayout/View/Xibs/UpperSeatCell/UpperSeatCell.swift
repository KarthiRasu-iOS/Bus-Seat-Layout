//
//  UpperSeatCell.swift
//  BusLayout
//
//  Created by Karthi Rasu on 21/05/23.
//

import UIKit

class UpperSeatCell: UICollectionViewCell {
    @IBOutlet weak var seatImg : UIImageView!
    @IBOutlet weak var seatNumberLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        seatImg.contentMode = .scaleAspectFit
    }
    
    func configure(seatData:SeatModel){
        seatNumberLbl.text = seatData.seatNumber
        switch seatData.seatReserverType {
        case .booked:
            seatImg.tintColor = .bookedSeatColor
        case .empty:
            seatImg.tintColor = .lightGray
        case .selected:
            seatImg.tintColor = .appThemeColor
        }
        if seatData.seatReserverType == .booked {
            self.isUserInteractionEnabled = false
        }else{
            self.isUserInteractionEnabled = true
        }
    }

}
