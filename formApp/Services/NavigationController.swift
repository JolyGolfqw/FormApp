//
//  NavigationController.swift
//  Form
//
//  Created by MacBook Pro on 22.04.2021.
//

import UIKit

class NavigationController: UINavigationController
{
    // MARK: Navigation Controller Life Cycle

    override func viewDidLoad()
    {
       super.viewDidLoad()
       setFont()
    }

    // MARK: Methods

    func setFont()
    {
       // set font for title
       self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "IBMPlexSans-Bold", size: 20)!]
    
//       // set font for navigation bar buttons
//       UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Al-Jazeera-Arabic", size: 15)!], for: UIControl.State.normal)
    }
}
