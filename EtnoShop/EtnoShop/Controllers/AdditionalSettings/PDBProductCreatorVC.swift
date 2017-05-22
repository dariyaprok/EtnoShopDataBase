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
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            let vc = UIStoryboard(name: "AdditionalSettings", bundle: nil).instantiateViewController(withIdentifier: identiFierForResource(parameterModel: activeEditingParameter)) as! PDBProductParameterPicker
            vc.setDelegate(delegate: self)
            self.navigationController?.pushViewController(vc as! UIViewController, animated: true)
            return false
        }
        return true
    }

    //MARK: - PDBProductCreatorDelegate
    func viewControllerPickParameter(data: Any) {
        dataForProduct[identiFierForResource(parameterModel: activeEditingParameter)] = data
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
}
