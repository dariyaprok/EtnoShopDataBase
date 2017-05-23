//
//  PDBArrivalCreatorVC.swift
//  EtnoShop
//
//  Created by админ on 5/23/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBArrivalCreatorVC: UIViewController, UITextFieldDelegate, PDBProductParameterPickerDelegate {
    
    static let identifier = "PDBArrivalCreatorVCID"
    
    //MARK: - properties
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
    private var date: NSDate?
    var arrival: Arrival? {
        didSet {
            if arrival != nil {
                size = arrival?.size
                product = arrival?.product
                date = arrival?.date
            }
            else {
                size = nil
                product = nil
                date = nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        CoreDataManager.sharedInstanse.addArrival(amount: Int16(amountTextField.text!)!, pricePer1: Int16(pricePer1TextField.text!)!, date: date!, product: product!, size: size!)
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
        if arrival != nil {
            amountTextField.text = "\(arrival!.amount)"
            datePicker.date = (arrival?.date)! as Date
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            dateTextField?.text = formatter.string(from: datePicker.date)
            pricePer1TextField.text = "\(arrival!.pricePerOne)"
        }
        if size != nil {
            sizeTextField.text = size?.name
        }
        if product != nil {
            productTextField.text = product?.name
        }
        amountTextField.isEnabled = isEditableMode
        dateTextField.isEnabled = isEditableMode
        pricePer1TextField.isEnabled = isEditableMode
        productTextField.isEnabled = isEditableMode
        sizeTextField.isEnabled = isEditableMode
        saveBarButton.isEnabled = isEditableMode
    }
    
}
