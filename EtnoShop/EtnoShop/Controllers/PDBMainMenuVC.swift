//
//  MainMenuVC.swift
//  EtnoShop
//
//  Created by админ on 5/18/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBMainMenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!
    
    private let content = ["Склад", "Продажі", "Прибутки", "Працівники", "Додаткові настройки"]
    private let viewControllers: [(storyboardName:String, vcId:String)] = [("Arrival", PDBArrivalListVC.identifier), ("Sales", PDBSalesListVC.identifier), ("", ""), ("Employees", "PDBEmployeesListVC"), ("AdditionalSettings","AdditionalSettingsVC")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }

    //MARK: - table view datasource & delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PDBMenuCell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        cell.mainTextLabel.text = content[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vcInfo = viewControllers[indexPath.row]
            let vc = UIStoryboard(name: vcInfo.storyboardName, bundle: nil).instantiateViewController(withIdentifier: vcInfo.vcId)
            self.navigationController?.pushViewController(vc, animated: true)
    }

    //MARK: - private
    func setupUI() {
        tableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
}
