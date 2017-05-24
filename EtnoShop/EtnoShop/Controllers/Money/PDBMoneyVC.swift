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

}
