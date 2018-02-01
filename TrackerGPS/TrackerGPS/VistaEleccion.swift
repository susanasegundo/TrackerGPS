//
//  VistaEleccion.swift
//  TrackerGPS
//
//  Created by iñaki on 23/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit
import Firebase


class VistaEleccion: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    let selectorValores = ["Andar","Correr","Bicicleta"]
    var tipo = ""
    
    var idUsuarioAnonimo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //cargar el selector de valores
        selector.delegate = self
        selector.dataSource = self
        
        // Do any additional setup after loading the view.
        //logearse anonimamente
        Auth.auth().signInAnonymously(){(user, error) in
            
            if  user!.isAnonymous  {
            self.idUsuarioAnonimo = user!.uid}
            print("usuario conectado correctamente \(self.idUsuarioAnonimo)")
        }
        
    }
    @IBOutlet weak var selector: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return selectorValores.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectorValores[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //cuando se selecciona el row
        tipo = selectorValores[row]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if( segue.identifier == "aPantallaHistorial"){
            let destino = segue.destination as! VistaHistorial
            
            destino.idUsuario = idUsuarioAnonimo
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
