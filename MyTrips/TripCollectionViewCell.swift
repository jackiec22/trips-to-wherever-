//
//  TripCollectionViewCell.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/6/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import UIKit

class TripCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var locationName = " " {
        didSet {
            label.text = locationName
        }
    }
    
    var cellImage: UIImage? = nil {
        didSet {
            image.image = cellImage
            image.contentMode = .ScaleAspectFit
        }
    }
    
}
