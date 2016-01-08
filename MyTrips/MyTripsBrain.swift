//
//  MyTripsBrain.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/6/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import Foundation
import UIKit


class MyTripsBrain {
    
    var list: [Year]
    
    init()
    {
        // Make a year
        let year = Year(date: NSDate())
        list = [year]
        
        // Make a dummy trip
        let newTrip = Trip()
        newTrip.name = "New Trip"
        newTrip.defaultImage = UIImage(named: "SquareCirclePlus")
        year.trips = [newTrip]
    }
    
/*    func makeNewTripRequestImage() -> UIImage
    {
        let cirle = UIImage(named: "SquareCirclePlus")
        let newImage = scaleUIImageToSize(cirle!, size: CGSize(width: 50.0, height: 50.0))
        
        return newImage
    }
    
    /*
    Image Resizing Techniques: http://bit.ly/1Hv0T6i
    */
    func scaleUIImageToSize(let image: UIImage, let size: CGSize) -> UIImage {
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        //let theSize = CGSize(width: 100.0, height: 100.0)
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
*/
}