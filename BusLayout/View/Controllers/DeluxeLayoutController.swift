//
//  DeluxeLayoutController.swift
//  BusLayout
//
//  Created by Karthi Rasu on 14/05/23.
//

import UIKit

class DeluxeLayoutController: UIViewController {

    @IBOutlet weak var busLayoutCollectionView : UICollectionView!
    @IBOutlet weak var seatCountLbl : UILabel!
    @IBOutlet weak var seatModeView : UIView!
    
    let seatsVM = BusSeatsViewModel.shared
    var busType : BusType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = busType else {
            self.navigationController?.popViewController(animated: false)
            return
        }
        setupDesignables()
        setupNaviagtionBar()
        switch busType?.info.type {
        case .deluxe:
            seatsVM.generateSeatsForDeluxeModel()
        case .classic:
            seatsVM.generateSeatsForClassicModel()
        case .sleeper:
            break
        case .cumsleeper:
            break
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
        let layout = DeluxeLayout()
        layout.delegate = self
        busLayoutCollectionView.collectionViewLayout = layout
    }
    
    func setupDesignables(){
        seatModeView.layer.borderColor = UIColor.lightGray.cgColor
        seatModeView.layer.borderWidth = 1
        seatModeView.layer.cornerRadius = 5
    }
}

//MARK: - LayoutDelegate

extension DeluxeLayoutController : DeluxeSeatsDelegate{
    func getBysType() -> BusType? {
        return busType
    }
    
    func getSeatLayoutType(_ collectionView: UICollectionView, for indexPath: IndexPath) -> (SeatLayoutType, CGFloat, CGFloat) {
        if seatsVM.seats[indexPath.item].seatType == .sleeper {
            return (seatsVM.seats[indexPath.item].seatType,140,0)

        }else{
            return (seatsVM.seats[indexPath.item].seatType,90,seatsVM.seats[indexPath.item].seatType == .fourSeater ? 10 : 0)

        }
    }
}

//MARK: - CollectionView Delegate

extension DeluxeLayoutController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updatedSelectedSeat(index: indexPath)
    }
}

//MARK: - CollectionView Datasource

extension DeluxeLayoutController : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch busType?.info.type {
        case .classic , .deluxe :
            return 1
        case .sleeper , .cumsleeper :
            return 2
        default :
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seatsVM.seats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch busType?.info.type {
        case .classic , .deluxe:
            let lowerSeatCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LowerSeatCellID", for: indexPath) as! LowerSeatCell
            lowerSeatCell.configure(seatData: seatsVM.seats[indexPath.item])
            return lowerSeatCell
        case .sleeper , .cumsleeper:
            let upperCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpperSeatCellID", for: indexPath) as! UpperSeatCell
            upperCell.configure(seatData: seatsVM.seats[indexPath.item])
            return upperCell
        default :
            return UICollectionViewCell()
        }
    }
}

//MARK: - Seat Selection

extension DeluxeLayoutController {
    func updatedSelectedSeat(index:IndexPath){
        seatsVM.seats[index.item].seatReserverType =  seatsVM.seats[index.item].seatReserverType == .selected ?  .empty : .selected
        
        busLayoutCollectionView.reloadItems(at: [index])
       let count =  seatsVM.seats.filter { seat in
           seat.seatReserverType == .selected
        }.count
        seatCountLbl.text = "\(count)"
    }
}
