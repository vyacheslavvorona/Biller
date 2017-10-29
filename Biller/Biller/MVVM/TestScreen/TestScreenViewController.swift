//
//  TestScreenViewController.swift
//  Biller
//
//  Created by Vorona Vyacheslav on 10/26/17.
//  Copyright © 2017 Vorona Vyacheslav. All rights reserved.
//

import Foundation
import Result
import RealmSwift

public protocol TestScreenViewModelProtocol {
    
}

public class TestScreenViewController: UIViewController {
    private lazy var viewModel: TestScreenViewModelProtocol = TestScreenViewModel()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        start()
    }
    
    private func start() {
        let bill = BillModel(name: "TestBill333")
        do {
            let realm = Realm.getRealm()
            try realm.write {
                let bill2 = try BillModel.create(realm: Realm.getRealm(), value: bill, update: true)
                label.text = bill2.id
            }
        } catch {
            print("oops, Skolvan... something went wrong")
        }
    }
    
    @IBAction func buttonTap(_ sender: Any) {
        
    }
    
}
