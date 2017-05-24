//
//  PDBMoneyVC.swift
//  EtnoShop
//
//  Created by админ on 5/24/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBMoneyVC: UIViewController, UITextFieldDelegate {
    
    static let identifier = "PDBMoneyVCID"
    
    @IBOutlet weak var countButton: UIButton!
    @IBOutlet weak var cleanPlusTextField: UITextField!
    @IBOutlet weak var minusMoneyTextField: UITextField!
    @IBOutlet weak var plusMoneyTextField: UITextField!
    @IBOutlet weak var dateToTextField: UITextField!
    @IBOutlet weak var dateFromTextField: UITextField!
    
    private var datePicker: UIDatePicker = UIDatePicker()
    private var toolBar: UIToolbar!
    private var formatter: DateFormatter = DateFormatter()
    fileprivate var activeTextField: UITextField?
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - text field delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    //MARK: - actions
    func onDone() {
        activeTextField?.text = formatter.string(from: datePicker.date)
    }
    
    
    @IBAction func onCount(_ sender: Any) {
        if checkIfError() {
            showErrorAlert()
        }
        else {
            let dateFrom: NSDate = formatter.date(from: dateFromTextField.text!) as NSDate!
            let dateTo: NSDate = formatter.date(from: dateToTextField.text!) as NSDate!
            let plus = CoreDataManager.sharedInstanse.countPlus(dateFrom: dateFrom, dateTo: dateTo)
            plusMoneyTextField.text = "\(plus)"
            
            let minus = CoreDataManager.sharedInstanse.countMinus(dateFrom: dateFrom, dateTo: dateTo)
            minusMoneyTextField.text = "\(plus)"
            cleanPlusTextField.text = "\(plus - minus)"
        }
    }
    
    //MARK: - private
    private func setupUI() {
        formatter.dateFormat = "dd.MM.yyyy"
        if toolBar == nil {
            toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 30))
            let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDone))
            toolBar.backgroundColor = UIColor.white
            toolBar.items = [doneBarButton]
            datePicker.datePickerMode = .date
            dateFromTextField.inputView = datePicker
            dateFromTextField.inputAccessoryView = toolBar
            dateToTextField.inputView = datePicker
            dateToTextField.inputAccessoryView = toolBar
        }
    }
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    func tapGesture() {
        activeTextField?.resignFirstResponder()
    }
    
    func checkIfError() -> Bool {
        if dateFromTextField.text == nil || dateToTextField.text == nil   {
            return true
        }
        return false
    }
    
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Please wrie correct data.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
