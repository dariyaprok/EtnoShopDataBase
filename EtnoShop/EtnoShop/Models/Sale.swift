//
//  Sale+CoreDataClass.swift
//  EtnoShop
//
//  Created by админ on 5/23/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import Foundation
import CoreData

@objc(Sale)
public class Sale: NSManagedObject {

    @NSManaged public var amount: Int16
    @NSManaged public var pricePerOne: Int16
    @NSManaged public var date: NSDate?
    @NSManaged public var size: Size?
    @NSManaged public var salesman: Employee?
    @NSManaged public var product: Product?

}
