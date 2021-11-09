//
//  UIStoryboard+extension.swift
//  formApp
//
//  Created by MacBook Pro on 03.04.2021.
//

import UIKit

extension UIStoryboard {
    static func get<T>(_ type: T.Type) -> T {
        let id = String(describing: type)
        let storyboard = UIStoryboard(name: id, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            return storyboard.instantiateViewController(withIdentifier: id) as! T
        }
    }
}
