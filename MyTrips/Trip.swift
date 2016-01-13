//
//  Trip.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/6/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import Foundation
import UIKit

class Trip : NSObject {
    
    var name = "No Name"
    var defaultImage: UIImage? = nil
    var startDate: NSDate? = nil
    
    init(newName: String, start: NSDate)
    {
        self.name = newName
        self.startDate = start 
    }
    
    func deleteTrip()
    {
        
    }
    
}