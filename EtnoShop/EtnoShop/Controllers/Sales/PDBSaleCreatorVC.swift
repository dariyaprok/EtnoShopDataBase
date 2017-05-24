//
//  PDBSaleCreatorVC.swift
//  EtnoShop
//
//  Created by админ on 5/23/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBSaleCreatorVC: UIViewController, UITextFieldDelegate, PDBProductParameterPickerDelegate {
    
    static let identifier = "PDBSaleCreatorVC"
    
        //MARK: - properties
    @IBOutlet weak var salesManTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var pricePer1TextField: UITextField!
    @IBOutlet weak var productTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    private var datePicker: UIDatePicker = UIDatePicker()
    private var toolBar: UIToolbar!
    public var isEditableMode: Bool = true
    
    private var size: Size?
    private var product: Product?
    private var salesMan: Employee?
    private var date: NSDate?
    var sale: Sale? {
        didSet {
            if sale != nil {
                size = sale?.size
                product = sale?.product
                date = sale?.date
                salesMan = sale?.salesman
            }
            else {
                size = nil
                product = nil
                date = nil
                salesMan = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    //MARK: text field
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == productTextField {
            var vc = UIStoryboard(name: "AdditionalSettings", bundle: nil).instantiateViewController(withIdentifier: PDBProductListVC.identifier) as! PDBProductParameterPicker
            vc.isPickingMode = true
            vc.setDelegate(delegate: self)
            navigationController?.pushViewController(vc as! UIViewController, animated: true)
            return false
        }
        else if textField == sizeTextField {
            var vc = UIStoryboard(name: "AdditionalSettings", bundle: nil).instantiateViewController(withIdentifier: PDBSizesVC.identifier) as! PDBProductParameterPicker
            vc.isPickingMode = true
            vc.setDelegate(delegate: self)
            navigationController?.pushViewController(vc as! UIViewController, animated: true)
            return false
        }
        else if textField == salesManTextField {
            var vc = UIStoryboard(name: "Employees", bundle: nil).instantiateViewController(withIdentifier: PDBEmployeeListVC.identifier) as! PDBProductParameterPicker
            vc.isPickingMode = true
            vc.setDelegate(delegate: self)
            navigationController?.pushViewController(vc as! UIViewController, animated: true)
            return false
        }

        return true
    }
    
    //MARK: - IBActions
    func onDone() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField?.text = formatter.string(from: datePicker.date)
        date = datePicker.date as NSDate
    }
    
    @IBAction func onSave(_ sender: Any) {
        CoreDataManager.sharedInstanse.addSale(amount: Int16(amountTextField.text!)!, pricePer1: Int16(pricePer1TextField.text!)!, date: date!, product: product!, size: size!, salesman: salesMan!)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - PDBPicker delegate
    func viewControllerPickParameter(data: Any) {
        if let sizeData = data as? Size {
            size = sizeData
        }
        else if let productData = data as? Product {
            product = productData
        }
        else if let salesManData = data as? Employee {
            salesMan = salesManData
        }
        updateUI()
    }
    
    //MARK: - private
    private func setupUI() {
        if toolBar == nil {
            toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
            let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
            toolBar.backgroundColor = UIColor.white
            toolBar.items = [doneBarButton]
            datePicker.datePickerMode = .date
            dateTextField.inputView = datePicker
            dateTextField.inputAccessoryView = toolBar
        }
    }
    
    private func updateUI() {
        if sale != nil {
            amountTextField.text = "\(sale!.amount)"
            datePicker.date = (sale?.date)! as Date
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            dateTextField?.text = formatter.string(from: datePicker.date)
            pricePer1TextField.text = "\(sale!.pricePerOne)"
        }
        if size != nil {
            sizeTextField.text = size?.name
        }
        if product != nil {
            productTextField.text = product?.name
        }
        if salesMan != nil {
            salesManTextField.text = salesMan?.name
        }
        amountTextField.isEnabled = isEditableMode
        dateTextField.isEnabled = isEditableMode
        pricePer1TextField.isEnabled = isEditableMode
        productTextField.isEnabled = isEditableMode
        sizeTextField.isEnabled = isEditableMode
        saveBarButton.isEnabled = isEditableMode
        salesManTextField.isEnabled = isEditableMode
}
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    func tapGesture() {
        dateTextField.resignFirstResponder()
        pricePer1TextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
        sizeTextField.resignFirstResponder()
        productTextField.resignFirstResponder()
        productTextField.resignFirstResponder()
    }
}

