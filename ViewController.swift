//
//  ViewController.swift
//  MyGrannyUber
//
//  Created by Liam Golightley on 6/1/15.
//  Copyright (c) 2015 Foggy Bottom Productions, LLC. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData


class ViewController: UIViewController {
    
    
    @IBOutlet weak var saveAddressButton: UIButton!
    @IBOutlet weak var helpTextBox: UITextView!
    
    //-----------------------------------------------------------------------------------------------------------------
    //A major part of this app is walking my Granny through which box to type in and what time. To do this in the simplest 
    // way possible the text box will be highlighted yellow and the instructions will change depending on her latest action.
    // This will guide her through the process. The is implemented below by using IBActions with various notifiers to 
    // change the UI based on an action.
    //-----------------------------------------------------------------------------------------------------------------
    
    // If the first box is pressed, highlight it yellow and change the instructions
    @IBAction func streetAddressInputBox(textView: UITextView) {

        textView.backgroundColor = UIColor.yellowColor()
        textView.text = ""
        helpTextBox.text = "Use keyboard at the bottom of screen to type in your STREET ADDRESS. Done typing? Press the next grey boy below the yellow one."
    }
    // If the first box is released, remove the highlight and change the instructions
    @IBAction func streetAddressInputBoxEditingDidEnd(textView: UITextView) {
    
        textView.backgroundColor = UIColor.whiteColor()
        helpTextBox.text = "Use keyboard at the bottom of screen to type in your CITY. Done typing? Press the next grey boy below the yellow one."

    }
    // If the second box is pressed, highlight it yellow and change the instructions
    @IBAction func townAddressInputBoxEditingDidBegin(textView: UITextView) {
        
        
        textView.backgroundColor = UIColor.yellowColor()
        textView.text = ""
    }
    
    // If the second box is released, remove the highlight and change the instructions
    @IBAction func townAddressInputBoxEditingDidEnd(textView: UITextView) {
        
        textView.backgroundColor = UIColor.whiteColor()
        helpTextBox.text = "Use keyboard at the bottom of screen to type in your Zip Code  Done typing? Press the yellow button to save your address!"
    }
    // If the zip box is pressed, highlight it yellow and change the instructions. Also highlight the button as this is the next step.
    @IBAction func zipcodeInputBoxEditingDidBegin(textView: UITextView) {
        
        
        textView.backgroundColor = UIColor.yellowColor()
        textView.text = ""
        saveAddressButton.backgroundColor = UIColor.yellowColor()

    }
    // If the zip box is released, remove the highlight and change the instructions
    @IBAction func zipcodeInputBoxEditingDidEnd(textView: UITextView) {

        textView.backgroundColor = UIColor.whiteColor()

    }
    
    //Connections to the UI for the UIBoxes
    @IBOutlet weak var streetAddressInputText: UITextField!
    @IBOutlet weak var townAddressInputText: UITextField!
    @IBOutlet weak var zipcodeInputText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check to see if the data has been saved on previous uses of the app. If so, move on to next screen.
        if(checkIfAddressIsSaved()){
            self.performSegueWithIdentifier("showOrderDetail", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TestUberButtonPressed(sender: AnyObject) {
        
        
        //-----------------------------------------------------------------------------------------------------------------
        //Setup the appDelegate and managedObjectContext instances that will handle (wrap) the communication with the CoreData class
        //-----------------------------------------------------------------------------------------------------------------

        
          let appDelegate          = (UIApplication.sharedApplication().delegate as AppDelegate)
          let managedObjectContext = appDelegate.managedObjectContext
          let entityDescription    = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
          let task                 = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
 
        
            //-----------------------------------------------------------------------------------------------------------------
            //This code makes sure that my granny actually enters an address and that the fields are not blank. It then saves
            // the three important parts of the data into the CoreData Entity. The TaskModel class is connected to the UberGranny
            // Model which is managed by the AppDelegate classes listed under CoreData. The CoreData needs to be disabled while 
            // running on the simulator. It is also important to remember that adding Objc(TaskModel) can cause issues depending on 
            // the version of Xcode.
            //-----------------------------------------------------------------------------------------------------------------
           if( streetAddressInputText.text != nil ){ task.streetAddress = streetAddressInputText.text
           }else{println("Please enter a street address in the first box.")}
        
           if( townAddressInputText.text   != nil ){task.city           = townAddressInputText.text}
           else{println("Please enter a city address in the first box.")}
        
           if( zipcodeInputText.text       != nil ){task.zipcode        = zipcodeInputText.text}
           else{println("Please enter a city address in the first box.")}
        
           //Save the entity to CoreData. This should now be persistent.
           appDelegate.saveContext()
        
            // After the entity has been saved then go to the next Activity with a segue.
           self.performSegueWithIdentifier("showOrderDetail", sender: self)

          }
    
    
//        self.performSegueWithIdentifier("showOrderDetail", sender: self)
    
    }


//-----------------------------------------------------------------------------------------------------------------
//This code is going to check if my Granny has already saved her address using CoreData. It returns a boolean of true
// if it is already saved and false if not. The function uses the same AppDelegate classes to access CoreData
// The database is using a TaskModel entity which has been setup using the UI and is connected to the TaskModel Class
// which is a subclass of NSSubmanagedObject
//-----------------------------------------------------------------------------------------------------------------
    func checkIfAddressIsSaved() -> Bool {
        
        //Use AppDelegate classes to fetch the the TaskModel Entity from CoreData
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = appDelegate.managedObjectContext
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        //This is purely for debugging to make sure something is actually being returned from the CoreData Fetech
        for res in results {
            
            println(res)

        }
        
        //If results is less than 0, then array is empty. THERE SHOULD BE A BETTER WAY TO TEST THIS.
        if (results.count > 0){
            println(results.count)
            
            //If there is an item stored in the array, then an address has been saved
            return true

        }else {
            // if there is nothing in there then nothing has been saved, so lets prompt for address
            println("No results returned")
            return false
        }
    }
    
    // This allows us to move to the next activity
  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "showOrderDetail"){
            let orderRideVC:OrderARideViewController =  segue.destinationViewController as OrderARideViewController
        }
    
    
        
    }
    
    



