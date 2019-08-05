//
//  infoPaisScreen.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 16/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit

class infoPaisScreen: UIViewController {
    
    
    
    @IBOutlet var descricao: UILabel!
    
    
    
    @IBOutlet var imagem: UIImageView!
    
    
    var paisScreenImages: [UIImage] = [UIImage(named: "pS1")!, UIImage(named: "pS2")!, UIImage(named: "pS3")!, UIImage(named: "pS4")!, UIImage(named: "pS5")!, UIImage(named: "pS6")!, UIImage(named: "pS7")!, UIImage(named: "pS8")!, UIImage(named: "pS9")!, UIImage(named: "pS10")!, UIImage(named: "pS11")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagem.frame.size.width = self.view.frame.width * 0.7
        imagem.frame.size.height = self.view.frame.height * 0.6
        imagem.center.x = self.view.center.x
        imagem.center.y = self.view.center.y * 1.34
        
        imagem.animationImages = paisScreenImages
        imagem.animationDuration = 11
        imagem.startAnimating()
        
        imagem.layer.cornerRadius = 10
        imagem.layer.borderWidth = 2
        imagem.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        descricao.adjustsFontForContentSizeCategory = true
        
        
    }
    
    
    
 
}
