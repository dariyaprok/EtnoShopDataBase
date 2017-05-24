//
//  PDBBonusListVC.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBBonusListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - properties
    @IBOutlet weak var bonusesTableView: UITableView!
    
    static let identifier = "bonusesListVC"
    
    var employee: Employee! {
        didSet {
            bonuses = Array(employee.bonus!) as! [Bonus]
        }
    }
    var bonuses: [Bonus] = []
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bonuses = Array(employee.bonus!) as! [Bonus]
        bonusesTableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func onAddBonus(_ sender: Any) {
        let vc: PDBBonusCreatorVC = UIStoryboard(name: "Employees", bundle: nil).instantiateViewController(withIdentifier: PDBBonusCreatorVC.identifier) as! PDBBonusCreatorVC
        vc.employee = employee
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bonuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.mm.yyyy"
        cell.mainTextLabel.text = "\(bonuses[indexPath.row].amount) (\(formatter.string(from:bonuses[indexPath.row].dateOfCreation as! Date)))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            CoreDataManager.sharedInstanse.deleteMObj(data: bonuses[indexPath.row])
            bonuses.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    
    //MARK: - private
    private func setupUI() {
        bonusesTableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
    }
}
