//
//  Book+CoreDataProperties.swift
//  SwiftCoreDataSimpleDemo
//
//  Created by Nazmul Hasan on 10/12/16.
//  Copyright © 2016 Nazmul Hasan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var author: String?
    @NSManaged var code: String?
    @NSManaged var publishDate: String?
    @NSManaged var title: String?

}
