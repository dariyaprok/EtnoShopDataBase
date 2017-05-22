//
//  PDBProductListVC.swift
//  EtnoShop
//
//  Created by админ on 5/22/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBProductListVC: UIViewController, UITableViewDataSource {
    
    static let identifier = "PDBProductListVC"
    
    //MARK: - properties
    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadContent()
    }
    
    //MARK: - IBActions
    @IBAction func onAdd(_ sender: Any) {
    }
    
    //MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PDBMenuCell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        cell.mainTextLabel.text = products[indexPath.row].name
        return cell
    }
    
    //MARK: - private
    func setupUI() {
        tableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
    
    func loadContent() {
        products = CoreDataManager.sharedInstanse.loadAllProducts()
    }
    
    
    

}
