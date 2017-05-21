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
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func onSaveCategory(_ sender: Any) {
        CoreDataManager.sharedInstanse.addCategory(name: nameTextField.text!)
        self.navigationController?.popViewController(animated: true)
    }
}
