//
//  SignUpViewController.swift
//  ReactiveProgramming
//
//  Created by Kacper Woźniak on 04/01/2017.
//  Copyright © 2017 Kacper Woźniak. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailValidationErrorLabel: UILabel!

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordValidationErrorLabel: UILabel!

    @IBOutlet weak var reenterPasswordTextField: UITextField!
    @IBOutlet weak var reenterPasswordValidationErrorLabel: UILabel!

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var firstNameValidationErrorLabel: UILabel!

    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var lastNameValidationErrorLabel: UILabel!

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var phoneNumberValidationErrorLabel: UILabel!

    @IBOutlet weak var submitButton: UIButton!

    let disposeBag = DisposeBag()
    let viewModel = SignUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.rx.text.orEmpty.bindTo(viewModel.email).addDisposableTo(disposeBag)
        passwordTextField.rx.text.orEmpty.bindTo(viewModel.password).addDisposableTo(disposeBag)
        reenterPasswordTextField.rx.text.orEmpty.bindTo(viewModel.password2).addDisposableTo(disposeBag)
        firstNameTextField.rx.text.orEmpty.bindTo(viewModel.firstName).addDisposableTo(disposeBag)
        lastNameTextField.rx.text.orEmpty.bindTo(viewModel.lastName).addDisposableTo(disposeBag)
        phoneNumberTextField.rx.text.orEmpty.bindTo(viewModel.phoneNumber).addDisposableTo(disposeBag)

        viewModel.emailValidationResult.drive(emailValidationErrorLabel.rx.validationResult).addDisposableTo(disposeBag)
        viewModel.passwordValidationResult.drive(passwordValidationErrorLabel.rx.validationResult).addDisposableTo(disposeBag)
        viewModel.password2ValidationResult.drive(reenterPasswordValidationErrorLabel.rx.validationResult).addDisposableTo(disposeBag)
        viewModel.firstNameValidationResult.drive(firstNameValidationErrorLabel.rx.validationResult).addDisposableTo(disposeBag)
        viewModel.lastNameValidationResult.drive(lastNameValidationErrorLabel.rx.validationResult).addDisposableTo(disposeBag)
        viewModel.phoneNumberValidationResult.drive(phoneNumberValidationErrorLabel.rx.validationResult).addDisposableTo(disposeBag)
        viewModel.isValid.drive(submitButton.rx.isEnabled).addDisposableTo(disposeBag)

        submitButton.rx.tap.subscribe(onNext: { [weak self] in self?.viewModel.submit() }).addDisposableTo(disposeBag)
    }

}
