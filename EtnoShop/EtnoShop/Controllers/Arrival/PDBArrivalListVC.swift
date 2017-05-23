//
//  PDBArrivalListVC.swift
//  EtnoShop
//
//  Created by админ on 5/23/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBArrivalListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "PDBArrivalsListVCID"
    
    var arrivals: [Arrival] = [] {
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
        let vc = UIStoryboard(name: "Arrival", bundle: nil).instantiateViewController(withIdentifier: PDBArrivalCreatorVC.identifier) as! PDBArrivalCreatorVC
        vc.isEditableMode = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PDBMenuCell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        let arraval: Arrival = arrivals[indexPath.row]
        cell.mainTextLabel.text = "\(arraval.product!.name) (\(arraval.amount) * \(arraval.pricePerOne)$)"
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Arrival", bundle: nil).instantiateViewController(withIdentifier: PDBArrivalCreatorVC.identifier) as! PDBArrivalCreatorVC
        vc.arrival = arrivals[indexPath.row]
        vc.isEditableMode = false
        navigationController?.pushViewController(vc, animated: true)

    }
    
    //MARK: - private
    func setupUI() {
        tableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
    
    func loadContent() {
        arrivals = CoreDataManager.sharedInstanse.loadAllAriivals()
    }


}
