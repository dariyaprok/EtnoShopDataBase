//
//  Bonus+CoreDataClass.swift
//  EtnoShop
//
//  Created by админ on 5/20/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import Foundation
import CoreData

@objc(Bonus)
public class Bonus: NSManagedObject {

    @NSManaged public var dateOfCreation: NSDate?
    @NSManaged public var amount: Int16
    @NSManaged public var employee: Employee?

}
