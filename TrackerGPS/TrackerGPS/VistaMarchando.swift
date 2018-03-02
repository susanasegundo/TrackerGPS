//
//  VistaMarchando.swift
//  TrackerGPS
//
//  Created by iñaki on 26/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class VistaMarchando: UIViewController, CLLocationManagerDelegate {
    //variable recorrido
    var recorrido: Recorrido = Recorrido()
    //donde se guardan las localizaciones
    var localizacionesArray: [GeoPoint] = [GeoPoint]()//init por defecto, se sobreescribe en el segue.
    
    //tema timer contador => https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f
    var contador = 0.0
    var tiempo = Timer()
    var intervalo = Timer()
    
    //para localizacion
    var locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //notificar al usuario de que se usara el gps.
        locationManager.requestWhenInUseAuthorization()
        estadoLabel.text = "En espera"
        estadoBotonPausa = 2
        stopNombre.isEnabled = false
        
        //iniciar la obtencion de localizacion
        if CLLocationManager.locationServicesEnabled()  {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("Acceso no permitido, restringido o denegado")
                estadoLabel.text = "Detección de ubicación restringido"
            case .authorizedWhenInUse, .authorizedAlways:
                print("Acceso permitido")
                //como se ha autorizado arrancar el resto de la pantalla y sus servicios
                locationManager.delegate = self
                //locationManager.requestWhenInUseAuthorization()
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
                
                //inicio de sistemas
                estadoBotonPausa = 1
                estadoLabel.text = "Estado: En funcionamiento"
                stopNombre.isEnabled = true
                //timers de la cuenta del tiempo y obtencion de coordenada cada x segundos
                runTimer()
                runTimer2()
            }
        }else{
            print("Location services is not running...")
        }
        
        
       
        

        
    }
    
    //cada vez que se refresca las coordenadas
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func runTimer2() {
        //es necesario tener minimo 1 localizacion para que no cause error
        currentLocationGuardar()
        //tiempo de guardado de loc para cada tipo
        switch recorrido.tipo {
        case "Andar":
            intervalo = Timer.scheduledTimer(timeInterval: 9.0, target: self, selector: (#selector(VistaMarchando.currentLocationGuardar)), userInfo: nil, repeats: true)
            case "Correr":
            intervalo = Timer.scheduledTimer(timeInterval: 7.0, target: self, selector: (#selector(VistaMarchando.currentLocationGuardar)), userInfo: nil, repeats: true)
            case "Bicicleta":
            intervalo = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: (#selector(VistaMarchando.currentLocationGuardar)), userInfo: nil, repeats: true)
            case "Coche", "Moto":
            intervalo = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: (#selector(VistaMarchando.currentLocationGuardar)), userInfo: nil, repeats: true)
            
        default:
            intervalo = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: (#selector(VistaMarchando.currentLocationGuardar)), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func currentLocationGuardar() {
        //a veces saca nil
        if locationManager.location?.coordinate != nil {
            print("Guadando loc => \(locationManager.location!.coordinate)")
            localizacionesArray.append(GeoPoint(latitude: locationManager.location!.coordinate.latitude, longitude: locationManager.location!.coordinate.longitude))
        }
        
    }
  
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("didFailWithError => \(error)")
    }
    
    //funcion para bucle contador, sume mas 1
    func runTimer() {
        tiempo = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(VistaMarchando.contadorSuma)), userInfo: nil, repeats: true)
    }
    //el contador en si mismo, cambiando el tiempoLabel
    @objc func contadorSuma() {
        contador += 1
        tiempoLabel.text = pasarBonitoElTiempo(time: TimeInterval(contador))
    }
    //dejarlo bonito
    func pasarBonitoElTiempo(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    @IBOutlet weak var tiempoLabel: UILabel!
    
    
    //cuando se pulse cambie de estado el propio boton .
    @IBOutlet weak var pausaNombre: UIButton!
    @IBOutlet weak var reanudarNombre: UIButton!
    @IBOutlet weak var stopNombre: UIButton!
    
    // 0 no funciona, 1 funciona
    var estadoBotonPausa: Int = 0
    var t: TimeInterval = 0
    
    @IBAction func reanudarBoton(_ sender: Any) {
        if estadoBotonPausa == 0 {
            runTimer()
            runTimer2()
            //cambiar imagen boton reanudar
            reanudarNombre.setBackgroundImage(#imageLiteral(resourceName: "botonPlayAzul"), for: UIControlState.normal)
            self.locationManager.startUpdatingLocation()
            pausaNombre.setBackgroundImage(#imageLiteral(resourceName: "botonPausaVerde"), for: UIControlState.normal)
            estadoBotonPausa = 1
            estadoLabel.text = "Estado: En funcionamiento"
        }
    }
    @IBAction func pausarBoton(_ sender: Any) {
        if estadoBotonPausa == 1 {
            tiempo.invalidate()
            intervalo.invalidate()
            self.locationManager.stopUpdatingLocation()
            reanudarNombre.setBackgroundImage(#imageLiteral(resourceName: "botonPlayVerde"), for: UIControlState.normal)
            pausaNombre.setBackgroundImage(#imageLiteral(resourceName: "botonPausa"), for: UIControlState.normal)
            estadoBotonPausa = 0
            estadoLabel.text = "Estado: Pausado..."
            
        }
    }    
    
    //Boton STOP
    @IBAction func stopBoton(_ sender: Any) {
        //Se va a mostrar un mensaje de alerta
        tiempo.invalidate()
        intervalo.invalidate()
        var vControl = 0
       
        //parar la actualizacion de localizacion
        self.locationManager.stopUpdatingLocation()
        
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default){
            (action) in
            //que ocurre            
            vControl = 1
            print("aceptar")
            if vControl == 1 {
                print("Prepare segue")
                //que se ejecute el segue y se guarde la localizacion mas actual en el tiempo, para ser lo mas preciso posible
                self.currentLocationGuardar()
                self.intervalo.invalidate() //terminar con el bucle de Timer
                //la fecha de que acaba.
                self.recorrido.fechaFin = Date.init()
                self.performSegue(withIdentifier: "aMapa", sender: self)                
            }
        }     
      
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel){
            (action) in
            //respond to user selection of the action
            self.runTimer()
            self.runTimer2()
            print("cancelar")
            //reanudar localizacion
            self.locationManager.startUpdatingLocation()
        }
        
        //crear y configurar el controlador de alerta
        let alert = UIAlertController(title: "¿Está usted seguro de querer acabar el recorrido?", message: """
        Aceptar para finalizar y ver el Mapa.
        Cancelar para seguir con el recorrido.
        """
            ,  preferredStyle: .alert )
        alert.addAction(defaultAction)
        alert.addAction(cancelAction)
        
        //para que salga el mensaje o se "presente" en pantalla
        self.present(alert,animated: true)   
    }   
    
    @IBOutlet weak var estadoLabel: UILabel!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if( segue.identifier == "aMapa"){
            let destino = segue.destination as! VistaMapa
            
            //tenemos el array de localizaciones
            recorrido.localizaciones = localizacionesArray
            //el tiempo que ha tardado, por ahora lo cojo del tiempo.
            recorrido.tiempoT = contador //pasa solo los segundos, es por el tema del historial y como se guarda el tiempo. La conversion se hace en detalles.
            
            //pasar al destino el recorrido
            destino.recorrido = self.recorrido
            
            destino.ventana = "Marchando"
            
            
        }else{
        }  
    }
  
}
