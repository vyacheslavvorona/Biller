//
//  HistoryViewController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/29/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public protocol HistoryViewModelProtocol {
    var viewController: HistoryViewControllerProtocol? { get set }
}

public class HistoryViewController: UIViewController, HistoryViewControllerProtocol {
    private var viewModel: HistoryViewModelProtocol = HistoryViewModel() {
        didSet {
            viewModel.viewController = self
        }
    }
    public var billDisplayItems: [BillDisplayItem] = []
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "BillCell", bundle: nil), forCellReuseIdentifier: "BillCell")
            tableView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
            tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension HistoryViewController: UITableViewDelegate {
    
}

extension HistoryViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billDisplayItems.count + 1
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row >= billDisplayItems.count {
            return 70
        } else if indexPath.row < billDisplayItems.count {
            return 160
        } else {
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= billDisplayItems.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell") as? AddCell else {
                return UITableViewCell()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BillCell") as? BillCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}
