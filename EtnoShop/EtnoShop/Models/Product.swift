//
//  Product+CoreDataClass.swift
//  EtnoShop
//
//  Created by админ on 5/22/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import Foundation
import CoreData

@objc(Product)
public class Product: NSManagedObject {

    @NSManaged public var name: String
    @NSManaged public var category: Category?
    @NSManaged public var area: Area?
    
}
