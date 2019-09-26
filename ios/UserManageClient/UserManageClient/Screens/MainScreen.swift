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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(AddNew))
        
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
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
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
                    self.tableView.refreshControl?.endRefreshing()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func AddNew() {
        self.navigationController?.pushViewController(EditScreen(), animated: true)
    }
    
    @objc func onRefresh() {
        getDataReloadTableView()
    }
}

//---------------------------------------------------------
extension MainScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.json == nil) {
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
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = record["name"].stringValue
        cell?.detailTextLabel?.text = record["email"].stringValue
        return cell!
    }
    
    
}

extension MainScreen: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        //Lấy JSON record ở dòng được chọn
        let record: JSON =  self.json![indexPath.row]
        //Chuyển nó thành đối tượng user
        let user = User(record: record)
        //Truyền sang màn hình EditScreen
        self.navigationController?.pushViewController(EditScreen(user: user), animated: true)
    }
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {          
            let queue = DispatchQueue(label: "vn.techmaster.api", qos: .background, attributes: .concurrent)
            
            let base_url = Server.shared.baseURL()
            
            let record: JSON =  self.json![indexPath.row]
            let id = record["id"].intValue
            let parameters: Parameters = [
                "id": id
            ]

            Alamofire.request(base_url + "user",
                              method:.delete,
                              parameters: parameters,
                              encoding: URLEncoding.httpBody).responseJSON(queue: queue) { response in
                switch response.result {
                case .success(let value):
                    let bvalue = value as! Bool
                    if (bvalue==true) {
                        self.json!.arrayObject?.remove(at: indexPath.row)
                        DispatchQueue.main.async {
                            self.tableView.deleteRows(at: [indexPath], with: .fade)
                        }
                    }
                case .failure(let error):
                    print(error)
                }
            }            
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}
