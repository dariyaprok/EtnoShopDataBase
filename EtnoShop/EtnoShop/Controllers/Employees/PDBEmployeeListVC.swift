//
//  PDBEmployeeListVC.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBEmployeeListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - properties
    @IBOutlet weak var employeeListTableView: UITableView!
    private var employees: [Employee] = [] {
        didSet {
            employeeListTableView.reloadData()
        }
    }
    
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
    }

    //MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as? PDBMenuCell
        cell?.mainTextLabel.text = employees[indexPath.row].name!
        return cell!
    }
    
    //MARK: - IBActions

    //MARK: - private
    private func setupTableView() {
        employeeListTableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
    }
    
    
}
