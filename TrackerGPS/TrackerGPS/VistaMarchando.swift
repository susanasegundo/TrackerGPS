//
//  VistaMarchando.swift
//  TrackerGPS
//
//  Created by iñaki on 26/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit

class VistaMarchando: UIViewController {
    
    var fechaInicio: Date = Date()
    
    //tema timer contador => https://medium.com/ios-os-x-development/build-an-stopwatch-with-swift-3-0-c7040818a10f
    var contador = 0
    var tiempo = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        runTimer()
        
    }
    
    //funcion para bucle contador, sume mas 1
    func runTimer() {
        tiempo = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(VistaMarchando.contadorSuma)), userInfo: nil, repeats: true)
    }
    //el contador en si mismo, cambiando el tiempoLabel
    @objc func contadorSuma() {
        contador += 1
        tiempoLabel.text = pasarBonitoElTiempo(time: TimeInterval(contador))
       //print(contador)
    }
    //dejarlo bonito
    func pasarBonitoElTiempo(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
    @IBOutlet weak var tiempoLabel: UILabel!
    
    //cuando se pulse cambie de estado el propio boton y el timeLabel.
    @IBOutlet weak var pausaNombre: UIButton!
    var estadoBotonPausa: Int = 0
    @IBAction func pausaBoton(_ sender: Any) {
        
        if estadoBotonPausa == 0 {
            estadoBotonPausa = 1
            //pausar timer
            tiempo.invalidate()
            pausaNombre.setTitle("Reanudar", for: UIControlState.normal)
        }else{
            estadoBotonPausa = 0
            //reanudar timer
            runTimer()
            pausaNombre.setTitle("Pausar", for: UIControlState.normal)
        }
    }
    
    //Boton STOP
    @IBAction func stopBoton(_ sender: Any) {
        //Se va a mostrar un mensaje de alerta
        tiempo.invalidate()
        var vControl = 0
       
        
        let defaultAction = UIAlertAction(title: "Aceptar", style: .default){
            (action) in
            //que ocurre
                //self.pausaNombre.isEnabled = false
            vControl = 1
            print("aceptar")
            if vControl == 1 {
                print("Prepare segue")
                //que se ejecute el segue
                self.performSegue(withIdentifier: "aMapa", sender: self)
            }
        }
        
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel){
            (action) in
            //respond to user selection of the action
            self.runTimer()
            print("cancelar")
            
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
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if( segue.identifier == "aMapa"){
            let destino = segue.destination as! VistaMapa
            
            //destino.idUsuario = idUsuarioAnonimo
            
        }else{}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
}
