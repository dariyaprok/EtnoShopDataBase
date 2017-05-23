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

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    //MARK: - IBActions
    @IBAction func onSave(_ sender: Any) {
        CoreDataManager.sharedInstanse.addSize(name: nameTextField.text!, shoulderLength: Int16(shouldersLangthTextField.text!)!, waistLength: Int16(waistTextField.text!)!)
        self.navigationController?.popViewController(animated: true)
    }
}
