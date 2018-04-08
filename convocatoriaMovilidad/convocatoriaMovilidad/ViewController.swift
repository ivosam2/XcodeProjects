//
//  ViewController.swift
//  convocatoriaMovilidad
//
//  Created by Ivo Sam on 3/28/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refMovilidades: DatabaseReference!
    
    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var textFieldNombre: UITextField!
    @IBOutlet weak var textFieldNacional: UITextField!
    @IBOutlet weak var textFieldInternacional: UITextField!
    @IBOutlet weak var textFieldPosgrado: UITextField!
    
    @IBOutlet weak var labelMensaje: UILabel!
    
    @IBOutlet weak var tableViewMovilidad: UITableView!
    
    var movilidadesList = [MovilidadModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movilidad = movilidadesList[indexPath.row]
        
        let alertController = UIAlertController(title:movilidad.nombre, message: "Dar nuevos valores a la convocatoria o elimínala.", preferredStyle:.alert)
        
        let updateAction = UIAlertAction(title: "Actualizar", style:.default){(_) in
            
            let id = movilidad.id
            
            let nombre = alertController.textFields?[0].text
            let nacional = alertController.textFields?[1].text
            let internacional = alertController.textFields?[2].text
            let posgrado = alertController.textFields?[3].text
            
            self.updateMovilidad(id: id!, nombre: nombre!, nacional: nacional!, internacional: internacional!, posgrado: posgrado!)
        }
        let deleteAction = UIAlertAction(title: "Eliminar", style:.default){(_) in
            self.deleteMovilidad(id: movilidad.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = movilidad.nombre
        }
        
        alertController.addTextField{(textField) in
            textField.text = movilidad.nacional
        }
        
        alertController.addTextField{(textField) in
            textField.text = movilidad.internacional
        }
        
        alertController.addTextField{(textField) in
            textField.text = movilidad.posgrado
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated:true, completion: nil)
    }
    
    func updateMovilidad(id: String, nombre: String, nacional: String, internacional: String, posgrado: String){
        let movilidad = [
            "id": id,
            "movilidadNombre": nombre,
            "movilidadNacional": nacional,
            "movilidadInternacional": internacional,
            "movilidadPosgrado": posgrado
        ]
        
        refMovilidades.child(id).setValue(movilidad)
        labelMensaje.text = "Información de convocatoria actualizada"
    }
    
    func deleteMovilidad(id: String){
        refMovilidades.child(id).setValue(nil)
        labelMensaje.text = "Convocatoria eliminada"
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movilidadesList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        let movilidad: MovilidadModel
        
        movilidad = movilidadesList[indexPath.row]
        
        cell.labelNombre.text = movilidad.nombre
        cell.labelNacional.text = movilidad.nacional
        cell.labelInternacional.text = movilidad.internacional
        cell.labelPosgrado.text = movilidad.posgrado
        
        return cell
    }
    
    @IBAction func buttonAgregar(_ sender: UIButton) {
        addMovilidad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refMovilidades = Database.database().reference().child("movilidades");
        
        refMovilidades.observe(DataEventType.value, with: {(snapshot)in
            if snapshot.childrenCount>0{
                self.movilidadesList.removeAll()
                
                for movilidades in snapshot.children.allObjects as![DataSnapshot]{
                    let movilidadObject = movilidades.value as? [String: AnyObject]
                    let movilidadNombre = movilidadObject?["movilidadNombre"]
                    let movilidadNacional = movilidadObject?["movilidadNacional"]
                    let movilidadInternacional = movilidadObject?["movilidadInternacional"]
                    let movilidadPosgrado = movilidadObject?["movilidadPosgrado"]
                    let movilidadId = movilidadObject?["id"]
                    
                    let movilidad = MovilidadModel(id: movilidadId as! String?, nombre: movilidadNombre as! String?, nacional: movilidadNacional as! String?, internacional: movilidadInternacional as! String?, posgrado: movilidadPosgrado as! String?)
                    
                    self.movilidadesList.append(movilidad)
                }
                self.tableViewMovilidad.reloadData()
            }
        })
    }

    func addMovilidad(){
        let key = refMovilidades.childByAutoId().key
        
        if(textFieldNombre.text != "" && textFieldNacional.text != "" && textFieldInternacional.text != "" && textFieldPosgrado.text != ""){
            let movilidad = ["id": key,
                            "movilidadNombre": textFieldNombre.text! as String,
                            "movilidadNacional": textFieldNacional.text! as String,
                            "movilidadInternacional": textFieldInternacional.text! as String,
                            "movilidadPosgrado": textFieldPosgrado.text! as String
            ]
            
            refMovilidades.child(key).setValue(movilidad)
            
            labelMensaje.text = "Convocatoria de movilidad agregada con éxito"
        }
        else{
            labelMensaje.textColor=#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            labelMensaje.text = "Campos vacíos"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

