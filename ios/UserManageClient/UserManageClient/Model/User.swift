//
//  User.swift
//  UserManageClient
//
//  Created by Techmaster on 9/26/19.
//  Copyright © 2019 Techmaster. All rights reserved.
//

import Foundation
import SwiftyJSON
class User {
    var id: Int
    var name: String
    var email: String
    var pass: String
    //var photo: UIImage
    init(record: JSON) {
        id = record["id"].intValue
        name = record["name"].stringValue
        email = record["email"].stringValue
        pass = record["password"].stringValue
    }
}
