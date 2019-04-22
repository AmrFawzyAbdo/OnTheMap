//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by Amr on 173//19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation

struct StudentLocation: Codable {
    let results: [LocationModel]?
}

struct LocationModel : Codable {
    let objectId : String?
    let mediaURL : String?
    let firstName : String?
    let lastName : String?
    let longitude : Double?
    let latitude : Double?
}
