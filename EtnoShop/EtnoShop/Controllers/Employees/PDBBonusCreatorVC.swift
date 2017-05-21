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
        // Do any additional setup after loading the view.
    }

    //MARK: - IBActions
    @IBAction func onSave(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        CoreDataManager.sharedInstanse.addBonus(employee: employee, dateOfCreation: formatter.date(from: dateTextField.text!)!, amout: Int16(amountTextField.text!)!)
        navigationController?.popViewController(animated: true)
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
}
