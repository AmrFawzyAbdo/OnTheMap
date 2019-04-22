//
//  LocationManager.swift
//  OnTheMap
//
//  Created by Amr on 173//19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import MapKit

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}
    
    func getLocations (completion: @escaping ([MKPointAnnotation]?, Error?) -> Void){
        var annotations : [MKPointAnnotation] = []
        let apiService = DataProviderService()
        apiService.getStudentLocations { locationList, error  in
            if error != nil {
                completion(nil, error)
            } else {
                for location in locationList ?? [] {
                    let lat = CLLocationDegrees(location.latitude ?? 0.00)
                    let lon = CLLocationDegrees(location.longitude ?? 0.00)
                    let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                    let first = location.firstName
                    let last = location.lastName
                    let url = location.mediaURL
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    annotation.title = "\(String(describing: first ?? "")) \(String(describing: last ?? ""))"
                    annotation.subtitle = url
                    annotations.append(annotation)
                }
                completion(annotations, nil)
            }
        }
    }
    
}
