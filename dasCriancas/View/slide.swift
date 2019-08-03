//
//  slide.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 05/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit

class slide: UIView {

    
    @IBOutlet var imagem: UIImageView!

    
    @IBOutlet var descricao: UILabel!
    
    
    @IBOutlet var okButton: UIButton!
    
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
     override func draw(_ rect: CGRect) {
        okButton.imageView?.image = okButton.imageView?.image?.circleMask
    }

}
