//
//  PDBCategoryListVC.swift
//  EtnoShop
//
//  Created by админ on 5/22/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBCategoryListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PDBProductParameterPicker {

    //MARK: - properties
    @IBOutlet weak var tableView: UITableView!
    
    private var productPickerDelegate :PDBProductParameterPickerDelegate?
    public var isPickingMode: Bool = false
    
    var categories: [Category] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK: - product parametrPicker
    func setDelegate(delegate: PDBProductParameterPickerDelegate) {
        productPickerDelegate = delegate
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadContent()
    }
    
    //MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PDBMenuCell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        cell.mainTextLabel.text = categories[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            CoreDataManager.sharedInstanse.deleteMObj(data: categories[indexPath.row])
            categories.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPickingMode && productPickerDelegate != nil {
            productPickerDelegate?.viewControllerPickParameter(data: categories[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //MARK: - private
    func setupUI() {
        tableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
    
    func loadContent() {
        categories = CoreDataManager.sharedInstanse.loadAllCategories()
    }
    
    


}
