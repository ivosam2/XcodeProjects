//
//  ViewControllerTableViewCell.swift
//  convocatoriaMovilidad
//
//  Created by Ivo Sam on 3/28/18.
//  Copyright © 2018 Ivo Sam. All rights reserved.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelNombre: UILabel!
    @IBOutlet weak var labelNacional: UILabel!
    @IBOutlet weak var labelInternacional: UILabel!
    @IBOutlet weak var labelPosgrado: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
