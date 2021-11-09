//
//  ResultViewController.swift
//  formApp
//
//  Created by MacBook Pro on 30.03.2021.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - Properties
    var sendFormState: SendedState!
    var didFinishWork: (() -> Void)?
    
    // MARK: - IBOutlets
    @IBOutlet weak var resultLabel: UILabel! {
        didSet {
            resultLabel.font = UIFont(name: "IBMPlexSans-Bold", size: 34)
        }
    }
    @IBOutlet weak var resultMessage: UILabel! {
        didSet {
            resultMessage.font = UIFont(name: "IBMPlexSans-Text", size: 20)
        }
    }
    @IBOutlet weak var buttonOutlet: UIButton!
    @IBOutlet weak var resultImage: UIImageView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        dismiss(animated: true) {
            switch self.sendFormState {
            case .success: self.didFinishWork?()
            case .failure: print("")
            default: break
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        buttonOutlet.clipsToBounds = true
        buttonOutlet.layer.cornerRadius = 10
    }
    
    // MARK: - IBAction
    @IBAction func buttonAction(_ sender: UIButton) {
        dismiss(animated: true) {
            switch self.sendFormState {
            case .success: self.didFinishWork?()
            case .failure: print("")
            default: break
            }
        }
    }
}

// MARK: - Setup
private extension ResultViewController {
    func setup() {
        configureData()
    }
    
    func configureData() {
        resultImage.image = sendFormState.icon
        resultLabel.text = sendFormState.title
        resultMessage.text = sendFormState.description
        buttonOutlet.titleLabel?.font = UIFont(name: "IBMPlexSans-SemiBold", size: 16)
        buttonOutlet.backgroundColor = sendFormState.buttonColor
        buttonOutlet.setTitle(sendFormState.buttonTitle, for: .normal)
    }
}
