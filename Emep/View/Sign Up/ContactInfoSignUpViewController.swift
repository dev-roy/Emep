//
//  ContactInfoSignUpViewController.swift
//  Emep
//
//  Created by Rodrigo Buendia Ramos on 6/4/20.
//  Copyright © 2020 Rodrigo Buendia Ramos. All rights reserved.
//

import UIKit
import ValidationTextField

class ContactInfoSignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: ValidationTextField!
    @IBOutlet weak var passwordTextField: ValidationTextField!
    @IBOutlet weak var confirmPasswordTextField: ValidationTextField!
    @IBOutlet weak var phoneNumberTextField: ValidationTextField!
    @IBOutlet weak var signUpBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setUpValidationTextFields()
    }
    
    private func addTargets() {
        emailTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        phoneNumberTextField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
    }
    
    private func setUpValidationTextFields() {
        emailTextField.validCondition = {$0.contains("@")}
        passwordTextField.validCondition = {$0.count > 7}
        confirmPasswordTextField.validCondition = { return $0 == self.passwordTextField.text }
        phoneNumberTextField.validCondition = {$0.count > 7}
    }
    
    // MARK: - Handlers
    @objc func formValidation() {
        guard
            emailTextField.isValid,
            passwordTextField.isValid,
            confirmPasswordTextField.isValid else {
                signUpBtn.isEnabled = false
                signUpBtn.alpha = 0.5
                return
        }
        signUpBtn.isEnabled = true
        signUpBtn.alpha = 1.0
    }
}
