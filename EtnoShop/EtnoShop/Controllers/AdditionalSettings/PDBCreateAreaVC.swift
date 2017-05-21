//
//  PDBCreateAreaVC.swift
//  EtnoShop
//
//  Created by админ on 5/22/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBCreateAreaVC: UIViewController {

    //MARK: - properties
    @IBOutlet weak var nameAreaTextField: UITextField!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func onSave(_ sender: Any) {
        CoreDataManager.sharedInstanse.addArea(name: nameAreaTextField.text!)
        self.navigationController?.popViewController(animated: true)
    }
}

