//
//  PDBEmployeeCreatorVC.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBEmployeeCreatorVC: UIViewController {
    
    //MARK: - properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobilePhone: UITextField!
    @IBOutlet weak var sallaryTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var startWorkTextField: UITextField!
    @IBOutlet weak var bonusesBarButton: UIBarButtonItem!
    
    var isEditableMode: Bool = false
    var employee: Employee! {
        didSet {
            print("employee : \(employee?.name!)")
        }
    }
    private var datePicker: UIDatePicker = UIDatePicker()
    private var toolBar: UIToolbar!
    private var formatter: DateFormatter = DateFormatter()
    fileprivate var activeTextField: UITextField?
    
    //MARK: - life cycle
    override func viewDidLoad() {
        setupUI()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareUI()
    }
    
    //MARK: - IBActions
    @IBAction func onSave(_ sender: Any) {
        let dateOfBirth: NSDate = formatter.date(from: birthdayTextField.text!) as NSDate!
        let dateOfStartWotk: NSDate = formatter.date(from: startWorkTextField.text!) as NSDate!
        if isEditableMode {
            CoreDataManager.sharedInstanse.editEmployee(employee: employee!, name: nameTextField.text!, dateOfBirth: dateOfBirth, dateOfStartWork: dateOfStartWotk, phoneNumber: mobilePhone.text!, sallary: Int16(sallaryTextField.text!)!)
        }
        else {
            CoreDataManager.sharedInstanse.addEmployee(name: nameTextField.text!, dateOfBirth: dateOfBirth, dateOfStartWork: dateOfStartWotk, phoneNumber: mobilePhone.text!, sallary: Int16(sallaryTextField.text!)!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func onDone() {
        activeTextField?.text = formatter.string(from: datePicker.date)
    }
    
    @IBAction func showBonusesList(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Employees", bundle: nil).instantiateViewController(withIdentifier: PDBBonusListVC.identifier) as! PDBBonusListVC
        vc.employee = employee
        self.navigationController?.pushViewController(vc, animated: true)
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
            birthdayTextField.inputView = datePicker
            birthdayTextField.inputAccessoryView = toolBar
            startWorkTextField.inputView = datePicker
            startWorkTextField.inputAccessoryView = toolBar
        }
    }
    
    private func prepareUI() {
        bonusesBarButton.isEnabled = isEditableMode
        if isEditableMode {
            nameTextField.text = employee!.name
            birthdayTextField.text = formatter.string(from: employee!.dateOfBirth! as Date)
            startWorkTextField.text = formatter.string(from: employee!.dateOfStartWork! as Date)
            sallaryTextField.text = "\(employee!.sallary)"
            mobilePhone.text = employee!.phoneNumber!
        }
        else {
            nameTextField.text = ""
            birthdayTextField.text = ""
            startWorkTextField.text = ""
            sallaryTextField.text = ""
            mobilePhone.text = ""
        }
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    func tapGesture() {
        nameTextField.resignFirstResponder()
        birthdayTextField.resignFirstResponder()
        startWorkTextField.resignFirstResponder()
        sallaryTextField.resignFirstResponder()
        mobilePhone.resignFirstResponder()
    }
}

extension PDBEmployeeCreatorVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
}
