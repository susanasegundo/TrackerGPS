//
//  VistaEleccion.swift
//  TrackerGPS
//
//  Created by iñaki on 23/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit
import Firebase


class VistaEleccion: UIViewController {
    
    var idUsuarioAnonimo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        // Do any additional setup after loading the view.
        //logearse anonimamente
        Auth.auth().signInAnonymously(){(user, error) in
            
            if  user!.isAnonymous  {
            self.idUsuarioAnonimo = user!.uid}
            print("usuario conectado correctamente \(self.idUsuarioAnonimo)")
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
