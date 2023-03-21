//
//  secondViewController.swift
//  MvvMwithStoryboard
//
//  Created by Hilal Öztemel on 21.03.2023.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var konum: UILabel!
    @IBOutlet weak var weatherDegree: UILabel!
    
    var apiKeyData = "-"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Weather App"
        konum.text = apiKeyData
    }


}
