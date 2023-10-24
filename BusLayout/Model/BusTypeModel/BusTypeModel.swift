//
//  BusTypeModel.swift
//  BusLayout
//
//  Created by Karthi Rasu on 14/05/23.
//

import Foundation

enum BusType : String , CaseIterable {
    case deluxe = "Deluxe"
    case classic = "Classic"
    case sleeper = "Sleeper"
    case cumsleeper = "Cum Sleeper"
    
    var info:(name:String,image:String,type:Self){
        switch self{
        case .deluxe:
            return (rawValue,"bus1",self)
        case .classic:
            return (rawValue,"bus2",self)
        case .sleeper:
            return (rawValue,"bus3",self)
        case .cumsleeper:
            return (rawValue,"bus4",self)
        }
    }
}
