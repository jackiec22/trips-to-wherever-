//
//  MyTripsCollectionViewController.swift
//  MyTrips
//
//  Created by Jackie Chang on 1/6/16.
//  Copyright © 2016 Jackie Chang. All rights reserved.
//

import UIKit



class MyTripsCollectionViewController: UIViewController {
    
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 50.0, bottom: 50.0, right: 50.0)
    private let reuseIdentifier = "TripViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toolBar: UIToolbar!
    
    var theYears = MyTripsBrain()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        //self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        title = "My Vacations"
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // add the edit button
        navigationItem.leftBarButtonItem = editButtonItem()
        toolBar.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        // highlighted cell before pushed to detail viewcontroller, so now unhighlight it
        if let indexPath = getIndexPathForSelectedCell() {
            highlightCell(indexPath, flag: false)
        }
        
    }

    
    // MARK: - Add a new trip
    func addButtonPushed()
    {
        performSegueWithIdentifier("AddNewTrip", sender: nil)

    }
    
    // MARK:- Editing
    override func setEditing(editing: Bool, animated: Bool) {
            
        super.setEditing(editing, animated: animated)
        collectionView.allowsMultipleSelection = editing
        toolBar!.hidden = !editing
    }
    
    // MARK: - Delete Cells
    
    @IBAction func deleteButtonPressed(sender: AnyObject) {
        
        let indexpaths = collectionView.indexPathsForSelectedItems()
        
        if let indexpaths = indexpaths {
            
            for item  in indexpaths {
                
                collectionView.deselectItemAtIndexPath(item, animated: true)
            }
            
            theYears.deleteTripsAtIndexPaths(indexpaths)
            
            collectionView.deleteItemsAtIndexPaths(indexpaths)
        }
        
        // turn off the editing
        setEditing(false, animated: true)
    }
    
    func highlightCell(indexPath : NSIndexPath, flag: Bool) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        
        if flag {
            cell?.contentView.backgroundColor = selectedThemeColor
        } else {
            cell?.contentView.backgroundColor = nil
        }
    }
    
    func getIndexPathForSelectedCell() -> NSIndexPath? {
        
        var indexPath: NSIndexPath?
        
        let items = collectionView.indexPathsForSelectedItems()
        if items != nil && items!.count > 0 {
            indexPath = items![0]
        }
        return indexPath
        
    }
    
    // MARK: - Navigation
    
    // Don't do segue if editing cells
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return !editing
    }
    
    
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
                if let indexPath = collectionView.indexPathForCell(cell) {
                    let seguedToMVC = destination as! TripDetailViewController
                    
                    // pass the correct table to the tableview
                    seguedToMVC.theTrip = theYears.list[indexPath.section].trips[indexPath.row]
                    
                    // prevent the back button fro taking the title of this view
                    let backItem = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
                    navigationItem.backBarButtonItem = backItem
                    
                }
                
            case "AddNewTrip":
                
                let seguedToMVC = destination as! TripSettingsViewController
                
                // pass the data to it
                seguedToMVC.tripsBrain = theYears
                
                
            default: break
                
            }
        }
    }
}




    // MARK: UICollectionViewDataSource
extension MyTripsCollectionViewController : UICollectionViewDataSource {

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return theYears.list.count
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let year = theYears.list[section]
        return year.trips.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let year = theYears.list[indexPath.section]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! TripCollectionViewCell
    
        // Configure the cell
        cell.locationName = year.trips[indexPath.row].name
        cell.cellImage = year.trips[indexPath.row].defaultImage
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
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
}


    // MARK: UICollectionViewDelegate

extension MyTripsCollectionViewController : UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("Did Select Item at: \(indexPath)")
        highlightCell(indexPath, flag: true)
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("Did deselect Item at: \(indexPath)")
        highlightCell(indexPath, flag: false)
    }
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
