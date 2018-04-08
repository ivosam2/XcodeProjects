//
//  ViewControllerTableViewCell.swift
//  convocatoriaCursos
//
//  Created by Ivo Sam on 3/28/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var labelNombreConvocatoria: UILabel!
    @IBOutlet weak var labelNombreCurso: UILabel!
    @IBOutlet weak var labelCosto: UILabel!
    @IBOutlet weak var labelEnlace: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
