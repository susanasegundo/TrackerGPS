//
//  VistaHistorial.swift
//  TrackerGPS
//
//  Created by iñaki on 26/1/18.
//  Copyright © 2018 iñaki. All rights reserved.
//

import UIKit
import Firebase

//var recorridos: [Recorrido]?


class VistaHistorial: UITableViewController {

    var recorridos = [Recorrido]()
    var idUsuario: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //por cada documento dentro de recorridos, mire la id, y la compare con la id del usuario actual.
        db.collection("recorridos").whereField("id", isEqualTo: idUsuario).getDocuments() { (querySnapshot, err) in
            if let err = err{
                print("Error congiendo el documento: \(err)")
            }else{
                for document in querySnapshot!.documents {
                    //por cada documento coger sus valores y guardarlos en variables para mas tarde
                    
                    let documento = document.data()
                    let recorrido: Recorrido = Recorrido(fecha: (documento["fecha"] as? Date)!, id: documento["id"] as? String ?? "?", tipo: documento["tipo"] as? String ?? "?")
                    //recorrido.tipo = documento["tipo"] as? String ?? "?"
                   // print(recorrido.tipo)
                    
                    var gps = [Any]()
                    gps.append(documento["localizaciones"] as? [GeoPoint])
                    
                    print("GPS=> \(gps)")
                    print(gps.count)
                    //let info = documento["localizaciones"] as? Any
                    
                  /*  print("ESTA ES LA INFO =>    \(String(describing: info))")
                    let hilo: String = info.
                    print(hilo.substringToIndex())
                    */
                    
                   // var coleccion = [PuntosDeGeolocalizacion]()
                  //  coleccion.append(documento["localizaciones"] as! PuntosDeGeolocalizacion)
                    //recorrido.localizaciones.append(coleccion)
                  //  print(coleccion)
                    //print("\(coleccion.count) array de geo \(String(describing: coleccion.first))")
                    
                   // print(self.recorridos.count )
                    
                    //recargar tabla ahora que hay datos
                    
                   
                    //añadir recorrido a la matriz
                    self.recorridos.append(recorrido)
                    self.tableView.reloadData()
                    
                   /* var gps: PuntosDeGeolocalizacion = PuntosDeGeolocalizacion(l:0.0,ln:0.0)
                    gps.latitud = documento["localizaciones"] as? Double ?? 0
                    gps.longitud = documento["localizaciones"] as? Double ?? 0

                    print(gps)*/
                    //un bucle para sacar todos los objetos de geolocalizacion. Cada objeto viene en un par latitud:longitud:
                    
                    
                    
                    
                 /*   db.collection(document.documentID).getDocuments() { (querySnapshot, err) in
                        if let err = err{
                            print("Error congiendo el documento 2: \(err)")
                        }else{
                            for document1 in querySnapshot!.documents{
                                print(document1.data())
                            }
                        }
 
                    
                    //print("\(document.documentID) => \(document.data())")
                }*/
            }
            
        }
            
        }

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("2/3")
        print(self.recorridos.count)
        return self.recorridos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaHistorial

        //dar el formato separado de Fecha y Hora
        let fe = recorridos[indexPath.row].fecha
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let myString = dateFormatter.string(from: fe!)
        dateFormatter.dateFormat = "HH:mm:ss"
        let updatedString = dateFormatter.string(from: fe!)
       
        
        cell.fechaLabel.text = myString
        cell.fecha2Label.text = updatedString
        cell.tipoLabel.text = recorridos[indexPath.row].tipo
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
