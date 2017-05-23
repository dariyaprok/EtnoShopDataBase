//
//  PDBSizesVC.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBSizesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - properties
    @IBOutlet weak var sizesTableView: UITableView!
    
    var sizes:[Size] = [] {
        didSet {
            sizesTableView.reloadData()
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadContent()
    }
    
    //MARK: - IBAction
    @IBAction func onAdd(_ sender: Any) {
        var vc = UIStoryboard(name: "AdditionalSettings", bundle: nil).instantiateViewController(withIdentifier: PDBCreateSizeVC.identifier) as! PDBProductParameterPicker
        vc.isEditableMode = false
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
        
    }
    
    //MARK: - table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        cell.mainTextLabel.text = sizes[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sizes.count
    }
    
    //MARK: - private
    private func loadContent() {
        sizes = CoreDataManager.sharedInstanse.loadAllSizes()
    }
    
    private func setupUI() {
        sizesTableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        sizesTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: sizesTableView.frame.size.width, height: 0))
    }
}
