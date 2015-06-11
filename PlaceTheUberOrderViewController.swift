//
//  PlaceTheUberOrderViewController.swift
//  UberGranny
//
//  Created by Liam Golightley on 6/10/15.
//  Copyright (c) 2015 Foggy Bottom Productions, LLC. All rights reserved.
//
import CoreLocation
import UIKit
import CoreData

class PlaceTheUberOrderViewController: UIViewController {
    
    //Initialize values in case of simulator 
    var myLat   = 40.35
    var myLong  = -74.66
    
    var myDropOffAddressStreeet = ""
    var myDropOffCity           = ""
    var pickUpHomeAddressFromCoreData = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func orderTheUberButtonPressed(sender: AnyObject) {
 
        //-----------------------------------------------------------------------------------------------------------------
        //This is the actual ordering of the UBER. The code used is being wrapped by a class called Uber.swift 
        // and is based on the DeepLinking Uber API. The values need to be hardcoded to work on the simulator as the 
        // lat and long wont work. Also make sure that the CoreData functionality is working from the main ViewController
        //-----------------------------------------------------------------------------------------------------------------

        
//                App requires the uber app to also be installed on the device
                if(Uber.isUberAppInstalled()){
                    println("Uber is installed")
                }else{
                    println("Uber is not installed")
                    //Write code warning my granny if there is something wrong
        
                }
        
                //get the pickup loacation from my granny
                var pickupLocation = CLLocationCoordinate2D(latitude: myLat, longitude: myLong)
        
                //get the pickupformatted address
                var pickupFormattedAddressInput    = "429 Walnut Lane Princeton NJ 08540"
        
                //Get the coreData address. Turn this off for the simulator.
//                var pickupFormattedAddressInput    = getCoreDataHomeAddress()
        
        
        
        
                var droppOffFormattedAddressInput  = "20 Walnut Lane Princeton NJ 08540"

                //create an Uber instance from the Uber.swift class
                var uber = Uber(pickupLocation: pickupLocation)
        
//                var uber = Uber(pickupFormattedAddress: pickupFormattedAddressInput)

                  uber.pickupFormattedAddress  = pickupFormattedAddressInput
                  //THIS SHOULD BE REPLACED WITH COREDATA
        
                  // Get the drop off location from the UI Text Boxes.
                  uber.dropoffFormattedAddress = myDropOffAddressStreeet + myDropOffCity
        
//                Get drop off location
//                uber.dropoffLocation = CLLocationCoordinate2D(latitude: 47.591351, longitude: -122.332271)
        
//                call the url
                  uber.deepLink()
        
    }

    //Outlet connections that are connecting us the the UI
    @IBOutlet weak var helpInfoText: UILabel!
    @IBOutlet weak var OrderUberButton: UIButton!
    
    
    //-----------------------------------------------------------------------------------------------------------------
    //A major part of this app is walking my Granny through which box to type in and what time. To do this in the simplest
    // way possible the text box will be highlighted yellow and the instructions will change depending on her latest action.
    // This will guide her through the process. The is implemented below by using IBActions with various notifiers to
    // change the UI based on an action. This is similar to the code used in the main ViewController
    //-----------------------------------------------------------------------------------------------------------------
    
    @IBAction func DestinationStreetAddressEditingDidBegin(textView: UITextView) {
        
        textView.backgroundColor = UIColor.yellowColor()
        textView.text = ""
        helpInfoText.text = "Use keyboard at the bottom of screen to type in your STREET ADDRESS. Done typing? Press the next grey boy below the yellow one."
    }
    
    @IBAction func EditingDestinationStreetAddressDidEnd(textView: UITextView) {
        
        //save the address in variable
        myDropOffAddressStreeet = textView.text
        
        textView.backgroundColor = UIColor.whiteColor()

    }
    
    
    @IBAction func EditingDestinationCityDidBegin(textView: UITextView) {
        
        textView.backgroundColor = UIColor.yellowColor()
        textView.text = ""
        helpInfoText.text = "Use keyboard at the bottom of screen to type in your CITY. Done typing? Press the next grey boy below the yellow one."
        OrderUberButton.backgroundColor = UIColor.yellowColor()
    }
    
    
    @IBAction func EditingDestinationCityDidEnd(textView: UITextView) {
        
        textView.backgroundColor = UIColor.whiteColor()
        helpInfoText.text = "Done typing? Press the next grey boy below the yellow one."
        //save the address in variable
        var temp:String = textView.text
       
        myDropOffCity = textView.text

        
    }
    
    
    //-----------------------------------------------------------------------------------------------------------------
    // We need to get the latitiude and longtitude of our current position. This is a required part of the UBER API
    // Instantiation and is not optional. This function can only be used when the app is deployed and can not be used 
    // when testing on the emulator. For emulator use, hard code the VARS up top.
    //-----------------------------------------------------------------------------------------------------------------
    
    
    func getLatLongNow () {
        
        var locManager = CLLocationManager()
        locManager.requestWhenInUseAuthorization()
        var  currentLocation = locManager.location
        myLong = currentLocation.coordinate.longitude
        myLat  = currentLocation.coordinate.latitude

        
        // Test to make sure the user has the actual authorization
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
                
                currentLocation = locManager.location
                myLong = currentLocation.coordinate.longitude
                myLat  = currentLocation.coordinate.latitude
        }

        

        
        
    }
    
    //-----------------------------------------------------------------------------------------------------------------
    // This will pull the coreData information for the homeAddress that we originally saved in the main ViewController
    // Comment out when we are using the simulator.
    //---------------------------------------------------------------------------------------------------------
    
    func getCoreDataHomeAddress () {
        
        //Use AppDelegate classes to fetch the the TaskModel Entity from CoreData
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        //This is purely for debugging to make sure something is actually being returned from the CoreData Fetech
        for res in results {
            
            println(res)
            
//            pickUpHomeAddressFromCoreData = res.streetAddress
}
    }

}
