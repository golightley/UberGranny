//
//  TaskModel.swift
//  UberGranny
//
//  Created by Liam Golightley on 6/10/15.
//  Copyright (c) 2015 Foggy Bottom Productions, LLC. All rights reserved.
//

import Foundation
import CoreData

//THIS MODEL CONNECTS TO THE COREDATA ENTITY GENERATED. DO NOT TOUCH!
class TaskModel: NSManagedObject {

    @NSManaged var streetAddress: String
    @NSManaged var city: String
    @NSManaged var zipcode: String

}
