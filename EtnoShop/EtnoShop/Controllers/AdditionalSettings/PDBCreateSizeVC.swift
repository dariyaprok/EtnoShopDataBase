//
//  PDBCreateSizeVC.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBCreateSizeVC: UIViewController {
    
    static let identifier = "PDBNewSizeVC"
    
    //MARK: - properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var shouldersLangthTextField: UITextField!
    @IBOutlet weak var waistTextField: UITextField!
    
    var isEditableMode: Bool = false

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        // Do any additional setup after loading the view.
    }


    //MARK: - IBActions
    @IBAction func onSave(_ sender: Any) {
        if checkIfError() {
            showErrorAlert()
        }
        else {
        CoreDataManager.sharedInstanse.addSize(name: nameTextField.text!, shoulderLength: Int16(shouldersLangthTextField.text!)!, waistLength: Int16(waistTextField.text!)!)
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    func tapGesture() {
        nameTextField.resignFirstResponder()
        shouldersLangthTextField.resignFirstResponder()
        waistTextField.resignFirstResponder()
    }
    
    func checkIfError() -> Bool {
        if nameTextField == nil || !isOnlyNumbers(text: shouldersLangthTextField.text) || !isOnlyNumbers(text: waistTextField.text)  {
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
