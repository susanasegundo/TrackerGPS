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
        mapa.delegate = self
        comenzar(self)
        print (locationManager.location?.altitude)
        
        
        
       /* var latitude:CLLocationDegrees = 42.868715
        var longitude:CLLocationDegrees = -2.676934
        
        //campo de vision
        var latDelta:CLLocationDegrees = 0.001
        var longDelta:CLLocationDegrees = 0.001
        
        //Lo grande que sera el cuadrado que mostrare
        var span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        //Donde empezara el mapa
        var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapa.setRegion(region, animated: true)*/
        
        
        
        
    }
    
     func comenzar(_ sender: Any) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        

    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let ultimaUbicacion:CLLocation = locations[locations.count - 1]
        
        print ( String(format:"%.4f",ultimaUbicacion.coordinate.latitude))
        
        print (  String(format:"%.4f",ultimaUbicacion.coordinate.longitude))
        
        print ( String(format:"%.4f",ultimaUbicacion.altitude))
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
