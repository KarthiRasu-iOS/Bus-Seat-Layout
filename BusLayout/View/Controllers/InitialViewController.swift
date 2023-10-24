//
//  InitialViewController.swift
//  BusLayout
//
//  Created by Karthi Rasu on 11/05/23.
//

import UIKit

class InitialViewController: UIViewController {
    
    var timer : Timer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gif = UIImage.gifImageWithName("bus_splash_gif")
        let gifImageView = UIImageView()
        gifImageView.image = gif
        gifImageView.contentMode = .scaleAspectFit
        self.view.addSubview(gifImageView)
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        gifImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        gifImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        gifImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        gifImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        startTimerToPushRoutePage()
    }
    
    func startTimerToPushRoutePage(){
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(pushToRoutePage), userInfo: nil, repeats: false)
    }
    
    @objc func pushToRoutePage(){
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        let routeVC = getStoryboardRefrence(boardName: .main, vcName: .routeSelectionVC)
        self.navigationController?.pushTo(controller: routeVC)
    }
}

