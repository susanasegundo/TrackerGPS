//
//  Recorrido.swift
//  TrackerGPS
//
//  Created by inaki on 28/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import Foundation
import Firebase

class Recorrido{
    
    //fecha inicio recorrido
    var fechaInicio: Date
    //fecha fin de recorrido
    var fechaFin: Date
    
    //tiempo total de ruta
    var tiempoT: Double
    
    //id del usuario o movil
    var id: String
    //del tipo Correr, andar, bici ...
    var tipo: String
    
    var localizaciones = [GeoPoint] ()
    
    init() {//por defecto, que de primeras estan mal
        self.fechaInicio = Date.init()
        self.fechaFin = Date.init()
        self.tiempoT = -1
        self.id = ""
        self.tipo = ""
        self.localizaciones = [GeoPoint(latitude: 0, longitude: 0)]
    }
    
    init(fechaI: Date?,fechaF: Date?,t: Double?, id: String?, tipo: String?, localizaciones: [GeoPoint]?) {
        self.fechaInicio = fechaI!
        self.fechaFin = fechaF!
        self.tiempoT = t!
        self.id = id!
        self.tipo = tipo!
        self.localizaciones = localizaciones!
        
    }
}
