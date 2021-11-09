//
//  FormMessageTableViewCell.swift
//  formApp
//
//  Created by MacBook Pro on 10.04.2021.
//

import UIKit

class FormMessageTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    class var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var messageLabel: UILabel!
    
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
