//
//  MaterialModel.swift
//  materiales
//
//  Created by Ivo Sam on 3/28/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

class MaterialModel{
    
    var id: String?
    var nombre: String?
    var unidad: String?
    var link: String?
    
    init(id:String?, nombre:String?, unidad:String?, link:String?) {
        self.id = id;
        self.nombre = nombre;
        self.unidad = unidad;
        self.link = link;
    }
    
}
