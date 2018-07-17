//
//  UILabel+Validation.swift
//  ReactiveProgramming
//
//  Created by Kacper Woźniak on 21/02/2017.
//  Copyright © 2017 Kacper Woźniak. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UILabel {

    var validationResult: UIBindingObserver<Base, ValidationResult> {
        return UIBindingObserver(UIElement: base) { label, result in
            label.text = result.message
            label.isHidden = result.message.isEmpty
        }
    }
    
}
