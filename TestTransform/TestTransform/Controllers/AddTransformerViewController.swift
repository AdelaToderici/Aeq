//
//  AddTransformerViewController.swift
//  TestTransform
//
//  Created by Adela Toderici on 2018-09-06.
//  Copyright © 2018 Adela Toderici. All rights reserved.
//

import UIKit

protocol TransformerDelegate {
    func addTransformer(_ transformer: Transformer)
}

class AddTransformerViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var strengthTextField: UITextField!
    @IBOutlet weak var intelligenceTextField: UITextField!
    @IBOutlet weak var speedTextField: UITextField!
    @IBOutlet weak var enduranceTextField: UITextField!
    @IBOutlet weak var rankTextField: UITextField!
    @IBOutlet weak var courageTextField: UITextField!
    @IBOutlet weak var firepowerTextField: UITextField!
    @IBOutlet weak var skillTextField: UITextField!
    
    var transformer: Transformer!
    var transformerDelegate: TransformerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        transformer = Transformer(name: "", type: TransformerType.Autobot, strength: 1, intelligence: 1, speed: 1, endurance: 1, rank: 1, courage: 1, firepower: 1, skill: 1)
    }

    @IBAction func addTransformerAction(_ sender: Any) {
        if isInvalidTransformer() {
            showAlert()
            return
        }
        
        transformerDelegate?.addTransformer(transformer)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapAction(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            transformer.type = .Autobot
        case 1:
            transformer.type = .Decepticon
        default:
            break
        }
    }
}

// MARK: Private methods
extension AddTransformerViewController {
    
    func isInvalidTransformer() -> Bool {
        if let nameField = nameTextField.text, nameField.isEmpty {
            return true
        }
        
        return false
    }
    
    func showAlert() {
        let alertView = UIAlertController(title: "Warning", message: "Please complete the name field.", preferredStyle: .alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertView, animated: true, completion: nil)
    }
}

// MARK: UITextFieldDelegate methods
extension AddTransformerViewController: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField, let name = nameTextField.text {
            transformer.name = name
        }
        if textField == strengthTextField, let strength = strengthTextField.text {
            transformer.strength = Int(strength) ?? 1
        }
        if textField == intelligenceTextField, let intelligence = intelligenceTextField.text {
            transformer.intelligence = Int(intelligence) ?? 1
        }
        if textField == speedTextField, let speed = speedTextField.text {
            transformer.speed = Int(speed) ?? 1
        }
        if textField == enduranceTextField, let endurance = enduranceTextField.text {
            transformer.endurance = Int(endurance) ?? 1
        }
        if textField == rankTextField, let rank = rankTextField.text {
            transformer.rank = Int(rank) ?? 1
        }
        if textField == courageTextField, let courage = courageTextField.text {
            transformer.courage = Int(courage) ?? 1
        }
        if textField == firepowerTextField, let firepower = firepowerTextField.text {
            transformer.firepower = Int(firepower) ?? 1
        }
        if textField == skillTextField, let skill = skillTextField.text {
            transformer.skill = Int(skill) ?? 1
        }
    }
}
