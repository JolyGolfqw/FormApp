//
//  FormFillTextFieldCell.swift
//  formApp
//
//  Created by MacBook Pro on 08.04.2021.
//

import UIKit

class FormFillTextFieldCell: UITableViewCell {
    
    // MARK: - Identifier
    class var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Outlet
    @IBOutlet weak var infoTextField: UITextField!

    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
