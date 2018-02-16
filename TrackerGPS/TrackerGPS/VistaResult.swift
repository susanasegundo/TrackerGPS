//
//  VistaResult.swift
//  TrackerGPS
//
//  Created by  on 8/2/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class VistaResult: UIViewController, MKMapViewDelegate {
    
    var recorrido: Recorrido = Recorrido()
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {	
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addAnotations()
        subirAFirebase()
    }

    
    
    
    //subir a firebase
    func subirAFirebase() {
        
        //recorrido a subir
        var ref: DocumentReference? = nil
        ref = db.collection("recorridos").addDocument(data: [
            "fechaInicio": recorrido.fechaInicio,
            "fechaFin": recorrido.fechaFin,
            "tiempoT": recorrido.tiempoT,
            "id": recorrido.id,
            "tipo": recorrido.tipo,
            "localizaciones": recorrido.localizaciones
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addAnotations(){
        
        /*mapView?.delegate = self
        mapView?.addAnnotations(places)
        
        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
        mapView?.addOverlays(overlays)
         
        var locations = places.map { $0.coordinate }*/
        mapView?.delegate = self
        
        //transformacion de [GeoPoint] a CLLocation
        var cambio: [CLLocationCoordinate2D] = [CLLocationCoordinate2D]()
        for location in recorrido.localizaciones {
            let lc: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
          cambio.append(lc)
            
        }
        // a dibujar
        /*let coords1 = CLLocationCoordinate2D(latitude: 40.4167018, longitude:-3.7037788)
        let coords2 = CLLocationCoordinate2D(latitude: 42.3499677, longitude:-3.6822051)
        let coords3 = CLLocationCoordinate2D(latitude: 42.8587995, longitude:-2.6824780)
        let testcoords:[CLLocationCoordinate2D] = [coords1,coords2,coords3]*/
        
        //let polyline = MKPolyline(coordinates: testcoords, count: testcoords.count)
        let polyline = MKPolyline(coordinates: cambio, count: cambio.count)
        mapView?.add(polyline)
        mapView?.delegate = self
        //mapView.centerCoordinate = coords2
    
        mapView(mapView, rendererFor: polyline)
        
    }
    
    /*func procesar ( _ persona:String ) {
     print(persona)
     }*/
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //Return an `MKPolylineRenderer` for the `MKPolyline` in the `MKMapViewDelegate`s method
        if let polyline = overlay as? MKPolyline {
            let testlineRenderer = MKPolylineRenderer(polyline: polyline)
            testlineRenderer.strokeColor = .blue
            testlineRenderer.lineWidth = 2.0
            return testlineRenderer
        }
        fatalError("Something wrong...")
        //return MKOverlayRenderer()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "aDetalles"){
            let destino = segue.destination as! VistaDetalles
            
            //pasar al destino el recorrido
            destino.recorrido = self.recorrido
                        
            
        }else{}
    }
    

}
