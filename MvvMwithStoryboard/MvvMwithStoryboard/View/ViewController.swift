//
//  ViewController.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 21.03.2023.
//

import UIKit
//Location : CoreLocation

import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var apiKey: UITextField!
    
    var apiKeyData = "-"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestuRecognizer = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard) )
        view.addGestureRecognizer(gestuRecognizer)
    }
    @objc func closeKeyboard(){
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        apiKey.text = ""
    }
    
    func createAlert(title: String ,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enterApiButton(_ sender: Any) {
        if let apiKeyText = apiKey.text, !apiKeyText.isEmpty {
            // apiKeyText is not empty, continue with API call
            apiKeyData = apiKey.text!
            performSegue(withIdentifier: "firstSegue", sender: nil)
            
        } else {
            // apiKeyText is empty, display an alert message
            createAlert(title: "Error" ,message: "API key cannot be empty.")
        }
        
        
    }
    
    //Segue'ye veri göndermek
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue"{
            let destinationVC = segue.destination as! WeatherViewController
            destinationVC.apiKeyData = apiKeyData
        }
    }
    
}

