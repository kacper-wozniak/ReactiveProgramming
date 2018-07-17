//
//  ValidationResult.swift
//  ReactiveProgramming
//
//  Created by Kacper Woźniak on 20/02/2017.
//  Copyright © 2017 Kacper Woźniak. All rights reserved.
//

import UIKit
import RxSwift

enum ValidationResult {

    case ok
    case failed(message: String)
    case empty

    var message: String {
        switch self {
        case .failed(let message): return message
        default: return ""
        }
    }

    var isValid: Bool {
        switch self {
        case .ok: return true
        default: return false
        }
    }
    
}
