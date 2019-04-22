//
//  StudentListViewController.swift
//  OnTheMap
//
//  Created by Amr on 173//19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

class StudentListViewController: UIViewController {
    
    var studentLocations: [LocationModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let apiService = DataProviderService()
        apiService.getStudentLocations {[weak self] locationsList, error  in
            DispatchQueue.main.async {
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "\(error?.localizedDescription)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self?.present(alert, animated: true, completion: nil)
                } else  {
                    self?.studentLocations = locationsList ?? []
                    self?.tableView.reloadData()
                }
            }
            
        }
    }
    
    @IBAction func logout(_ sender: Any) {
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
    
    func alertMessage(title: String , error: String){
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
    
}



extension StudentListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let studentLocation = studentLocations[indexPath.row]
        cell.textLabel?.text = (studentLocation.firstName ?? "") + " " + (studentLocation.lastName ?? "")
        cell.detailTextLabel?.text = studentLocation.mediaURL ?? ""
        return cell
    }
    
}
extension StudentListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let location = studentLocations[indexPath.row].mediaURL
        if(location?.contains("http"))! {
            let viewController = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            viewController.urlString = location
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            alertMessage(title: "Error", error: "This is not a valid URL , try another one!")
        }
        
    }
}

