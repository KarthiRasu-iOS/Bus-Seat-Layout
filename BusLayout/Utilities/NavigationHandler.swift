//
//  NavigationHandler.swift
//  BusLayout
//
//  Created by Karthi Rasu on 14/05/23.
//

import UIKit
enum StoryBoards : String {
    case main = "Main"
}

enum ControllersID : String {
    case routeSelectionVC = "RouteSelectionVCID"
    case deluxeLayoutVC = "DeluxeLayoutVCID"
    case sleeperLayoutVC = "SleeperLayoutVCID"
}

func getStoryboardRefrence(boardName:StoryBoards,vcName:ControllersID)->UIViewController{
    let storyboard = UIStoryboard(name: boardName.rawValue, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: vcName.rawValue)
}

extension UINavigationController{
    func pushTo(controller:UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        view.layer.add(transition, forKey: nil)
        pushViewController(controller, animated: false)
    }
}
