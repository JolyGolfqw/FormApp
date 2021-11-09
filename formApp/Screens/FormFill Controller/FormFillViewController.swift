//
//  TableViewController.swift
//  formApp
//
//  Created by MacBook Pro on 26.03.2021.
//

import UIKit
import MessageUI
import SystemConfiguration

class FormFillViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - PROPERTIES
    var name = ""
    var email = ""
    var phone = ""
    var message = ""
    var lastName = ""
    var nameString = "String"
    var tableViewDataSource: [FormFillModel] = FormFillModel.allCases
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        sendButton.clipsToBounds = true
        sendButton.layer.cornerRadius = 10
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startPresentation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.removeKeyboardObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addKeyboardObserver()
        navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Action
    @IBAction func sendAction(_ sender: UIButton) {
        emptyTextField()
        if self.isInternetAvailable() {
            canSendEmail()
        } else {
            self.showResultController(.failure)
        }
    }
}

// MARK: - TableViewDataSource / TableViewDelegate
extension FormFillViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewDataSource.count
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.tableViewDataSource[indexPath.row]
        
        
        let cell = tableView.dequeue(FormFillTextFieldCell.self, indexPath: indexPath)
        
        cell.infoTextField.delegate = self
        cell.infoTextField.placeholder = item.rawValue
        
        switch item {
        case .name:
            cell.infoTextField.autocapitalizationType = .words
            return cell
        case .lastName:
            cell.infoTextField.autocapitalizationType = .words
            return cell
        case .phone:
            cell.infoTextField.keyboardType = .numberPad
            cell.infoTextField.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
            return cell
        case .email:
            cell.infoTextField.keyboardType = .emailAddress
            return cell
        case .message:
            let cellMessage = tableView.dequeue(FormMessageTableViewCell.self, indexPath: indexPath)
            cellMessage.messageTextView.delegate = self
            self.message = cellMessage.messageTextView.text
            cellMessage.messageTextView.text = "Message  "
            cellMessage.messageTextView.textColor = UIColor.lightGray
            cellMessage.messageTextView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
            cellMessage.messageTextView.layer.cornerRadius = 10
            cellMessage.messageTextView.clipsToBounds = true
            
            self.message = cellMessage.messageTextView.text
            
            return cellMessage
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableViewHeightConstraint.constant = tableView.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected:" + " " + "\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITextViewDelegate
extension FormFillViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidChange(_ textView: UITextView) {
        UIView.setAnimationsEnabled(false)
        textView.sizeToFit()
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message  "
            textView.textColor = UIColor.lightGray
        } else {
            self.message = textView.text
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let enteredText = textField.text ?? ""
        guard let selectedCaseType = FormFillModel(rawValue: textField.placeholder ?? "") else { return }
        switch selectedCaseType {
        case .name:
            self.name = enteredText
        case .lastName:
            self.lastName = enteredText
        case .phone:
            self.phone = enteredText
        case .email:
            self.email = enteredText
        case .message: print("")
        }
    }
}

// MARK: - Private methods
private extension FormFillViewController {
    func setup() {
        configureNavigation()
        configureTableView()
        sendButton.titleLabel?.font = UIFont(name: "IBMPlexSans-SemiBold", size: 16)
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @objc func dismissController() {
        dismiss(animated: true)
    }
    
    func configureNavigation()  {
        self.navigationItem.title = "Fill in the form"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "folder"), style: .plain, target: self, action: #selector(dismissController))
        let attributes = [NSAttributedString.Key.foregroundColor:UIColor.black, NSAttributedString.Key.font:UIFont(name: "IBMPlexSans-SemiBold", size: 17)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.registerNib(FormFillTextFieldCell.self)
        tableView.registerNib(FormMessageTableViewCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func configMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        let messageBody = "<strong>\(name) \(lastName)</strong> </br><strong>Email:</strong> \(email) </br><strong>Phone:</strong> \(phone) </br> </br><strong>Message:</strong> </br>\(message)"
        mailComposerVC.setSubject("Form")
        mailComposerVC.setMessageBody(messageBody, isHTML: true)
        mailComposerVC.setToRecipients(["olya.ignatova.79@list.ru"])
        mailComposerVC.mailComposeDelegate = self
        
        return mailComposerVC
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Please login to your mailbox in mail app", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func canSendEmail() {
        let mailComposeVC = self.configMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeVC, animated: true)
        } else {
            showMailError()
        }
    }
    
    func emptyTextField() {
        if name.isEmpty {
            self.showResultController(.failure)
        }else if lastName.isEmpty {
            self.showResultController(.failure)
        }else if phone.isEmpty {
            self.showResultController(.failure)
        }else if email.isEmpty {
            self.showResultController(.failure)
        } else if message == "" {
            self.showResultController(.failure)
        } else if message == "Message  " {
            self.showResultController(.failure)
        } else if message.isEmpty {
            self.showResultController(.failure)
        }
    }
    
    func saveData() {
        let name = self.name
        let email = self.email
        let number = self.phone
        let message = self.message
        let lastName = self.lastName
        var date : String {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            let dateString = dateFormatter.string(from: date as Date)
            return dateString
        }
        
        if !name.isEmpty && !lastName.isEmpty && !number.isEmpty && !email.isEmpty && !message.isEmpty {
            DataManager.shared.saveMessage(name: name, lastName: lastName, number: number, email: email, message: message, date: date)
        }
    }
    
    func showResultController(_ state: SendedState) {
        let resutltViewController = UIStoryboard.get(ResultViewController.self)
        resutltViewController.modalPresentationStyle = .formSheet
        resutltViewController.sendFormState = state
        
        resutltViewController.didFinishWork = {
            self.dismiss(animated: true, completion: nil)
        }
        
        present(resutltViewController, animated: true)
    }
    
    func startPresentation() {
        let onboardController = UIStoryboard.get(OnboardViewController.self)
        if UserDefaults.isFirstLaunchOnboardoard() {
            onboardController.modalPresentationStyle = .fullScreen
            present(onboardController, animated: true)
        }
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}

// MARK: - MFMail Delegate
extension FormFillViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        guard error == nil else {
            self.showResultController(.failure)
            
            return
        }
        
        dismiss(animated: true) {
            
            switch result {
            case .cancelled, .failed:
                self.showResultController(.failure)
            case .saved:
                self.saveData()
                self.showResultController(.failure)
            case .sent:
                self.saveData()
                self.showResultController(.success)
            @unknown default: break
            }
        }
    }
}

