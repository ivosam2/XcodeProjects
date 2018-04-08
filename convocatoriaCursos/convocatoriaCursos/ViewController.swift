//
//  ViewController.swift
//  convocatoriaCursos
//
//  Created by Ivo Sam on 3/28/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refConvocatoriaCursos: DatabaseReference!
    
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var textFieldNombreConvocatoria: UITextField!
    @IBOutlet weak var textFieldNombreCurso: UITextField!
    @IBOutlet weak var textFieldCosto: UITextField!
    @IBOutlet weak var textFieldEnlace: UITextField!
    
    @IBOutlet weak var labelMensaje: UILabel!
    
    @IBAction func buttonRegistrar(_ sender: UIButton) {
        addConvocatoriaCurso()
    }
    
    @IBOutlet weak var tableViewConvocatoriaCurso: UITableView!
    
    var convocatoriaCursosList = [ConvocatoriaCursoModel]()
    
//    public func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let convocatoriaCurso = convocatoriaCursosList[indexPath.row]
        
        let alertController = UIAlertController(title:convocatoriaCurso.nombreConvocatoria, message: "Dar nuevos valores a la convocatoria o elimínala.", preferredStyle:.alert)
        
        let updateAction = UIAlertAction(title: "Actualizar", style:.default){(_) in
            
            let id = convocatoriaCurso.id
            
            let nombreConvocatoria = alertController.textFields?[0].text
            let nombreCurso = alertController.textFields?[1].text
            let costo = alertController.textFields?[2].text
            let enlace = alertController.textFields?[3].text
            
            self.updateConvocatoriaCurso(id: id!, nombreConvocatoria: nombreConvocatoria!, nombreCurso: nombreCurso!, costo: costo!, enlace: enlace!)
        }
        let deleteAction = UIAlertAction(title: "Eliminar", style:.default){(_) in
            self.deleteConvocatoriaCurso(id: convocatoriaCurso.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = convocatoriaCurso.nombreConvocatoria
        }
        
        alertController.addTextField{(textField) in
            textField.text = convocatoriaCurso.nombreCurso
        }
        
        alertController.addTextField{(textField) in
            textField.text = convocatoriaCurso.costo
        }
        
        alertController.addTextField{(textField) in
            textField.text = convocatoriaCurso.enlace
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated:true, completion: nil)
    }
    
    func updateConvocatoriaCurso(id: String, nombreConvocatoria: String, nombreCurso: String, costo: String, enlace: String){
        let convocatoriaCurso = [
            "id": id,
            "convocatoriaCursoNombre": nombreConvocatoria,
            "cursoNombre": nombreCurso,
            "convocatoriaCursoCosto": costo,
            "convocatoriaCursoEnlace": enlace
        ]
        
        refConvocatoriaCursos.child(id).setValue(convocatoriaCurso)
        labelMensaje.text = "Información de convocatoria actualizada"
    }
    
    func deleteConvocatoriaCurso(id: String){
        refConvocatoriaCursos.child(id).setValue(nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return convocatoriaCursosList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let convocatoriaCurso: ConvocatoriaCursoModel
        
        convocatoriaCurso = convocatoriaCursosList[indexPath.row]
        
        cell.labelNombreConvocatoria.text = convocatoriaCurso.nombreConvocatoria
        cell.labelNombreCurso.text = convocatoriaCurso.nombreCurso
        cell.labelCosto.text = convocatoriaCurso.costo
        cell.labelEnlace.text = convocatoriaCurso.enlace
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableViewConvocatoriaCurso.estimatedRowHeight = 4
        tableViewConvocatoriaCurso.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refConvocatoriaCursos = Database.database().reference().child("convocatoriaCursos");
        
        refConvocatoriaCursos.observe(DataEventType.value, with: {(snapshot)in
            if snapshot.childrenCount>0{
                self.convocatoriaCursosList.removeAll()
                
                for convocatoriaCursos in snapshot.children.allObjects as![DataSnapshot]{
                    let convocatoriaCursoObject = convocatoriaCursos.value as? [String: AnyObject]
                    let convocatoriaCursoNombre = convocatoriaCursoObject?["convocatoriaCursoNombre"]
                    let cursoNombre = convocatoriaCursoObject?["cursoNombre"]
                    let convocatoriaCursoCosto = convocatoriaCursoObject?["convocatoriaCursoCosto"]
                    let convocatoriaCursoEnlace = convocatoriaCursoObject?["convocatoriaCursoEnlace"]
                    let convocatoriaCursoId = convocatoriaCursoObject?["id"]
                    
                    let convocatoriaCurso = ConvocatoriaCursoModel(id: convocatoriaCursoId as! String?, nombreConvocatoria: convocatoriaCursoNombre as! String?, nombreCurso: cursoNombre as! String?, costo: convocatoriaCursoCosto as! String?, enlace: convocatoriaCursoEnlace as! String?)
                    
                    self.convocatoriaCursosList.append(convocatoriaCurso)
                }
                self.tableViewConvocatoriaCurso.reloadData()
            }
        })
    }

    func addConvocatoriaCurso(){
        let key = refConvocatoriaCursos.childByAutoId().key
        
        if(textFieldNombreConvocatoria.text != "" && textFieldNombreCurso.text != "" && textFieldCosto.text != "" && textFieldEnlace.text != ""){
        let convocatoriaCurso = ["id": key,
                        "convocatoriaCursoNombre": textFieldNombreConvocatoria.text! as String,
                        "cursoNombre": textFieldNombreCurso.text! as String,
                        "convocatoriaCursoCosto": textFieldCosto.text! as String,
                        "convocatoriaCursoEnlace": textFieldEnlace.text! as String
        ]
        
        refConvocatoriaCursos.child(key).setValue(convocatoriaCurso)
        
        labelMensaje.text = "Convocatoria de curso agregada con éxito"
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

