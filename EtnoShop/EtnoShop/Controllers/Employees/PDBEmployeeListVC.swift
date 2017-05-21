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
    private var employees: [Employee]! {
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
    
    override func viewWillAppear(_ animated: Bool) {
        loadContent()
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Employees", bundle: nil).instantiateViewController(withIdentifier: "PDBEmployeeCreator") as! PDBEmployeeCreatorVC
        vc.isEditableMode = true
        vc.employee = employees[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - IBActions
    @IBAction func onAdd(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Employees", bundle: nil).instantiateViewController(withIdentifier: "PDBEmployeeCreator") as! PDBEmployeeCreatorVC
        vc.isEditableMode = false
        self.navigationController?.pushViewController(vc, animated: true)
    }

    //MARK: - private
    private func setupTableView() {
        employeeListTableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
    }
    
    private func loadContent() {
        employees = CoreDataManager.sharedInstanse.loadAllEmployees()!
    }
    
}
