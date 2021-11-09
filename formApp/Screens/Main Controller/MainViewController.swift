//
//  FormHistoryViewController.swift
//  formApp
//
//  Created by MacBook Pro on 31.03.2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyTitleLabel: UILabel!
    @IBOutlet weak var emptyImageLabel: UIImageView!
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        notification()
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emptyFormData()
        
        if UserDefaults.isFirstLaunch() {
            self.showFillController()
        }
    }
    
    
    
    // MARK: - Notification
    func notification() {
    let manager = LocalNotificationManager()
        manager.notifications = [Notifications(id: "reminder-1", title: "It’s time for a new form", message: "We are still waiting for you to send us this weeks form with your details", dateTime: DateComponents(calendar: Calendar.current, hour: 10, minute: 10))
        ]
        manager.schedule()
    }
    
    // MARK: - IBActions
    @IBAction func showNewFormController(_ sender: UIBarButtonItem) {
        showFillController()
    }
}

// MARK: - TableViewDelegate, TableViewDataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.addMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FormHistoryViewCell

        let item = DataManager.shared.addMessage[indexPath.row]
        cell.dateLabel.text = item.date
        cell.titleCell?.text = item.cellShow
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        goToDetailFormController(indexPath)
       // configureNotificationForModel(by: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Setup
private extension MainViewController {
    func setup() {
        tableViewConfigure()
        navigationItem.title = "Form history"
        emptyTitleLabel.font = UIFont(name: "IBMPlexSans-SemiBold", size: 14)
        emptyTitleLabel.text = "Nothing here \nyet"
    }
    
    func emptyFormData() {
        if DataManager.shared.addMessage.isEmpty {
            //DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.showFillController()
           // }
            self.tableView.isHidden = true
            self.emptyTitleLabel.isHidden = false
            self.emptyImageLabel.isHidden = false
            self.tableView.reloadData()
        } else {
            self.tableView.isHidden = false
            self.emptyTitleLabel.isHidden = true
            self.emptyImageLabel.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    func tableViewConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func showFillController() {
        let formFillController = UIStoryboard.get(FormFillViewController.self)
        let navigationController = UINavigationController(rootViewController: formFillController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    func goToDetailFormController(_ indexPath: IndexPath) {
        let selectedItem = DataManager.shared.addMessage[indexPath.row]
        let detailFormViewController = UIStoryboard.get(DetailFormViewController.self)
        
        detailFormViewController.nameLastName = selectedItem.cellShow
        detailFormViewController.phone = selectedItem.number
        detailFormViewController.email = selectedItem.email
        detailFormViewController.message = selectedItem.message
        
        navigationController?.pushViewController(detailFormViewController, animated: true)
    }
}

