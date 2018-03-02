//
//  VistaInicio.swift
//  TrackerGPS
//
//  Created by iñaki on 23/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit

// link => https://github.com/brianadvent/CoolCoreAnimations

class VistaInicio: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //añadir animacion pulsacion boton inicio
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(VistaInicio.addPulse))
        tapGestureRecognizer.numberOfTapsRequired = 1
        boton.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //creacion del pulso
    @objc func addPulse(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 150, position:boton.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor.white.cgColor
        
        self.view.layer.insertSublayer(pulse, below: boton.layer)
        
        _ = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: (#selector(VistaInicio.cambiar)), userInfo: nil, repeats: false)

        
    }
  @objc func cambiar()  {
        self.performSegue(withIdentifier: "aEleccion", sender: self)
    }
    
    @IBAction func volver(segue:UIStoryboardSegue){
        
    }
    
    @IBAction func botonClick(_ sender: Pulsing) {
        
    }
    
    @IBOutlet weak var boton: UIButton!
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "aEleccion"){
            let destino = segue.destination as! UINavigationController
            _ = destino.topViewController as! VistaEleccion
            
        }else{
        }
    }
    

}
