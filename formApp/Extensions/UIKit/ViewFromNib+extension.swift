//
//  ViewFromNib+extension.swift
//  formApp
//
//  Created by MacBook Pro on 08.04.2021.
//

import UIKit

extension UIView {
    class func viewFromNibName(_ name: String) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return views?.first as? UIView
    }
}
