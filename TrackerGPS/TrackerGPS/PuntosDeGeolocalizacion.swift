//
//  PuntosDeGeolocalizacion.swift
//  TrackerGPS
//
//  Created by inaki on 28/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import Foundation

struct PuntosDeGeolocalizacion {
    var latitud: Double = 0
    var longitud: Double = 0
    init(l:Double,ln: Double) {
        self.latitud = l
        self.longitud = ln
    }
}
