//
//  ConvocatoriaCursoModel.swift
//  convocatoriaCursos
//
//  Created by Ivo Sam on 3/28/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

class ConvocatoriaCursoModel{
    var id: String?
    var nombreConvocatoria: String?
    var nombreCurso: String?
    var costo: String?
    var enlace: String?
    
    init(id: String?, nombreConvocatoria: String?, nombreCurso: String?, costo: String?, enlace: String?){
        self.id = id;
        self.nombreConvocatoria = nombreConvocatoria;
        self.nombreCurso = nombreCurso;
        self.costo  = costo;
        self.enlace = enlace;
    }
}
