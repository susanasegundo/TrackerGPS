//
//  VistaMarchando.swift
//  TrackerGPS
//
//  Created by iñaki on 26/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit

class VistaMarchando: UIViewController {
    var contadorSegundos = 0
    var contadorMinutos = 0
    var contadorHoras = 0
    var timer = Timer()
    
    @IBAction func empezar(_ sender: UIButton) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(VistaMarchando.action), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func pausa(_ sender: UIButton) {
        timer.invalidate()
    }
    
    @IBAction func stop(_ sender: UIButton) {
        timer.invalidate()
        contadorSegundos = 0
    }
    
    @IBOutlet weak var tiempo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @objc func action(){
        contadorSegundos += 1
        
       
        
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

