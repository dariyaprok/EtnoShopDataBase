//
//  PDBBonusCreatorVC.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBBonusCreatorVC: UIViewController {
    
    //MARK: - Properties
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    
    static let identifier = "BonusCreatorVCID"
    
    private var datePicker: UIDatePicker = UIDatePicker()
    private var toolBar: UIToolbar!
    
    var employee: Employee!
    
    //MARK: - life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
    }
    
    //MARK: - IBActions
    @IBAction func onSave(_ sender: Any) {
        if checkIfError() {
            showErrorAlert()
        }
        else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            CoreDataManager.sharedInstanse.addBonus(employee: employee, dateOfCreation: formatter.date(from: dateTextField.text!)!, amout: Int16(amountTextField.text!)!)
            navigationController?.popViewController(animated: true)
        }
    }
    
    func onDone() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
    }
    
    //MARK: - private
    func setupUI() {
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
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    func tapGesture() {
        dateTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
    }
    
    func checkIfError() -> Bool {
        if !isOnlyNumbers(text: amountTextField.text) || dateTextField.text == nil {
            return true
        }
        return false
    }
    
    func isOnlyNumbers(text:String?) -> Bool {
        if text == nil {
            return false
        }
        guard text!.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(text!.characters).isSubset(of: nums)
    }
    
    func showErrorAlert() {
        let alertController = UIAlertController(title: "Error", message: "Please wrie correct data.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
}
