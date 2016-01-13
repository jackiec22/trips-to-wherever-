//
//  TripDetailViewController.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/7/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import UIKit

class TripDetailViewController: UIViewController {
    
    var theTrip: Trip? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let trip = theTrip {
            navigationItem.title = trip.name.capitalizedString
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
