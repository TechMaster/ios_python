//
//  EditScreen.swift
//  UserManageClient
//
//  Created by Techmaster on 9/24/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import UIKit
import Eureka
class EditScreen: FormViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Edit User"
        form +++ TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter text here"
            }
            <<< EmailRow(){ row in
                row.title = "Email"
                row.placeholder = "And email here"
            }
            <<< PasswordRow() {row in
                row.title = "Pass"
                row.placeholder = "Password here"
            }
        
    }
}
    



