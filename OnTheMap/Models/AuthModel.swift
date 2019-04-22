//
//  AuthModel.swift
//  OnTheMap
//
//  Created by Ninja on 3/24/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation


struct AuthModel: Codable {
    let session: Session?
    let account: Account?
}

struct Session: Codable {
    let expiration: String?
    let id: String?
}

struct Account: Codable {
    let key: String?
    let registered: Bool?
}


