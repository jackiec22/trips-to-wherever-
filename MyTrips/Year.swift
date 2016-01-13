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
    var trips: [Trip] = []
    
    init(date: NSDate)
    {
        self.thisDate = date
    }
    
    
    // given an index into the trip array, delete the trip at that index
    func deleteTripAtIndex(index: Int)
    {
        // remove from the array of trips
        let trip = trips.removeAtIndex(index)
        
        // remove the data from the trip?
        trip.deleteTrip()
    }
    
    func addTrip(newTrip: Trip)
    {
        trips.append(newTrip)
    }
}