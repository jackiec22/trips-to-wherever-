//
//  TripSettingsViewController.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/8/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import UIKit

class TripSettingsViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    
    var tripsBrain: MyTripsBrain? = nil  // passed in
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "New Trip"
        
        // add the save button to the top bar
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Save , target: self, action: "saveButtonPushed")
        self.navigationItem.rightBarButtonItem = button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func saveButtonPushed()
    {
        guard tripsBrain != nil else { return }
        
        guard nameText.text != nil && nameText.text != "" else {
            let alert = UIAlertController(title: "Enter a name for the trip", message: "(name can be changed later)", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(alertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // create the new trip
        let newTrip = Trip(newName: nameText.text!,start: NSDate())  // this needs to be changed
        
        
        // add the new trip to the main list
        tripsBrain!.addTrip(newTrip)
        
        // return to the main screen?
        if let navController = navigationController {
            navController.popViewControllerAnimated(true)
        }
        
    }

}
