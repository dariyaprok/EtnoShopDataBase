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
    private let sizeEntityName = "Size"
    private let areaEntityName = "Area"
    private let categoryEntityName = "Category"
    private let productEntityName = "Product"
    
    //MARK: - products
    public func loadAllProducts() -> [Product] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: productEntityName)
        var products:[Product] = []
        do {
            products = try coreDataStack.managedObjectContext.fetch(request) as! [Product]
            let records = try coreDataStack.managedObjectContext.fetch(request)
            if let records = records as? [Product] {
                products = records
            }
        }
        catch {
            print("Can't load employees")
        }
        return products
    }
    
    public func addProduct(name: String, area: Area, category: Category) {
        let product: Product = NSEntityDescription.insertNewObject(forEntityName: productEntityName, into: coreDataStack.managedObjectContext) as! Product
        product.name = name
        product.area = area
        product.category = category
        
        do {
            try coreDataStack.managedObjectContext.save()
        }
        catch {
            print("Can't save moc")
        }
    }
    
    //MARK: - categories
    public func loadAllCategories() -> [Category] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: categoryEntityName)
        var categories:[Category] = []
        do {
            categories = try coreDataStack.managedObjectContext.fetch(request) as! [Category]
            let records = try coreDataStack.managedObjectContext.fetch(request)
            if let records = records as? [Category] {
                categories = records
            }
        }
        catch {
            print("Can't load employees")
        }
        return categories
    }
    
    public func addCategory(name: String) {
        let category: Category = NSEntityDescription.insertNewObject(forEntityName: categoryEntityName, into: coreDataStack.managedObjectContext) as! Category
        category.name = name
        do {
            try coreDataStack.managedObjectContext.save()
        }
        catch {
            print("Can't save moc")
        }
    }
    
    //MARK: - areas
    public func loadAllAreas() -> [Area] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: areaEntityName)
        var areas:[Area] = []
        do {
            areas = try coreDataStack.managedObjectContext.fetch(request) as! [Area]
            let records = try coreDataStack.managedObjectContext.fetch(request)
            if let records = records as? [Area] {
                areas = records
            }
        }
        catch {
            print("Can't load employees")
        }
        return areas
    }
    
    public func addArea(name: String) {
        let area: Area = NSEntityDescription.insertNewObject(forEntityName: areaEntityName, into: coreDataStack.managedObjectContext) as! Area
        area.name = name
        do {
            try coreDataStack.managedObjectContext.save()
        }
        catch {
            print("Can't save moc")
        }
    }
    
    //MARK: - sizes
    public func loadAllSizes() -> [Size] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: sizeEntityName)
        var sizes:[Size] = []
        do {
            sizes = try coreDataStack.managedObjectContext.fetch(request) as! [Size]
            let records = try coreDataStack.managedObjectContext.fetch(request)
            if let records = records as? [Size] {
                sizes = records
            }
        }
        catch {
            print("Can't load employees")
        }
        return sizes
    }
    
    public func addSize(name: String, shoulderLength: Int16, waistLength: Int16) {
        let size: Size = NSEntityDescription.insertNewObject(forEntityName: sizeEntityName, into: coreDataStack.managedObjectContext) as! Size
        size.name = name
        size.shoulderLength = shoulderLength
        size.waistLength = waistLength
        do {
            try coreDataStack.managedObjectContext.save()
        }
        catch {
            print("Can't save moc")
        }
    }
    
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
