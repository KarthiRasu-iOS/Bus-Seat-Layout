//
//  RouteSelectionViewController.swift
//  BusLayout
//
//  Created by Karthi Rasu on 14/05/23.
//

import UIKit

class RouteSelectionViewController: UIViewController {

    @IBOutlet weak var busTypeCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviagtionbar()
        setupBusTypeCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Welcome"
    }
    
    func setupNaviagtionbar(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "person.crop.circle.fill"), style: .plain, target: nil, action: nil), animated: true)
    }
    
    func setupBusTypeCollectionView(){
        busTypeCollectionView.delegate = self
        busTypeCollectionView.dataSource = self
        busTypeCollectionView.register(UINib(nibName: "BusTypeCell", bundle: nil), forCellWithReuseIdentifier: "BusTypeCellID")
    }

}


extension RouteSelectionViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveToBusLayoutPage(index: indexPath.item)
    }
}

extension RouteSelectionViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BusType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let busTypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BusTypeCellID", for: indexPath) as! BusTypeCell
        busTypeCell.setupCell(data: BusType.allCases[indexPath.item])
        return busTypeCell
    }
}

extension RouteSelectionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width*0.5)-15, height: 120)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}


extension RouteSelectionViewController {
    func moveToBusLayoutPage(index:Int){
        let busType = BusType.allCases[index]
        if busType == .classic || busType == .deluxe {
            let busLayoutVC = getStoryboardRefrence(boardName: .main, vcName: .deluxeLayoutVC) as! DeluxeLayoutController
            busLayoutVC.busType = busType
            self.navigationController?.pushTo(controller: busLayoutVC)
        }else {
            let busLayoutVC = getStoryboardRefrence(boardName: .main, vcName: .sleeperLayoutVC) as! SleeperViewController
            busLayoutVC.busType = busType
            self.navigationController?.pushTo(controller: busLayoutVC)
        }
        
    }
}
