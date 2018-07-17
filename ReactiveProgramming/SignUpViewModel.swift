//
//  SignUpViewModel.swift
//  ReactiveProgramming
//
//  Created by Kacper Woźniak on 05/01/2017.
//  Copyright © 2017 Kacper Woźniak. All rights reserved.
//

import RxSwift
import RxCocoa

struct SignUpViewModel {

    let email = Variable<String>("")
    let password = Variable<String>("")
    let password2 = Variable<String>("")
    let firstName = Variable<String>("")
    let lastName = Variable<String>("")
    let phoneNumber = Variable<String>("")

    var emailValidationResult: Driver<ValidationResult> {
        return email.asDriver().map {
            $0.characters.isEmpty ? .empty : $0.characters.count >= 5 ? .ok : .failed(message: "The email is too short.")
        }
    }

    var passwordValidationResult: Driver<ValidationResult> {
        return password.asDriver().map {
            $0.characters.isEmpty ? .empty : $0.characters.count >= 5 ? .ok : .failed(message: "The password is too short.")
        }
    }

    var password2ValidationResult: Driver<ValidationResult> {
        return Driver.combineLatest(password.asDriver(), password2.asDriver()) {
            $1.characters.isEmpty ? .empty : $0 == $1 ? .ok : .failed(message: "Passwords do not match.")
        }
    }

    var firstNameValidationResult: Driver<ValidationResult> {
        return firstName.asDriver().map {
            $0.characters.isEmpty ? .empty : $0.characters.count >= 5 ? .ok : .failed(message: "The first name is too short.")
        }
    }

    var lastNameValidationResult: Driver<ValidationResult> {
        return lastName.asDriver().map {
            $0.characters.isEmpty ? .empty : $0.characters.count >= 5 ? .ok : .failed(message: "The last name is too short.")
        }
    }

    var phoneNumberValidationResult: Driver<ValidationResult> {
        return phoneNumber.asDriver().map {
            $0.characters.isEmpty ? .empty : $0.characters.count >= 9 ? .ok : .failed(message: "The phone number is too short.")
        }
    }

    var isValid: Driver<Bool> {
        let fields = [emailValidationResult, passwordValidationResult, password2ValidationResult, firstNameValidationResult, lastNameValidationResult, phoneNumberValidationResult]
        return Driver.combineLatest(fields) {
            for field in $0 {
                guard field.isValid else { return false }
            }
            return true
        }
    }

    func submit() {
        print("email: \(email.value)\npassword: \(password.value)\nfirst name: \(firstName.value)\nlast name: \(lastName.value)\nphone number: \(phoneNumber.value)")
    }

}
