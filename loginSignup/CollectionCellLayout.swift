//
//  CollectionCellLayout.swift
//  loginSignup
//
//  Created by apple on 11/13/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class CollectionCellLayout: UICollectionViewFlowLayout {
    
    var numberOfColumn: Int = 3
    init(numberOfColumn: Int ){
        super.init()
        self.numberOfColumn = numberOfColumn
        self.minimumInteritemSpacing = 4
        self.minimumLineSpacing = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var itemSize: CGSize {
        get{
            if let collectionView = collectionView{
                let collectionViewWidth = collectionView.frame.width
                let itemWidth = (collectionViewWidth/CGFloat(self.numberOfColumn)-self.minimumInteritemSpacing)
                let itemHeight: CGFloat = 100
                
                return CGSize(width: itemWidth, height: itemHeight)
            }
            return CGSize(width: 100, height: 100)
        }
        set{
            super.itemSize = newValue
        }
        
        
    }
    
    
}
