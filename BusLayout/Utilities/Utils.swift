//
//  Utils.swift
//  BusLayout
//
//  Created by Karthi Rasu on 15/05/23.
//

import Foundation
import UIKit

//MARK: - Colors

extension UIColor{
    static let appThemeColor = UIColor(named: "AppThemeColor")!
    static let bookedSeatColor = UIColor(named: "BookedSeatColor")!
}

func getFourSeaterFrames(frame:CGRect,cellPadding:CGFloat)->[CGRect]{
    let collectionViewWidth = frame.size.width
    let cellWidth = frame.size.width / 4
    let cellHeight = frame.size.height + 10
    
    let firstCellXOffset = 0.0
    let secondCellXOffset = cellWidth - (cellPadding*3)
    let thirdCellXOffset = collectionViewWidth - (cellWidth*2)+CGFloat(cellPadding*3)
    let fourthCellXOffset = collectionViewWidth - cellWidth
    
    return [
        CGRect(x: firstCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: secondCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: thirdCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: fourthCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight)
    ]
}

func getFiveSeaterFrames(frame:CGRect,cellPadding:CGFloat)->[CGRect]{
    let collectionViewWidth = frame.size.width
    let cellWidth = frame.size.width / 5
    let cellHeight = frame.size.height
    let firstCellXOffset = 0.0
    let secondCellXOffset = cellWidth - (cellPadding*2)
    let thirdCellXOffset = collectionViewWidth - (cellWidth*3)+(cellPadding*4)
    let fourthCellXOffset = collectionViewWidth - (cellWidth*2)+(cellPadding*2)
    let fiveCellXOffset = collectionViewWidth - cellWidth
    
    return [
        CGRect(x: firstCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: secondCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: thirdCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: fourthCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: fiveCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight)
    ]
}

func getSixSeaterFrames(frame:CGRect,cellPadding:CGFloat)->[CGRect]{
    let collectionViewWidth = frame.size.width
    let cellWidth = frame.size.width / 5
    let cellHeight = frame.size.height
    let firstCellXOffset = 0.0
    let secondCellXOffset = cellWidth - (cellPadding*2)
    let thirdCellXOffset = cellWidth * 2 - (cellPadding*4)
    let fourthCellXOffset = collectionViewWidth - (cellWidth*3)+(cellPadding*4)
    let fiveCellXOffset = collectionViewWidth - (cellWidth*2)+(cellPadding*2)
    let sixthCellXOffset = collectionViewWidth - cellWidth
    
    return [
        CGRect(x: firstCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: secondCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: thirdCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: fourthCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: fiveCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: sixthCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight)
    ]
}

func getDoorSeaterFrames(frame:CGRect,cellPadding:CGFloat)->[CGRect]{
    let collectionViewWidth = frame.size.width
    let cellWidth = frame.size.width / 5
    let cellHeight = frame.size.height
    let firstCellXOffset = collectionViewWidth - (cellWidth*3)+(cellPadding*4)
    let secondsCellXOffset = collectionViewWidth - (cellWidth*2)+(cellPadding*2)
    let thirdCellXOffset = collectionViewWidth - cellWidth
    
    return [
        CGRect(x: firstCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: secondsCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: thirdCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight)
    ]
}

func getSleeperFrames(frame:CGRect,cellPadding:CGFloat)->[CGRect]{
    let collectionViewWidth = frame.size.width
    let cellWidth = frame.size.width / 4.5
    let cellHeight = frame.size.height
    
    let firstCellXOffset = 10.0
    let secondCellXOffset = collectionViewWidth - (cellWidth*2)+CGFloat(cellPadding*3)
    let thirdCellXOffset = collectionViewWidth - cellWidth
    
    return [
        CGRect(x: firstCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: secondCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: thirdCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight)
    ]
}

func getThreeSeaterFrames(frame:CGRect,cellPadding:CGFloat)->[CGRect]{
    let collectionViewWidth = frame.size.width
    let cellWidth = frame.size.width / 4
    let cellHeight = frame.size.height + 10
    
    let firstCellXOffset = 0.0
    let secondCellXOffset = collectionViewWidth - (cellWidth*2)+CGFloat(cellPadding*3)
    let thirdCellXOffset = collectionViewWidth - cellWidth
    
    return [
        CGRect(x: firstCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: secondCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
        CGRect(x: thirdCellXOffset, y: frame.origin.y, width: cellWidth, height: cellHeight),
    ]
}

extension UIView {
    func setupCornersWithShadow(cornerRadius:CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
    }
}

extension Array {
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}
