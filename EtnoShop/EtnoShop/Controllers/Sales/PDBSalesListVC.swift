//
//  PDBSalesListVC.swift
//  EtnoShop
//
//  Created by админ on 5/23/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBSalesListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    static let identifier = "PDBSalesListID"
    
    var sales: [Sale] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadContent()
    }
    
    //MARK: - IBAction
    @IBAction func onAdd(_ sender: Any) {
        let vc = UIStoryboard(name: "Sales", bundle: nil).instantiateViewController(withIdentifier: PDBSaleCreatorVC.identifier) as! PDBSaleCreatorVC
        vc.isEditableMode = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sales.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            CoreDataManager.sharedInstanse.deleteMObj(data: sales[indexPath.row])
            sales.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PDBMenuCell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        let sale: Sale = sales[indexPath.row]
        cell.mainTextLabel.text = "\(sale.product!.name) (\(sale.amount) * \(sale.pricePerOne)$ (\(sale.salesman!.name!)))"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Arrival", bundle: nil).instantiateViewController(withIdentifier: PDBSaleCreatorVC.identifier) as! PDBSaleCreatorVC
        vc.sale = sales[indexPath.row]
        vc.isEditableMode = false
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: - private
    func setupUI() {
        tableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
    
    func loadContent() {
        sales = CoreDataManager.sharedInstanse.loadAllSales()
    }
    
    
}
