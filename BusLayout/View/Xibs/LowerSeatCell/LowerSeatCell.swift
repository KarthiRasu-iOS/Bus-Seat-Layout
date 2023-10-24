//
//  LowerSeatCell.swift
//  BusLayout
//
//  Created by Karthi Rasu on 14/05/23.
//

import UIKit

class LowerSeatCell: UICollectionViewCell {
    
    @IBOutlet weak var seatImg:UIImageView!
    @IBOutlet weak var seatNumberLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
