//
//  infoRelaxScreen.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 16/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit

class infoRelaxScreen: UIViewController {
    
    
    @IBOutlet var descricao: UILabel!
    
    
    @IBOutlet var imagem: UIImageView!
    
   
    var relaxScreenImages: [UIImage] = [UIImage(named: "rS1")!, UIImage(named: "rS2")!, UIImage(named: "rS2")!, UIImage(named: "rS3")!, UIImage(named: "rS4")!, UIImage(named: "rS5")!]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         descricao.adjustsFontForContentSizeCategory = true
//        descricao.layer.cornerRadius = 20
//        descricao.layer.borderWidth = 2
//        descricao.clipsToBounds = true
//        descricao.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
//        descricao.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        descricao.adjustsFontForContentSizeCategory = true
        
        imagem.animationImages = relaxScreenImages
        imagem.animationDuration = 5
        imagem.startAnimating()
        
        imagem.layer.cornerRadius = 10
        imagem.layer.borderWidth = 2
        imagem.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
    }
    
    
}
