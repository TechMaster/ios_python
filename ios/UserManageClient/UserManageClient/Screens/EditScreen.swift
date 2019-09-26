//
//  EditScreen.swift
//  UserManageClient
//
//  Created by Techmaster on 9/24/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit
import Eureka
import ImageRow
import Alamofire
import SwiftMessages

class EditScreen: FormViewController  {
    var user: User!
    var editMode: Bool!  //True if edit existing record, False if add new record
    
    // Constructor trong trường hợp có user truyền vào, nếu là Add New thì không dùng
    init(user: User) {
        super.init(style: UITableView.Style.grouped)
        self.user = user
        editMode = true
    }
    
    init() {
        super.init(style: UITableView.Style.grouped)
        editMode = false  // Add Mode
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onSave))
        
        form +++ TextRow(){ row in
            row.tag = "name"
            row.title = "Name"
            row.placeholder = "Enter text here"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnDemand
            row.cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            }
            <<< EmailRow(){ row in
                row.tag = "email"
                row.title = "Email"
                row.placeholder = "And email here"
                row.add(rule: RuleRequired())
                row.add(rule: RuleEmail())
                row.validationOptions = .validatesOnDemand
                row.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
            <<< PasswordRow() {row in
                row.tag = "password"
                row.title = "Password"
                row.placeholder = "Password here"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnDemand
                row.cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
            <<< ImageRow() {
                $0.tag = "photo"
                $0.title = "Photo"
                $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
                $0.clearAction = .yes(style: .default)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if user != nil {
            navigationItem.title = "Edit User"
            form.rowBy(tag: "name")?.value = user.name
            form.rowBy(tag: "email")?.value = user.email
            form.rowBy(tag: "password")?.value = user.pass
        } else {
            navigationItem.title = "Add User"
        }
        
    }
    
    
    // Đoạn này sẽ lưu dữ liệu lên server
    @objc func onSave() {
        form.validate()
        
        for row in form.rows {
            if row.validationErrors.count > 0 {
                row.updateCell()
                SwiftMessageExtra.showWarnMessage(theme: .warning, title: "Lỗi", body: "Hãy nhập đủ dữ liệu")
                return
            }
        }
        let queue = DispatchQueue(label: "vn.techmaster.api", qos: .background, attributes: .concurrent)
        let base_url = Server.shared.baseURL()
        
        
        let valuesDictionary = form.values()
        
        if editMode {
            let parameters: Parameters = [
                "id": user.id,
                "name": valuesDictionary["name"]! ?? "",
                "email": valuesDictionary["email"]! ?? "",
                "password": valuesDictionary["password"]! ?? ""
            ]
            Alamofire.request(base_url + "user",
                              method:.put,
                              parameters: parameters,
                              encoding: URLEncoding.httpBody).responseJSON(queue: queue) { response in
                                switch response.result {
                                case .success(let value):
                                    let bvalue = value as! Bool
                                    if bvalue {
                                        DispatchQueue.main.async {                                             self.navigationController?.popViewController(animated: true)
                                        }
                                       
                                    }
                                case .failure(let error):
                                    print(error)
                                    // Bắn lỗi ở đây
                                }
            }
            
        } else {
            let parameters: Parameters = [
                "name": valuesDictionary["name"]! ?? "",
                "email": valuesDictionary["email"]! ?? "",
                "password": valuesDictionary["password"]! ?? ""
            ]
            Alamofire.request(base_url + "user",
                              method:.post,
                              parameters: parameters,
                              encoding: URLEncoding.httpBody).responseJSON(queue: queue) { response in
                                switch response.result {
                                case .success(let value):
                                    let new_id = value as! Int
                                    print(new_id)
                                    DispatchQueue.main.async {                                             self.navigationController?.popViewController(animated: true)
                                    }
                                    
                                case .failure(let error):
                                    print(error)
                                }
            }
        }
        
    }
}




