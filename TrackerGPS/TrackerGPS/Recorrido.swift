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
   /* enum tipos {
        case Andar
        case Correr
        case Bicicleta
    }*/
    
    var returnFecha: Date! {return TimeZone.current.nextDaylightSavingTimeTransition}//stackOverflow= how to get a users time zone.
    var fecha: Date!
    var id: String
    var tipo: String
    
    var localizaciones = [GeoPoint] ()
    
    init(fecha: Date, id: String, tipo: String, localizaciones: [GeoPoint]) {
        self.fecha = fecha
        self.id = id
        self.tipo = tipo
        self.localizaciones = localizaciones
        
    }
}
