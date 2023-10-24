//
//  SleeperViewController.swift
//  BusLayout
//
//  Created by Karthi Rasu on 21/05/23.
//

import UIKit

class SleeperViewController: UIViewController {

    @IBOutlet weak var busLayoutCollectionView : UICollectionView!
    @IBOutlet weak var seatCountLbl : UILabel!
    let seatsVM = SleeperSeatsViewModel.shared
    var busType : BusType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = busType else {
            self.navigationController?.popViewController(animated: false)
            return
        }
        setupNaviagtionBar()
        switch busType?.info.type {
        case .deluxe:
            break
        case .classic:
            break
        case .sleeper:
            seatsVM.generateSeatsForSleeperModel()
        case .cumsleeper:
            seatsVM.generateSeatsForCumSleeperModel()
        default:
            break
        }
        setupBusLayoutCollectionView()
    }

    func setupNaviagtionBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.backItem?.title = "back"
        self.title = busType?.info.name
    }
    
    func setupBusLayoutCollectionView(){
        busLayoutCollectionView.delegate = self
        busLayoutCollectionView.dataSource = self
        busLayoutCollectionView.register(UINib(nibName: "LowerSeatCell", bundle: nil), forCellWithReuseIdentifier: "LowerSeatCellID")
        busLayoutCollectionView.register(UINib(nibName: "UpperSeatCell", bundle: nil), forCellWithReuseIdentifier: "UpperSeatCellID")
        busLayoutCollectionView.register(UINib(nibName: "UpperHeaderCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "UpperHeaderCellID")

        let layout = DeluxeLayout()
        layout.delegate = self
        busLayoutCollectionView.collectionViewLayout = layout
    }
}

//MARK: - LayoutDelegate

extension SleeperViewController : DeluxeSeatsDelegate{
    func getBysType() -> BusType? {
        return busType
    }
    
    func getSeatLayoutType(_ collectionView: UICollectionView, for indexPath: IndexPath) -> (SeatLayoutType, CGFloat, CGFloat) {
        let seatType = indexPath.section == 0 ? seatsVM.lowerSeats[indexPath.item].seatType : seatsVM.upperSeats[indexPath.item].seatType
        let height = seatType == .sleeper ? 140.0 : 90.0
        let inset = seatType == .sleeper ? 0.0 : 10.0
        return (seatType,height,inset)
    }
}

//MARK: - CollectionView Delegate

extension SleeperViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updatedSelectedSeat(index: indexPath)
    }
}

//MARK: - CollectionView Datasource

extension SleeperViewController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return seatsVM.lowerSeats.count
        }else {
            return seatsVM.upperSeats.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let seatData = indexPath.section == 0 ? seatsVM.lowerSeats[indexPath.item] : seatsVM.upperSeats[indexPath.item]
        
        if seatData.seatType == .sleeper {
            let upperCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpperSeatCellID", for: indexPath) as! UpperSeatCell
            upperCell.configure(seatData: seatData)
            return upperCell
        }else {
            let lowerSeatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LowerSeatCellID", for: indexPath) as! LowerSeatCell
            lowerSeatCell.configure(seatData: seatData)
            return lowerSeatCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if busType?.info.type == .cumsleeper || busType?.info.type == .sleeper {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UpperHeaderCellID", for: indexPath) as! UpperHeaderCell
            headerView.backgroundColor = .appThemeColor
            if indexPath.section == 0{
                headerView.titleLbl.text = "Lower Seats"
            }else{
                headerView.titleLbl.text = "Upper Seats"
            }
            return headerView
        }else{
            return UICollectionReusableView()
        }
    }
}

//MARK: - Seat Selection

extension SleeperViewController {
    func updatedSelectedSeat(index:IndexPath){
        if index.section == 0{
            seatsVM.lowerSeats[index.item].seatReserverType =  seatsVM.lowerSeats[index.item].seatReserverType == .selected ?  .empty : .selected
        }else{
            seatsVM.upperSeats[index.item].seatReserverType =  seatsVM.upperSeats[index.item].seatReserverType == .selected ?  .empty : .selected
        }
        
        busLayoutCollectionView.reloadData()
        
        let lower_count =  seatsVM.lowerSeats.filter { seat in
            seat.seatReserverType == .selected
        }.count
        let upper_count =  seatsVM.upperSeats.filter { seat in
            seat.seatReserverType == .selected
        }.count
        
        seatCountLbl.text = "\(lower_count+upper_count)"
    }
}
