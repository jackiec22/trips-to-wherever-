//
//  Year.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/6/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import Foundation

class Year {
    
    var thisDate: NSDate? = nil
    var trips: [Trip]? = nil
    
    init(date: NSDate)
    {
        self.thisDate = date
    }
}