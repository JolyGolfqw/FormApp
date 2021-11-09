//
//  File.swift
//  formApp
//
//  Created by MacBook Pro on 01.04.2021.
//

import UIKit

class FormHistoryViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var iconView: UIView! {
        didSet {
            iconView.layer.cornerRadius = iconView.frame.size.height / 2
            iconView.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleCell: UILabel! {
        didSet {
            titleCell.font = UIFont(name: "Roboto-Regular", size: 16)
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = UIFont(name: "Roboto-Light", size: 14)
        }
    }
}
