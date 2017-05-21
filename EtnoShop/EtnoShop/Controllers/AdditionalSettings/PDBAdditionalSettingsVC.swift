//
//  PDBAdditionalSettingsVC.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBAdditionalSettingsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var additionalSettingsTableView: UITableView!
    
    private let content = ["Products", "Sizes", "Areas", "Categories"]
    private let viewControllers: [(storyboardName:String, vcId:String)] = [("", ""), ("AdditionalSettings", "PDBSizesVC"), ("", ""), ("Employees", "PDBEmployeesListVC"), ("","")]
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PDBMenuCell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        cell.mainTextLabel.text = content[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            let vcInfo = viewControllers[indexPath.row]
            let vc = UIStoryboard(name: vcInfo.storyboardName, bundle: nil).instantiateViewController(withIdentifier: vcInfo.vcId)
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    //MARK: - private
    func setupUI() {
        additionalSettingsTableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        additionalSettingsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: additionalSettingsTableView.frame.size.width, height: 0))
    }
}
