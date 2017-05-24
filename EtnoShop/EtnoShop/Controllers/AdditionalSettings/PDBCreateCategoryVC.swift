//
//  PDBCreateCategoryVC.swift
//  EtnoShop
//
//  Created by админ on 5/22/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBCreateCategoryVC: UIViewController {

    //MARK: - properties
    @IBOutlet weak var nameTextField: UITextField!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func onSaveCategory(_ sender: Any) {
        if checkIfError() {
            showErrorAlert()
        }
        else {
        CoreDataManager.sharedInstanse.addCategory(name: nameTextField.text!)
        self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    func tapGesture() {
        nameTextField.resignFirstResponder()
    }
    
    func checkIfError() -> Bool {
        if nameTextField.text == nil  {
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
