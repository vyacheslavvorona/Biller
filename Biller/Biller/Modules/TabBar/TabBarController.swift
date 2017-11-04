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

        let navigationBarStoryBoard = UIStoryboard(name: "NavigationBar", bundle: nil)
        
        let historyNavigationController = navigationBarStoryBoard.instantiateViewController(withIdentifier: "NavigationBar") as? UINavigationController
        let historyStoryBoard = UIStoryboard(name: "History", bundle: nil)
        let historyViewController = historyStoryBoard.instantiateViewController(withIdentifier: "History")
        historyNavigationController?.setViewControllers([historyViewController], animated: false)
        let historyTabBarItem = UITabBarItem(title: "History", image: UIImage(named: "second"), selectedImage: UIImage(named: "second"))
        historyNavigationController?.tabBarItem = historyTabBarItem
        
        let placesNavigationController = navigationBarStoryBoard.instantiateViewController(withIdentifier: "NavigationBar") as? UINavigationController
        let placesStoryBoard = UIStoryboard(name: "Places", bundle: nil)
        let placesViewController = placesStoryBoard.instantiateViewController(withIdentifier: "Places")
        placesNavigationController?.setViewControllers([placesViewController], animated: false)
        let placesTabBarItem = UITabBarItem(title: "Places", image: UIImage(named: "second"), selectedImage: UIImage(named: "second"))
        placesNavigationController?.tabBarItem = placesTabBarItem
        
        let friendsNavigationController = navigationBarStoryBoard.instantiateViewController(withIdentifier: "NavigationBar") as? UINavigationController
        let friendsStoryBoard = UIStoryboard(name: "Friends", bundle: nil)
        let friendsViewController = friendsStoryBoard.instantiateViewController(withIdentifier: "Friends")
        friendsNavigationController?.setViewControllers([friendsViewController], animated: false)
        let friendsTabBarItem = UITabBarItem(title: "Friends", image: UIImage(named: "second"), selectedImage: UIImage(named: "second"))
        friendsNavigationController?.tabBarItem = friendsTabBarItem
        
        if let history = historyNavigationController,
           let places = placesNavigationController,
           let friends = friendsNavigationController {
            self.viewControllers = [history, places, friends]
        }
    }
}
