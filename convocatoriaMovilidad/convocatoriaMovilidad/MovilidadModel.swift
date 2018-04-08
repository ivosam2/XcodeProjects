//
//  MovilidadModel.swift
//  convocatoriaMovilidad
//
//  Created by Ivo Sam on 3/28/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

class MovilidadModel{
    
    var id: String?
    var nombre: String?
    var nacional: String?
    var internacional: String?
    var posgrado: String?
    
    init(id: String?, nombre: String?, nacional: String?, internacional: String?, posgrado: String?) {
        self.id = id;
        self.nombre = nombre;
        self.nacional = nacional;
        self.internacional = internacional;
        self.posgrado = posgrado;
    }
}
