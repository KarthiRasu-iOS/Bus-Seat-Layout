//
//  SeatLayoutViewModel.swift
//  BusLayout
//
//  Created by Karthi Rasu on 15/05/23.
//

import Foundation

class BusSeatsViewModel {
    private init(){}
    static let shared = BusSeatsViewModel()
    var seats = [SeatModel]()
    
    func generateSeatsForDeluxeModel(){
        seats.removeAll()
        for seat in 1...(4*10){ //it will generate seats for (n*n) =  (2*2) for seats
            let seat = seat%4 == 1 || seat%4 == 0 ? "W" : "A"
            seats.append(SeatModel(seatNumber: "\(seats.count+1)\(seat)", seatReserverType: .empty, seatType: .fourSeater))
        }
       _ = seats[randomPick: 5].map { seat in
            seat.seatReserverType = .booked
        }
    }
    
    func generateSeatsForClassicModel(){
        seats.removeAll()
        for seat in 1...5{
            let seat = seat == 1 || seat == 5 ? "W" : "A"
            seats.append(SeatModel(seatNumber: "\(seats.count+1)\(seat)", seatReserverType: .empty, seatType: .fiveSeater))
        }
        
        for seat in 1...3{
            let seat = seat == 3 ? "W" : "A"
            seats.append(SeatModel(seatNumber: "\(seats.count+1)\(seat)", seatReserverType: .empty, seatType: .doorSeater))
        }
        
        for seat in 1...20{
            let seat = seat == 1 || seat%5==0 ? "W" : "A"
            seats.append(SeatModel(seatNumber: "\(seats.count+1)\(seat)", seatReserverType: .empty, seatType: .fiveSeater))
        }
        
        for seat in 1...3{
            let seat = seat == 3 ? "W" : "A"
            seats.append(SeatModel(seatNumber: "\(seats.count+1)\(seat)", seatReserverType: .empty, seatType: .doorSeater))
        }
        for seat in 1...6{
            let seat = seat == 1 || seat == 6 ? "W" : "A"
            seats.append(SeatModel(seatNumber: "\(seats.count+1)\(seat)", seatReserverType: .empty, seatType: .backSixSeater))
        }
        _ = seats[randomPick: 10].map { seat in
             seat.seatReserverType = .booked
         }
    }
}

class SleeperSeatsViewModel{
    private init(){}
    static let shared = SleeperSeatsViewModel()
    var lowerSeats = [SeatModel]()
    var upperSeats = [SeatModel]()
    
    func generateSeatsForSleeperModel(){
        lowerSeats.removeAll()
        upperSeats.removeAll()
        for _ in 1...(5*3){
            lowerSeats.append(SeatModel(seatNumber: "\(lowerSeats.count+1)LB", seatReserverType: .empty, seatType: .sleeper))
            upperSeats.append(SeatModel(seatNumber: "\(upperSeats.count+1)UB", seatReserverType: .empty, seatType: .sleeper))
        }
        _ = lowerSeats[randomPick: 3].map { seat in
             seat.seatReserverType = .booked
         }
        _ = upperSeats[randomPick: 5].map { seat in
             seat.seatReserverType = .booked
         }
    }
    
    func generateSeatsForCumSleeperModel(){
        lowerSeats.removeAll()
        upperSeats.removeAll()
        for seat in 1...(3*6){
            let seat = seat%3  == 1 || seat%3==0 ? "W" : "A"
            lowerSeats.append(SeatModel(seatNumber: "\(lowerSeats.count+1)\(seat)", seatReserverType: .empty, seatType: .threeSeater))
        }
        
        for j in 1...4{
            let seatType =  (j == 1 || j == 4) ? "W" : "A"
            lowerSeats.append(SeatModel(seatNumber: "\(lowerSeats.count+1)\(seatType)", seatReserverType: .empty, seatType: .fourSeater))
        }
        
        for _ in 1...(5*3){
            upperSeats.append(SeatModel(seatNumber: "\(upperSeats.count+1)UB", seatReserverType: .empty, seatType: .sleeper))
        }
        _ = lowerSeats[randomPick: 3].map { seat in
             seat.seatReserverType = .booked
         }
        _ = upperSeats[randomPick: 5].map { seat in
             seat.seatReserverType = .booked
         }
    }
}
