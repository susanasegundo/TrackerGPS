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
       
    }
    
    func pasarBonitoElTiempo(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
   
    
    

}
