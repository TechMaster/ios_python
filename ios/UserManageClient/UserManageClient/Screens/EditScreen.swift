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
        editMode = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(onSave))
        
        form +++ TextRow(){ row in
                row.tag = "Name"
                row.title = "Name"
                row.placeholder = "Enter text here"
            }
            <<< EmailRow(){ row in
                row.tag = "Email"
                row.title = "Email"
                row.placeholder = "And email here"
            }
            <<< PasswordRow() {row in
                row.tag = "Pass"
                row.title = "Pass"
                row.placeholder = "Password here"
            }
            <<< ImageRow() {
                $0.tag = "Photo"
                $0.title = "Photo"
                $0.sourceTypes = [.PhotoLibrary, .SavedPhotosAlbum]
                $0.clearAction = .yes(style: .default)
            }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if user != nil {
            navigationItem.title = "Edit User"
            form.rowBy(tag: "Name")?.value = user.name
            form.rowBy(tag: "Email")?.value = user.email
            form.rowBy(tag: "Pass")?.value = user.pass
        } else {
            navigationItem.title = "Add User"
        }
        
    }
    
    
    // Đoạn này sẽ lưu dữ liệu lên server
    @objc func onSave() {
        let valuesDictionary = form.values()
        print(valuesDictionary)
       
    }
}
    



