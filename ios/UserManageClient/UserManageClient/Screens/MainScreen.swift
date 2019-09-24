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
import SwiftyJSON


class MainScreen: UIViewController {
    var tableView =  UITableView(frame: CGRect.zero)
    var json: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "User Management"
        view.sv (
            tableView
        )
        view.layout(
            |-tableView-|,
            0
        )
        tableView.Top == view.safeAreaLayoutGuide.Top
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDataReloadTableView()
    }
    
    func getDataReloadTableView() {
        let queue = DispatchQueue(label: "vn.techmaster.api", qos: .background, attributes: .concurrent)
        let base_url = Server.shared.baseURL()
        Alamofire.request(base_url + "users").responseJSON(queue: queue) { response in
            switch response.result {
            case .success(let value):
                self.json = JSON(value)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MainScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.json == nil) {
            print("but json is nil")
            return 0
        } else {
            return self.json!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        if (cell == nil) {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        let record: JSON =  self.json![indexPath.row]
       
        cell?.textLabel?.text = record["name"].stringValue
        cell?.detailTextLabel?.text = record["email"].stringValue
        return cell!
    }
    
    
}

extension MainScreen: UITableViewDelegate {
    
}
