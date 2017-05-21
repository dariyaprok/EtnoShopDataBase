//
//  Category+CoreDataClass.swift
//  EtnoShop
//
//  Created by админ on 5/22/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {

    @NSManaged public var name: String?
    
}
