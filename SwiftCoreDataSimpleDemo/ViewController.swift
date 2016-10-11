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

    
    @IBOutlet weak var displayResultLable: UILabel!
    
    @IBAction func createMangeObjectBtn(sender: AnyObject) {
         self.displayResultLable.text = ""
        
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
        /*
        let entityForName =  NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: context)
        
        entityForName.setValue("Android Programming", forKey: "title")
        entityForName.setValue("12/12/12", forKey: "publishDate")
        entityForName.setValue("NH001", forKey: "code")
        entityForName.setValue("Nazmul Hasan", forKey: "author")
        */
        
        
        // entityForName  Returns the entity with the specified name from the managed object model associated with the specified managed object context’s persistent store coordinator.
        let entity = NSEntityDescription.entityForName("Book", inManagedObjectContext: context)!
          //Book class inherit NSObject so we need ot initilaization
        let book = Book(entity: entity, insertIntoManagedObjectContext: context)
        book.title = "Android Programming"
        book.publishDate = "12/12/12"
        book.code = "AP001"
        book.author = "Nazmul Hasan"
        //Registers an object to be inserted in the receiver’s persistent store the next time changes are saved.
        context.insertObject(book)
        
        
        do{
            //Attempts to commit unsaved changes to registered objects to the receiver’s parent store.
            //true if the save succeeds, otherwise false. 
           try context.save()

           self.displayResultLable.text = "crated success"
        }
        catch{
          self.displayResultLable.text = "something wrong happend"
        }
        
    }
    
    @IBAction func fatchManageObjectBtn(sender: AnyObject) {
         self.displayResultLable.text = ""
        //The other solution is correct in that it will get you a reference to the application's delegate, but this will not allow you to access any methods or variables added by your subclass of UIApplication, like your managed object context. To resolve this, simply downcast to "AppDelegate" or what ever your UIApplication subclass happens to be called
        
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //The managed object model for the application
        let context  =  appDelegate.managedObjectContext
  
        //nstance of NSFetchRequest describes search criteria used to retrieve data from a persistent store.
        let fetchRequest = NSFetchRequest(entityName: "Book")
      
        do {
        //Returns an array of objects that meet the criteria specified by a given fetch request.
        let results = try context.executeFetchRequest(fetchRequest)
        
            if results.count > 0 {
                
                for book in results as! [NSManagedObject] {
              
                        if let title = book.valueForKey("title") as? String {
                            self.displayResultLable.text = self.displayResultLable.text! + "\n" + title
                            self.displayResultLable.numberOfLines = 0
                        }
                    
                }
            }
            else{
                
            }
      
        
        }
        catch{
           self.displayResultLable.text = "someting wrong happend"
        }
    }
    
  
    @IBAction func updateManageObjectBtn(sender: AnyObject) {
         self.displayResultLable.text = ""
        
        //The other solution is correct in that it will get you a reference to the application's delegate, but this will not allow you to access any methods or variables added by your subclass of UIApplication, like your managed object context. To resolve this, simply downcast to "AppDelegate" or what ever your UIApplication subclass happens to be called
        
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //The managed object model for the application
        let context  =  appDelegate.managedObjectContext
        
        //nstance of NSFetchRequest describes search criteria used to retrieve data from a persistent store.
        let fetchRequest = NSFetchRequest(entityName: "Book")
        fetchRequest.predicate = NSPredicate(format: "title=%@", "Android Programming")
        
        do {
            self.displayResultLable.text = ""
            //Returns an array of objects that meet the criteria specified by a given fetch request.
            let results = try context.executeFetchRequest(fetchRequest)
            
            if results.count > 0 {
                
                for book in results as! [NSManagedObject] {
                    
                    if book.valueForKey("title") != nil {
                       
                        
                        book.setValue("Windows Programming", forKey: "title")
                        
                        //Attempts to commit unsaved changes to registered objects to the receiver’s parent store.
                        //true if the save succeeds, otherwise false.
                        do{
                        try context.save()
                           self.displayResultLable.text = "Update success"
                        }
                        catch{
                           self.displayResultLable.text = "something wrong happend"
                        }
                    }
                    
                }
            }
            else{
                
            }
            
            
        }
        catch{
            print("someting wrong happend")
        }
    }
    
    @IBAction func deletedManageObjectBtn(sender: AnyObject) {
        self.displayResultLable.text = ""
        //The other solution is correct in that it will get you a reference to the application's delegate, but this will not allow you to access any methods or variables added by your subclass of UIApplication, like your managed object context. To resolve this, simply downcast to "AppDelegate" or what ever your UIApplication subclass happens to be called
        
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        
        //The managed object model for the application
        let context  =  appDelegate.managedObjectContext
        
        //nstance of NSFetchRequest describes search criteria used to retrieve data from a persistent store.
        let fetchRequest = NSFetchRequest(entityName: "Book")
        fetchRequest.predicate = NSPredicate(format: "title=%@", "Windows Programming")
        
        do {
            
            //Returns an array of objects that meet the criteria specified by a given fetch request.
            let results = try context.executeFetchRequest(fetchRequest)
            
            if results.count > 0 {
                
                for book in results as! [NSManagedObject] {
                    
                    if book.valueForKey("title") != nil {
                        //Specifies an object that should be removed from its persistent store when changes are committed.
                        context.deleteObject(book)
                        
                        do{
                            //Attempts to commit unsaved changes to registered objects to the receiver’s parent store.
                            //true if the save succeeds, otherwise false.
                            try context.save()
                            self.displayResultLable.text = "delete success"
                        }
                        catch{
                            
                            self.displayResultLable.text = "delete failed"
                        }
                    }
                    
                }
            }
            else{
                
            }
            
            
        }
        catch{
            print("someting wrong happend")
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

