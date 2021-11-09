//
//  SendedState.swift
//  SET
//
//  Created by Soslan-Bek Tsomaev on 30.03.2021.
//  Copyright © 2021 tawfik. All rights reserved.
//

import UIKit

enum SendedState {
    case success
    case failure
    
    var buttonColor: UIColor {
        switch self {
        case .success: return #colorLiteral(red: 0.1245167777, green: 0.5449713469, blue: 0.1376625299, alpha: 1)
        case .failure: return #colorLiteral(red: 0.6609038711, green: 0.05113709718, blue: 0.2750061154, alpha: 1)
        }
    }
    
    var icon: UIImage {
        switch self {
        case .success: return UIImage(named: "check")!
        case .failure: return UIImage(named: "close")!
        }
    }
    
    var title: String {
        switch self {
        case .success: return "Successful state"
        case .failure: return "Something wrong"
        }
    }
    
    var description: String {
        switch self {
        case .success: return "Your form was successfully submitted"
        case .failure: return "We’re so sorry this happened \nPlease, check everything"
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .success: return "Confirm"
        case .failure: return "Continue"
        }
    }
}
