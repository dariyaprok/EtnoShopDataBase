//
//  PDBProductCreatorVC.swift
//  EtnoShop
//
//  Created by админ on 5/22/17.
//  Copyright © 2017 dashaproduction. All rights reserved.
//

import UIKit

enum PDBParameterModel {
    case category
    case area
    case none
}


protocol PDBProductParameterPickerDelegate {
    func viewControllerPickParameter(data: Any)
}

protocol PDBProductParameterPicker {
    func setDelegate(delegate: PDBProductParameterPickerDelegate)
    var isPickingMode: Bool {get set}
}

class PDBProductCreatorVC: UIViewController, UITextFieldDelegate, PDBProductParameterPickerDelegate {
    
    static let identifier = "PDBProductCreatorVCID"
    
    //MARK: - properties
    @IBOutlet weak var namrTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var categorytextField: UITextField!
    
    var isEditableMode: Bool = false
    var activeEditingParameter: PDBParameterModel = .none
    var dataForProduct: [String: Any] = [:]
    var product: Product? {
        didSet {
            if product != nil {
                dataForProduct[identiFierForResource(parameterModel: PDBParameterModel.area)] = product?.area
                dataForProduct[identiFierForResource(parameterModel: PDBParameterModel.category)] = product?.category
            }
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    //MARK: - IBActions
    @IBAction func onCreateProduct(_ sender: Any) {
        let area = dataForProduct[identiFierForResource(parameterModel: PDBParameterModel.area)]
        let category = dataForProduct[identiFierForResource(parameterModel: PDBParameterModel.category)]
        if category != nil && area != nil {
            if isEditableMode {
                CoreDataManager().editProduct(product: product!, name: namrTextField!.text!, area: area as! Area, category: category as! Category)
            }
            else {
                CoreDataManager().addProduct(name: namrTextField.text!, area: area as! Area, category: category as! Category)
            }
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    //MARK: - text field
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case namrTextField:
            activeEditingParameter = .none
            break
        case areaTextField:
            activeEditingParameter = .area
            break
        default:
            activeEditingParameter = .category
            break
        }
        if activeEditingParameter != .none {
            var vc = UIStoryboard(name: "AdditionalSettings", bundle: nil).instantiateViewController(withIdentifier: identiFierForResource(parameterModel: activeEditingParameter)) as! PDBProductParameterPicker
            vc.setDelegate(delegate: self)
            vc.isPickingMode = true
            self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
            return false
        }
        return true
    }
    
    //MARK: - PDBProductCreatorDelegate
    func viewControllerPickParameter(data: Any) {
        dataForProduct[identiFierForResource(parameterModel: activeEditingParameter)] = data
        if let area = data as? Area {
            areaTextField.text = area.name
        }
        else if let category = data as? Category {
            categorytextField.text = category.name
        }
    }
    
    //MARK: - private
    private func identiFierForResource(parameterModel: PDBParameterModel) -> String {
        switch parameterModel {
        case .category:
            return "PDBCategoryListVCID"
        default:
            return "PDBAreaListVCID"
        }
    }
    
    private func setupUI() {
        if isEditableMode && product != nil {
            namrTextField.text = product!.name
            areaTextField.text = product!.area!.name
            categorytextField.text = product!.category!.name
        }
        else {
            namrTextField.text = nil
            areaTextField.text = nil
            categorytextField.text = nil
        }
    }
}
