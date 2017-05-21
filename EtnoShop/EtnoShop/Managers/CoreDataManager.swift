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
    static let sharedInstanse = CoreDataManager()
    
    private let employeeEntityName = "Employee"
    private let bonusEntityName = "Bonus"
    
    //MARK: - Bonuses
    public func addBonus(employee: Employee, dateOfCreation: Date, amout: Int16) {
        let bonus = NSEntityDescription.insertNewObject(forEntityName: bonusEntityName, into: coreDataStack.managedObjectContext) as! Bonus
        bonus.amount = amout
        bonus.dateOfCreation = dateOfCreation as NSDate?
        bonus.employee = employee
        employee.addToBonus(bonus)
        do {
            try coreDataStack.managedObjectContext.save()
        }
        catch {
            print("Can't save moc")
        }
    }
    
    //MARK: - Employees
    public func loadAllEmployees() -> [Employee]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: employeeEntityName)
        var employees:[Employee] = []
        do {
            employees = try coreDataStack.managedObjectContext.fetch(request) as! [Employee]
            let records = try coreDataStack.managedObjectContext.fetch(request)
            if let records = records as? [Employee] {
                employees = records
            }
        }
        catch {
            print("Can't load employees")
        }
        return employees
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

    public func editEmployee(employee: Employee, name:String, dateOfBirth:NSDate, dateOfStartWork:NSDate, phoneNumber:String, sallary:Int16) {
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
