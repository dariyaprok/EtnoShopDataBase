//
//  PDBCreateAreaVC.swift
//  EtnoShop
//
//  Created by админ on 5/22/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBCreateAreaVC: UIViewController {
    
    static let identifier = "PDBNewAreaVC"

    //MARK: - properties
    @IBOutlet weak var nameAreaTextField: UITextField!
    
    @IBOutlet weak var areaTextField: UITextField!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGesture()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - IBActions
    @IBAction func onSave(_ sender: Any) {
        CoreDataManager.sharedInstanse.addArea(name: nameAreaTextField.text!)
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        view.addGestureRecognizer(tap)
    }
    
    func tapGesture() {
        areaTextField.resignFirstResponder()
    }
}

