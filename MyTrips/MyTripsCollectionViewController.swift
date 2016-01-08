//
//  MyTripsCollectionViewController.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/6/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import UIKit



class MyTripsCollectionViewController: UICollectionViewController {
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0)
    private let reuseIdentifier = "TripViewCell"
    
    var theYears = MyTripsBrain()
    var saveSelectedIndexPath: NSIndexPath? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        title = "My Vacations"
        
        // add the edit button
        navigationItem.leftBarButtonItem = editButtonItem()
        
        // add the toolbar
        let toolbar = UIToolbar(frame: CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44))
        //toolbar.autoresizingMask = UIViewAutoresizing.FlexibleWidth // UIViewAutoresizing.FlexibleTopMargin
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: "deleteButtonPushed")
        toolbar.items = [button]
        self.view.addSubview(toolbar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // highlighted cell before pushed to detail viewcontroller, so now unhighlight it
        if let indexPath = saveSelectedIndexPath {
            highlightCell(indexPath, flag: false)
            saveSelectedIndexPath = nil
        }
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var destination: UIViewController? = segue.destinationViewController
        
        // this next if-statement makes sure the segue prepares properly even
        //   if the MVC we're seguing to is wrapped in a UINavigationController
        if let navCon = destination as? UINavigationController {
            destination = navCon.visibleViewController
            if destination == nil { return }
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let identifier = segue.identifier {
            switch identifier {
                
            case "TripSelected":
                let cell = sender as! UICollectionViewCell
                if let indexPath = collectionView!.indexPathForCell(cell) {
                    let seguedToMVC = destination as! TripDetailViewController
                    
                    // pass the correct table to the tableview
                    seguedToMVC.theTrip = theYears.list[indexPath.section].trips![indexPath.row]
                    
                    // prevent the back button fro taking the title of this view
                    let backItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                    navigationItem.backBarButtonItem = backItem
                    
                    // Save the selected indexPath
                    saveSelectedIndexPath = indexPath
                    
                }
                
            default: break
                
            }
        }
    }

    


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return theYears.list.count
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let year = theYears.list[section]
        guard year.trips != nil else { return 0 }
        return year.trips!.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let year = theYears.list[indexPath.section]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TripCollectionViewCell
    
        // Configure the cell
        cell.backgroundColor = UIColor.grayColor()
        cell.locationName = year.trips![indexPath.row].name
        cell.cellImage = year.trips![indexPath.row].defaultImage
        
        return cell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
            //1
            switch kind {
                //2
            case UICollectionElementKindSectionHeader:
                //3
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                    withReuseIdentifier: "YearHeaderView",
                    forIndexPath: indexPath)
                    as! YearHeaderView
                let theDate = theYears.list[indexPath.section].thisDate
                let calendar = NSCalendar.currentCalendar()
                let components = calendar.components([.Day , .Month , .Year], fromDate: theDate!)
                
                let year =  components.year
                
                headerView.label.text = "\(year)"
                return headerView
            default:
                //4
                assert(false, "Unexpected element kind")
            }
    }
    
    // MARK: UICollectionViewDelegate

   
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
  
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: true)
    }

    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        highlightCell(indexPath, flag: false)
    }
    
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = collectionView!.cellForItemAtIndexPath(indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = yellowThemeColor
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension MyTripsCollectionViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
        return CGSize(width: 140, height: 140)
    }
    
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
}
