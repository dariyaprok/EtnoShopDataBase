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

    //MARK: - private
    func setupUI() {
        tableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
}
