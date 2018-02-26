//
//  VistaDetalles.swift
//  TrackerGPS
//
//  Created by  on 8/2/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit
import Eureka
import MapKit

class VistaDetalles: FormViewController {

    var recorrido: Recorrido = Recorrido()
    var distanciaTotal = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //formato fecha inicio
        let fechaInicio = recorrido.fechaInicio
        let dateFormatterInicio = DateFormatter()
        dateFormatterInicio.dateFormat = "dd-MM-yyyy"
        let fechaInicioString = dateFormatterInicio.string(from: fechaInicio)
        dateFormatterInicio.dateFormat = "HH:mm:ss"
        let horaInicioString = dateFormatterInicio.string(from: fechaInicio)
        
        //formato fecha fin
        let fechaFin = recorrido.fechaFin
        let dateFormatterFin = DateFormatter()
        dateFormatterFin.dateFormat = "dd-MM-yyyy"
        let fechaFinString = dateFormatterFin.string(from: fechaFin)
        dateFormatterFin.dateFormat = "HH:mm:ss"
        let horaFinString = dateFormatterFin.string(from: fechaFin)
        
        //formato tiempo total
        let tiempo = pasarBonitoElTiempo(time: recorrido.tiempoT)
        
        
        form +++ Section("Inicio")
            <<< TextRow() {
                $0.title = "Fecha"
                $0.baseValue = fechaInicioString
                $0.disabled = true
                
                }.cellUpdate() {cell, row in
                    cell.titleLabel?.textColor = UIColor.orange
            }
            <<< TextRow(){
                $0.title = "Hora"
                $0.value = horaInicioString
                $0.disabled = true
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textColor = UIColor.orange
            }
            
            +++ Section("Fin")
            <<< TextRow() {
                $0.title = "Fecha"
                $0.baseValue = fechaFinString
                $0.disabled = true
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textColor = UIColor.orange
            }
            <<< TextRow(){
                $0.title = "Hora"
                $0.value = horaFinString
                $0.disabled = true
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textColor = UIColor.orange
        }
            +++ Section("Actividad")
            <<< TextRow() {
                $0.title = "Actividad realizada"
                $0.baseValue = recorrido.tipo
                $0.disabled = true
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textColor = UIColor.orange
            }
        
            +++ Section("Tiempo transcurrido")
            <<< TextRow() {
                $0.title = "Tiempo de recorrido"
                $0.baseValue = tiempo
                $0.disabled = true
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textColor = UIColor.orange
            }
            +++ Section("Distancia")
            <<< TextRow() {
                $0.title = "Distancia recorrida"
                $0.baseValue = "\(Int(distanciaTotal)) metros"
                $0.disabled = true
                }.cellUpdate() {cell, row in
                    cell.textLabel?.textColor = UIColor.orange
        }
        calcularmetros()
    }
    
    func pasarBonitoElTiempo(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    //Harvesine
    func calcularmetros()  {
        let radioTierra = 3959.0
        let c1: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 42.866830, longitude: -2.677270 )
        let c2: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 42.867297, longitude: -2.675838 )
        
        let calc1 = c2.latitude - c1.latitude
        let calc2 = c2.longitude - c1.longitude
 
        let grado1 = calc1 * .pi / 180
        let grado2 = calc2 * .pi / 180
        
        let a = sin(grado1/2) * sin(grado1/2) + cos(c1.latitude * .pi / 180) * cos(c2.latitude * .pi / 180) * sin(grado2/2) * sin(grado2/2)
        let c = 2 * atan2(sqrt(a),sqrt(1-a))
        let d = radioTierra * c
        
        /*let a = sin(deltaP/2) * sin(deltaP/2) + cos(uLat.degreesToRadians) * cos(sLat.degreesToRadians) * sin(deltaL/2) * sin(deltaL/2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        let d = radius * c*/
        
        print("")
        var valorFinal = (d / 0.62137) * 1000
        print("Distancia => \(valorFinal.rounded()) Metros")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
   
    
    

}
