//
//  MainScreen.swift
//  UserManageClient
//
//  Created by Techmaster on 9/24/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit
import Stevia
import Alamofire

class MainScreen: UIViewController {
    var tableView =  UITableView(frame: CGRect.zero)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        view.sv (
            tableView
        )
        view.layout(
            |-tableView-|,
            0
        )
        tableView.Top == view.safeAreaLayoutGuide.Top
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "User Management"
    }
    



}
