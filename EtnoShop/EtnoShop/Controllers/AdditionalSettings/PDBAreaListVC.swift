//
//  PDBAreaListVC.swift
//  EtnoShop
//
//  Created by админ on 5/21/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

class PDBAreaListVC: UIViewController, UITableViewDataSource, UITableViewDelegate, PDBProductParameterPicker {
    
    static let identifier = "PDBAreaListVC"

    //MARK: - properties
    @IBOutlet weak var tableView: UITableView!
    
    private var productPickerDelegate: PDBProductParameterPickerDelegate?
    public var isPickingMode: Bool = false
    
    var areas: [Area] = [] {
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
        var vc = UIStoryboard(name: "AdditionalSettings", bundle: nil).instantiateViewController(withIdentifier: PDBCreateAreaVC.identifier) //as! PDBProductParameterPicker
        //vc.isEditableMode = false
        self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
    }
    
    //MARK: - product parametrPicker
    func setDelegate(delegate: PDBProductParameterPickerDelegate) {
        productPickerDelegate = delegate
    }
    
    //MARK: - table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PDBMenuCell = tableView.dequeueReusableCell(withIdentifier: PDBMenuCell.identifier, for: indexPath) as! PDBMenuCell
        cell.mainTextLabel.text = areas[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isPickingMode && productPickerDelegate != nil {
            productPickerDelegate?.viewControllerPickParameter(data: areas[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            CoreDataManager.sharedInstanse.deleteMObj(data: areas[indexPath.row])
            areas.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
    }
    
    //MARK: - private
    func setupUI() {
        tableView.register(UINib(nibName: PDBMenuCell.identifier, bundle: nil), forCellReuseIdentifier: PDBMenuCell.identifier)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 0))
    }
    
    func loadContent() {
        areas = CoreDataManager.sharedInstanse.loadAllAreas()
    }


}
