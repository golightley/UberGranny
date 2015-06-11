//
//  OrderARideViewController.swift
//  MyGrannyUber
//
//  Created by Liam Golightley on 6/1/15.
//  Copyright (c) 2015 Foggy Bottom Productions, LLC. All rights reserved.
//

import UIKit
import CoreData

class OrderARideViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //-----------------------------------------------------------------------------------------------------------------
        //This is for debugging. Used to make sure CoreData is working. Comment out for actual testing.
        //-----------------------------------------------------------------------------------------------------------------
        
//        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
//        let managedObjectContext = appDelegate.managedObjectContext
//        var request = NSFetchRequest(entityName:"Task")
//        var error:NSError? = nil
//        var results:NSArray  = managedObjectContext!.executeFetchRequest(request, error: &error)!
//        
//        for res in results {
//            
//            println(res)
//            
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // THis is a very simple way for my Granny to figure tell us if she wants to use her saved address or a new address
    //-----------------------------------------------------------------------------------------------------------------
    
    
    @IBAction func myHouseButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goToArrivalAddress", sender: self)

    }

    @IBAction func notMyHouseButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("goToTypeInPickupAddress", sender: self)

    }


}
