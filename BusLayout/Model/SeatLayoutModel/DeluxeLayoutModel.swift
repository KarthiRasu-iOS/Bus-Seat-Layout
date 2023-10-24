//
//  DeluxeLayoutModel.swift
//  BusLayout
//
//  Created by Karthi Rasu on 15/05/23.
//

import Foundation

class DeluxeLayoutModel {
    internal init(seatNumber: String, isSelected: Bool) {
        self.seatNumber = seatNumber
        self.isSelected = isSelected
    }
    
    let seatNumber : String
    var isSelected : Bool
}

enum SeatLayoutType {
    case fourSeater
    case fiveSeater
    case doorSeater
    case backFourSeater
    case backSixSeater
    case sleeper
    case threeSeater
}

enum SeatReserveType{
    case empty
    case booked
    case selected
}

class SeatModel{
    internal init(seatNumber: String, seatReserverType: SeatReserveType, seatType: SeatLayoutType) {
        self.seatNumber = seatNumber
        self.seatReserverType = seatReserverType
        self.seatType = seatType
    }
    
    let seatNumber : String
    var seatReserverType : SeatReserveType
    let seatType : SeatLayoutType
}


