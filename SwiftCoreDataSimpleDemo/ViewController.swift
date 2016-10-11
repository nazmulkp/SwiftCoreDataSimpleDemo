//
//  ViewController.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by Nazmul Hasan on 10/10/16.
//  Copyright © 2016 Nazmul Hasan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController  {

    @IBAction func createMangeObjectBtn(sender: AnyObject) {
        
        //The other solution is correct in that it will get you a reference to the application's delegate, but this will not allow you to access any methods or variables added by your subclass of UIApplication, like your managed object context. To resolve this, simply downcast to "AppDelegate" or what ever your UIApplication subclass happens to be called
 
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //The managed object model for the application
        let context  =  appDelegate.managedObjectContext
        
        /////////////////////////////////////
        ///insertNewObjectForEntityForName///
        /////////////////////////////////////
        /*
         Creates, configures, and returns an instance of the class for the entity with a given name.
         */
        let entityForName =  NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: context)
        
        entityForName.setValue("iOS Programming", forKey: "title")
        entityForName.setValue("12/12/12", forKey: "publishDate")
        entityForName.setValue("NH001", forKey: "code")
        entityForName.setValue("tolight", forKey: "author")
        
        
        do{
            //Attempts to commit unsaved changes to registered objects to the receiver’s parent store.
            //true if the save succeeds, otherwise false. 
            try context.save()
            print("saved")
        }
        catch{
          print("something happend")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

