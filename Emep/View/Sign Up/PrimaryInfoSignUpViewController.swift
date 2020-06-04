//
//  PrimaryInfoSignUpViewController.swift
//  Emep
//
//  Created by Rodrigo Buendia Ramos on 6/4/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import UIKit
import ValidationTextField

class PrimaryInfoSignUpViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: ValidationTextField!
    @IBOutlet weak var lastNameTextField: ValidationTextField!
    @IBOutlet weak var dobTextField: ValidationTextField!
    @IBOutlet weak var policyNumberTextField: ValidationTextField!
    
    @IBOutlet weak var nextBtn: UIButton!
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setUpValidationTextFields()
    }
    
    private func addTargets() {
        nameTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        dobTextField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        dobTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        policyNumberTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
    }
    
    private func setUpValidationTextFields() {
        nameTextField.validCondition = {$0.count > 1 }
        lastNameTextField.validCondition = {$0.count > 1 && $0.contains(" ")}
        // TODO: - Find a way to validate DOB
        dobTextField.validCondition = {$0.count > 3}
        policyNumberTextField.validCondition = {$0.count > 7}
    }
    
    // MARK: - Handlers
    @objc func formValidation() {
        guard
            nameTextField.isValid,
            lastNameTextField.isValid else {
                nextBtn.isEnabled = false
                nextBtn.alpha = 0.5
                return
        }
        nextBtn.isEnabled = true
        nextBtn.alpha = 1.0
    }
    
    @objc private func doneButtonPressed() {
        if let datePicker = dobTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dobTextField.text = dateFormatter.string(from: datePicker.date)
        }
        dobTextField.resignFirstResponder()
    }
}
