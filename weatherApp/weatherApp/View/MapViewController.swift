//
//  MapViewController.swift
//  weatherApp
//
//  Created by Hilal Öztemel on 6.04.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController ,MKMapViewDelegate, CLLocationManagerDelegate{

    let locationManager = CLLocationManager()
    var secilenLatitude = Double()
    var secilenLongitude = Double()
    
    var latValue = 0.0
    var lonValue = 0.0
    var apiKeyData = "8ddadecc7ae4f56fee73b2b405a63659"
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(locationSelect(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
        
    }
    
    @objc func locationSelect(gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began{
            let dokunulanNokta = gestureRecognizer.location(in: mapView)
            let dokunulanKoordinat = mapView.convert(dokunulanNokta,toCoordinateFrom: mapView)
            
            secilenLatitude = dokunulanKoordinat.latitude
            secilenLongitude = dokunulanKoordinat.longitude
            
            print("secilenLatitude : ",secilenLatitude ,"secilenLongitude :", secilenLongitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = dokunulanKoordinat
            mapView.addAnnotation(annotation)
            
            if !secilenLatitude.isNaN , !secilenLongitude.isNaN {
                // apiKeyText is not empty, continue with API call
                
                latValue = secilenLatitude
                lonValue = secilenLongitude
                print("maplon : ",lonValue)
                print("maplat : ",latValue)
                performSegue(withIdentifier: "toWeatherVC", sender: nil)
                
            } else {
                // apiKeyText is empty, display an alert message
                createAlert(title: "Error" ,message: "Could not open weather forecast the selected location")
            }
        }
    }
    //Segue'ye veri göndermek
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherVC"{
            let destinationVC = segue.destination as! WeatherViewController
            destinationVC.apiKeyData = apiKeyData
            destinationVC.lonValue = lonValue
            destinationVC.latValue = latValue
        }
    }
    
  
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 5)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func createAlert(title: String ,message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


}
