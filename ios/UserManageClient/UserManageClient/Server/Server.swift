//
//  Server.swift
//  UserManageClient
//
//  Created by Techmaster on 9/24/19.
//  Copyright © 2019 Techmaster. All rights reserved.
// Xem cách khởi tạo Singleton ở đây
// https://medium.com/@nimjea/singleton-class-in-swift-17eef2d01d88

import Foundation
class Server {
    static let shared = Server()
    func baseURL()->String {
        return "http://0.0.0.0:8000/"
    }
}
