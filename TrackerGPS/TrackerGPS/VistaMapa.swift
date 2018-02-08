//
//  VistaMapa.swift
//  TrackerGPS
//
//  Created by iñaki on 23/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import CoreLocation

class VistaMapa: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
      
        //print(let fecha = Date.init())
    }
    
   func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations[0]
    
    let center = location.coordinate
    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    let region = MKCoordinateRegion(center: center, span: span)
    
    mapa.setRegion(region, animated: true)
    mapa.showsUserLocation = true
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    @IBOutlet weak var mapa: MKMapView!
    var locationManager:CLLocationManager = CLLocationManager()
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

