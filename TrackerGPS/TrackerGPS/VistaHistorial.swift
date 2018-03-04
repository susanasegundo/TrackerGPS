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

    let secciones = ["Fecha Inicio           Actividad"]
    //array de recorridos para mostrar en la tabla
    var recorridos = [Recorrido]()
    var idUsuario: String!
    //el recorrido que se usa para meter al recorridos, y para pasar por el segue
    var recorrido: Recorrido = Recorrido()
    
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
                    //crear un objeto recorrido y pasarle valores del documento firebase
                    self.recorrido = Recorrido(fechaI: (documento["fechaInicio"] as? Date)!,fechaF: (documento["fechaFin"] as? Date)!,t: (documento["tiempoT"] as? Double!)!, id: documento["id"] as? String ?? "?", tipo: documento["tipo"] as? String ?? "?", localizaciones: documento["localizaciones"] as? [GeoPoint])
                    //con esto tenemos un objeto RECORRIDO con todos los datos del documento
                    //añadir recorrido a la matriz
                    self.recorridos.append(self.recorrido)
                    
                }
                //recargar tabla ahora que hay datos
                self.tableView.reloadData()
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
        return secciones.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recorridos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaHistorial
        // Configure the cell...
        //dar el formato separado de Fecha y Hora para poner en cada label
        let fe = recorridos[indexPath.row].fechaInicio
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy       HH:mm:ss"
        let myString = dateFormatter.string(from: fe)
        dateFormatter.dateFormat = "HH:mm:ss"
        let updatedString = dateFormatter.string(from: fe)
        //escribir en cada una de ellas
        cell.fechaLabel.text = myString
        cell.fecha2Label.text = updatedString
        cell.tipoLabel.text = recorridos[indexPath.row].tipo
        
       cell.botonVer.isEnabled = false
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return secciones[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CeldaHistorial
        cell.botonVer.isEnabled = true
        cell.botonVer.setBackgroundImage(#imageLiteral(resourceName: "botonVerVerde"), for: UIControlState.normal)
        
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CeldaHistorial
        cell.botonVer.isEnabled = false
        cell.botonVer.setBackgroundImage(#imageLiteral(resourceName: "botonVer"), for: UIControlState.normal)

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "aMapa"){
            let destino = segue.destination as! VistaMapa
          
            //pasar al destino el recorrido del row seleccionado
            destino.recorrido = recorridos[tableView.indexPathForSelectedRow!.row]
            destino.subirDatos = false
            //se deshabilita para que al volver atras y darle otra vez al boton no salga nil.
            let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! CeldaHistorial
            cell.botonVer.isEnabled = false
            cell.botonVer.setBackgroundImage(#imageLiteral(resourceName: "botonVer"), for: UIControlState.normal)

            destino.ventana = "Historial"
            
        }else{}
        
    }
    

}
