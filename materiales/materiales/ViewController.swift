//
//  ViewController.swift
//  materiales
//
//  Created by Ivo Sam on 3/28/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var refMateriales: DatabaseReference! 

    @IBOutlet weak var textFieldMaterialNombre: UITextField!
    @IBOutlet weak var textFieldMaterialUA: UITextField!
    @IBOutlet weak var textFieldMaterialLink: UITextField!
    
    @IBOutlet weak var labelMensaje: UILabel!
    
    @IBAction func buttonAgregarMaterial(_ sender: UIButton) {
        addMaterial()
    }
    
    @IBOutlet weak var tableViewMateriales: UITableView!
    
    var materialesList = [MaterialModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let material = materialesList[indexPath.row]
        
        let alertController = UIAlertController(title:material.nombre, message: "Dar nuevos valores del material o eliminarlo.", preferredStyle:.alert)
        
        let updateAction = UIAlertAction(title: "Actualizar", style:.default){(_) in
            
            let id = material.id
            
            let nombre = alertController.textFields?[0].text
            let unidad = alertController.textFields?[1].text
            let link = alertController.textFields?[2].text
            
            self.updateMaterial(id: id!, nombre: nombre!, unidad: unidad!, link: link!)
        }
        
        let deleteAction = UIAlertAction(title: "Eliminar", style:.default){(_) in
            self.deleteMaterial(id: material.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = material.nombre
        }
        
        alertController.addTextField{(textField) in
            textField.text = material.unidad
        }
        
        alertController.addTextField{(textField) in
            textField.text = material.link
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated:true, completion: nil)
    }
    
    func updateMaterial(id: String, nombre: String, unidad: String, link: String){
        let material = [
            "id": id,
            "materialNombre": nombre,
            "materialUA": unidad,
            "materialLink": link
        ]
        
        refMateriales.child(id).setValue(material)
        labelMensaje.text = "Material actualizado"
    }
    
    func deleteMaterial(id: String){
        refMateriales.child(id).setValue(nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return materialesList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let material: MaterialModel
        
        material = materialesList[indexPath.row]
        
        cell.labelMaterialNombre.text = material.nombre
        cell.labelMaterialUA.text = material.unidad
        cell.labelMaterialLink.text = material.link
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refMateriales = Database.database().reference().child("materiales");
        
        refMateriales.observe(DataEventType.value, with: {(snapshot)in
            if snapshot.childrenCount>0{
                self.materialesList.removeAll()
                
                for materiales in snapshot.children.allObjects as![DataSnapshot]{
                    let materialObject = materiales.value as? [String: AnyObject]
                    let materialNombre = materialObject?["materialNombre"]
                    let materialUA = materialObject?["materialUA"]
                    let materialLink = materialObject?["materialLink"]
                    let materialId = materialObject?["id"]
                    
                    let material = MaterialModel(id: materialId as! String?, nombre: materialNombre as! String?, unidad: materialUA as! String?, link: materialLink as! String?)
                    
                    self.materialesList.append(material)
                }
                self.tableViewMateriales.reloadData()
            }
        })
    }
    
    func addMaterial(){
        let key = refMateriales.childByAutoId().key
        
        if(textFieldMaterialNombre.text != "" && textFieldMaterialUA.text != "" && textFieldMaterialLink.text != ""){
        let material = ["id": key,
                        "materialNombre": textFieldMaterialNombre.text! as String,
                        "materialUA": textFieldMaterialUA.text! as String,
                        "materialLink": textFieldMaterialLink.text! as String
                        ]
        
        refMateriales.child(key).setValue(material)
        
        labelMensaje.text = "Material agregado con éxito"
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

