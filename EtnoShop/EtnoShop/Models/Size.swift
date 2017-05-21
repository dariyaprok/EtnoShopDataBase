//
//  Size+CoreDataClass.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import Foundation
import CoreData

@objc(Size)
public class Size: NSManagedObject {

    @NSManaged public var name: String?
    @NSManaged public var shoulderLength: Int16
    @NSManaged public var waistLength: Int16
    
}
