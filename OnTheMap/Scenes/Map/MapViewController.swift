//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Amr on 173//19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var annotations: [MKPointAnnotation] = []
    //MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NetworkManager.shared.getLocations { pointAnnotationList, error  in
            
            DispatchQueue.main.async {
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "\(error?.localizedDescription ?? "")", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if let pointAnnotationList = pointAnnotationList {
                        self.annotations = pointAnnotationList
                        self.mapView.addAnnotations(self.annotations)
                        self.mapView.reloadInputViews()
                    }
                }
                    
                
            }
        }
    }
    
    //MARK:- Actions
    @IBAction func logout(_ sender: UIButton) {
        let apiService = DataProviderService()
        apiService.logout { (isSuccess) in
            if isSuccess {
                if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
                    self.present(loginViewController, animated: true)
                }
            } else {
                let alert = UIAlertController(title: "Error", message: "Something Goes Wrong", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func postLocation(_ sender: UIButton) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "nv") as! UINavigationController
        self.present(viewController, animated: true, completion: nil)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    // MARK: - MKMapViewDelegate Methods
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let locationURLString = view.annotation?.subtitle!
            if(locationURLString?.contains("http"))! {
            let viewController = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            viewController.urlString = locationURLString
            self.navigationController?.pushViewController(viewController, animated: true)
            }else{
                alertMessage(title: "Error", error: "This is not a valid URL , try another one!")
            }
            
        }
    }
    
    func alertMessage(title: String , error: String){
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
}
