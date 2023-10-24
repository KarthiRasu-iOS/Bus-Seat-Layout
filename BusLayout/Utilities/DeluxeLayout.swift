//
//  DeluxeLayout.swift
//  BusLayout
//
//  Created by Karthi Rasu on 14/05/23.
//

import UIKit

protocol DeluxeSeatsDelegate :AnyObject {
    func getBysType()->BusType?
    func getSeatLayoutType(_ collectionView:UICollectionView, for indexPath:IndexPath)->(SeatLayoutType,CGFloat,CGFloat) //seatType,height,insets
}

class DeluxeLayout : UICollectionViewLayout {
    
    weak var delegate : DeluxeSeatsDelegate!
    
    private var cache : [UICollectionViewLayoutAttributes] = []
    
    private var contentHeight : CGFloat = 0
    
    private var contentWidth : CGFloat {
        guard let collectionView = collectionView else { return 0.0}
        let inset = collectionView.contentInset
        return collectionView.bounds.width - (inset.left + inset.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        // 1
        guard
            cache.isEmpty,
            let collectionView = collectionView
        else {
            return
        }
       
        let busType = delegate.getBysType()?.info.type
        
        let sectionsCount = collectionView.numberOfSections
        for section in 0...sectionsCount-1 {
            var currentIndex = 0
            var reverseIndex = 0
            let count = collectionView.numberOfItems(inSection: section)
            if busType == .sleeper || busType == .cumsleeper {
                //MARK: - Upper Header
                let upperHeader = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: section))
                
                upperHeader.frame = CGRect(x: 0, y: contentHeight, width: contentWidth, height: 50)
                contentHeight = max(contentHeight, upperHeader.frame.maxY)
                cache.append(upperHeader)
            }
            while currentIndex < count{
                
                
                var segmentRects = [CGRect]()
                let indexPath = IndexPath(item: currentIndex, section: section)
                
                let (seatType,height,insets) = delegate.getSeatLayoutType(collectionView, for: indexPath)
                
                let segmentFrame = CGRect(x: 0, y: contentHeight, width: contentWidth, height: height)
                
                switch seatType{
                case .fourSeater:
                    segmentRects = getFourSeaterFrames(frame: segmentFrame, cellPadding: 10)
                    if currentIndex != 0 && reverseIndex % 2 != 0 {
                        segmentRects.reverse()
                    }
                case .fiveSeater:
                    segmentRects = getFiveSeaterFrames(frame: segmentFrame, cellPadding: 10)
                case .doorSeater:
                    segmentRects = getDoorSeaterFrames(frame: segmentFrame, cellPadding: 10)
                case .backFourSeater:
                    break
                case .backSixSeater:
                    segmentRects = getSixSeaterFrames(frame: segmentFrame, cellPadding: 10)
                case .sleeper:
                    segmentRects = getSleeperFrames(frame: segmentFrame, cellPadding: 10)
                case .threeSeater:
                    segmentRects = getThreeSeaterFrames(frame: segmentFrame, cellPadding: 10)
                    if currentIndex != 0 && reverseIndex % 2 != 0 {
                        segmentRects.reverse()
                    }
                }
                
                for rect in segmentRects {
                    let insetFrame = rect.insetBy(dx: insets, dy: insets)
                    let attributes = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: currentIndex, section: section))
                    attributes.frame = insetFrame
                    cache.append(attributes)
                    contentHeight = max(contentHeight, rect.maxY)
                    currentIndex += 1
                }
                reverseIndex += 1
                
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
      var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
      
      // Loop through the cache and look for items in the rect
      for attributes in cache {
        if attributes.frame.intersects(rect) {
          visibleLayoutAttributes.append(attributes)
        }
      }
      return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
        return attributes
    }
}
