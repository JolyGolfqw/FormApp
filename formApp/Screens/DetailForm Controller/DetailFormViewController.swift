//
//  HistoryViewController.swift
//  formApp
//
//  Created by MacBook Pro on 01.04.2021.
//

import UIKit

final class DetailFormViewController: UIViewController {
    
    // MARK: - Properties
    var nameLastName = ""
    var phone = ""
    var email = ""
    var message = ""
 
    // MARK: - Outlets
    @IBOutlet weak var phoneH: UILabel!
    @IBOutlet weak var emailH: UILabel!
    @IBOutlet weak var messageH: UILabel!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.largeTitleDisplayMode = .never // always - большой заголовок
    }
        
        // MARK: - Propeties string
        func updateText() {
            let boldPhone = "Phone: "
            let boldEmail = "Email: "
            let boldMessage = "Message: "
            
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
            let attributedStringPhone = NSMutableAttributedString(string:boldPhone, attributes:attrs)
            let attributedStringEmail = NSMutableAttributedString(string:boldEmail, attributes:attrs)
            let attributedStringMessage = NSMutableAttributedString(string:boldMessage, attributes:attrs)

            let phoneText = "\(phone)"
            let emailText = "\(email)"
            let messageText = "\n\(message)"

            let phoneString = NSMutableAttributedString(string:phoneText)
            let emaillString = NSMutableAttributedString(string:emailText)
            let messagelString = NSMutableAttributedString(string:messageText)

            attributedStringPhone.append(phoneString)
            attributedStringEmail.append(emaillString)
            attributedStringMessage.append(messagelString)
            
            phoneH.attributedText = attributedStringPhone
            emailH.attributedText = attributedStringEmail
            messageH.attributedText = attributedStringMessage

         
            self.navigationItem.title = nameLastName
    }
}
