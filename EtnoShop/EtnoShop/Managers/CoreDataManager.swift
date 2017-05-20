//
//  CoreDataManager.swift
//  EtnoShop
//
//  Created by админ on 5/18/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit
import CoreData


class CoreDataManager: NSObject {
    
    private let coreDataStack = CoreDataStack(modelName: "EtnoShop")
    
    private let employeeEntityName = "Employee"
    
    //MARK: - Employees
    public func loadAllEmployees() -> [Employee]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: employeeEntityName)
        var employees:[Employee]
        do {
            employees = try coreDataStack.managedObjectContext.fetch(request) as! [Employee]
            return employees
        }
        catch {
            print("Can't load employees")
        }
        return nil
    }
    
    public func addEmployee(name:String, dateOfBirth:NSDate, dateOfStartWork:NSDate, phoneNumber:String, sallary:Int16) {
        let employee: Employee = NSEntityDescription.insertNewObject(forEntityName: employeeEntityName, into: coreDataStack.managedObjectContext) as! Employee
        employee.name = name
        employee.dateOfBirth = dateOfBirth
        employee.dateOfStartWork = dateOfStartWork
        employee.phoneNumber = phoneNumber
        employee.sallary = sallary
        do {
            try coreDataStack.managedObjectContext.save()
        }
        catch {
            print("can't save info")
        }
    }

}
