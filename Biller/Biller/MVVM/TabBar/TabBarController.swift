//
//  TabBarController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/26/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import UIKit

public class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let testStoryBoard = UIStoryboard(name: "TestScreen", bundle: nil)
        let testViewController = testStoryBoard.instantiateViewController(withIdentifier: "TestScreen")
        let testTabBarItem = UITabBarItem(title: "TestItem", image: UIImage(named: "first"), selectedImage: UIImage(named: "first"))
        testViewController.tabBarItem = testTabBarItem
        
        let navigationBarStoryBoard = UIStoryboard(name: "NavigationBar", bundle: nil)
        let historyNavigationController = navigationBarStoryBoard.instantiateViewController(withIdentifier: "NavigationBar") as? UINavigationController
        let historyStoryBoard = UIStoryboard(name: "History", bundle: nil)
        let historyViewController = historyStoryBoard.instantiateViewController(withIdentifier: "History")
        historyNavigationController?.setViewControllers([historyViewController], animated: false)
        let historyTabBarItem = UITabBarItem(title: "History", image: UIImage(named: "second"), selectedImage: UIImage(named: "second"))
        historyViewController.tabBarItem = historyTabBarItem
        
        self.viewControllers = [testViewController, historyViewController]
    }
}
