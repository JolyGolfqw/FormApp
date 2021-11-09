//
//  Slides.swift
//  formApp
//
//  Created by MacBook Pro on 08.04.2021.
//

import UIKit

class SlidesView: UIView {
    
    // MARK: - Outlets
    @IBOutlet weak var onboardImage: UIImageView!
    @IBOutlet weak var onboardTextLabel: UILabel! {
        didSet {
            onboardTextLabel.adjustsFontSizeToFitWidth = true
            onboardTextLabel.minimumScaleFactor = 0.5
            onboardTextLabel.font = UIFont(name: "Roboto-Regular", size: 24)
        }
    }
    
    // MARK: - LifeCycle
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - ViewConfigure
    func viewConfigure(with model: OnboardsEnum) {
        onboardTextLabel.text = model.title
        onboardImage.image = model.image
    }
}

