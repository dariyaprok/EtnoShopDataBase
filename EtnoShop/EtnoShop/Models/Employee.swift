//
//  Employee+CoreDataClass.swift
//  EtnoShop
//
//  Created by админ on 5/20/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import Foundation
import CoreData

@objc(Employee)
public class Employee: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var dateOfStartWork: NSDate?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var sallary: Int16
    @NSManaged public var bonus: NSSet?

    @objc(addBonusObject:)
    @NSManaged public func addToBonus(_ value: Bonus)
    
    @objc(removeBonusObject:)
    @NSManaged public func removeFromBonus(_ value: Bonus)
    
    @objc(addBonus:)
    @NSManaged public func addToBonus(_ values: NSSet)
    
    @objc(removeBonus:)
    @NSManaged public func removeFromBonus(_ values: NSSet)


}
