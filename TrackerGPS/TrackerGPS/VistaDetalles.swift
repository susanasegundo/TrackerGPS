//
//  VistaDetalles.swift
//  TrackerGPS
//
//  Created by  on 8/2/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit

class VistaDetalles: UIViewController {

    var recorrido: Recorrido = Recorrido()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //actualizar labels
        //dar el formato separado de Fecha y Hora para poner en cada label
        let fecha = recorrido.fechaInicio
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        var fechaString = dateFormatter.string(from: fecha)
        dateFormatter.dateFormat = "HH:mm:ss"
        var horaString = dateFormatter.string(from: fecha)
        //escribir en cada una de ellas
        fechaInicio.text = fechaString
        horaInicio.text = horaString
        
        let feFin = recorrido.fechaFin
         fechaString = dateFormatter.string(from: feFin)
         horaString = dateFormatter.string(from: feFin)
        //escribir en cada una de ellas
        fechaFin.text = fechaString
        horaFin.text = horaString
        
        tiempoTotal.text = String(recorrido.tiempoT)
        actividad.text = recorrido.tipo
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBOutlet weak var fechaInicio: UILabel!
    @IBOutlet weak var horaInicio: UILabel!
    @IBOutlet weak var fechaFin: UILabel!
    @IBOutlet weak var horaFin: UILabel!
    @IBOutlet weak var tiempoTotal: UILabel!
    @IBOutlet weak var actividad: UILabel!
    
    

}
