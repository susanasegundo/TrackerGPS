//
//  Recorrido.swift
//  TrackerGPS
//
//  Created by inaki on 28/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import Foundation

struct Recorrido{
    enum tipos {
        case Andar
        case Correr
        case Bicicleta
    }
    
    var fecha: Date? {return TimeZone.current.nextDaylightSavingTimeTransition}//stackOverflow= how to get a users time zone.
    var id: Int
    var tipo: tipos
    
    var localizaciones: [PuntosDeGeolocalizacion]
    
}
