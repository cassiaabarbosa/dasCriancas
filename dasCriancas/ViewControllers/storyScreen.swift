//
//  storyScreen.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 27/06/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit

class storyScreen: UIViewController {
    
    @IBOutlet var buttao: UIButton!
    
    
    
    
    var balloons = [ "sun", "tesoura", "brinquedo", "historia", "computador", "castelo", "tres", "sereia", "morango", "flor", "monstro", "frio", "aviao", "moedas", "floresta", "nuvem", "musica", "porta", "folhas", "calor", "oculos", "ouro", "arvore", "oceano", "bicicleta", "vermelho", "azul", "praia", "arara", "machucado", "lapis", "celular", "professora", "carrinho", "papai", "neve", "rio","jaqueta", "lobo", "comida", "tartaruga", "casa", "mamae", "princesa", "mochila", "escola", "estrela", "festa"]
    
    
    var birds : [UIImage] = [UIImage(named: "bird1")!, UIImage(named: "bird2")!, UIImage(named: "bird3")!]
    
    
    var littleBirds : [UIImage] = [UIImage(named: "bird12")!, UIImage(named: "bird22")!, UIImage(named: "bird32")!]
    
    
    @IBOutlet var cloud1: UIImageView!
    
    
    @IBOutlet var cloud2: UIImageView!
    
    
    @IBOutlet var cloud3: UIImageView!
    
    
    @IBOutlet var cloud4: UIImageView!
    
    
    @IBOutlet var cloud5: UIImageView!
    
    
    @IBOutlet var cloud6: UIImageView!
    
    
    @IBOutlet var bird: UIImageView!
    
    
    @IBOutlet var littleBird: UIImageView!
    
    
    @IBOutlet var soil: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        cloudAnimation(cloud: cloud1, time: 25, limit: 0.70)
        
        cloudAnimation(cloud: cloud2, time:25, limit: 0.76)
        
        cloudAnimation(cloud: cloud3, time: 25, limit: 0.3)
        
        cloudAnimation(cloud: cloud4, time: 25, limit: 0.14)
        
        cloudAnimation(cloud: cloud5, time: 25, limit: 0.18)
        
        cloudAnimation(cloud: cloud6, time: 25, limit: 0.6)
        
        buttao.setImage(UIImage(named: "ballon"), for: .normal)
        
        bird.stopAnimating()
        
        littleBird.stopAnimating()
        
        state = 1
        
        balloons = [ "sun", "tesoura", "brinquedo", "historia", "computador", "castelo", "tres", "sereia", "morango", "flor", "monstro", "frio", "aviao", "moedas", "floresta", "nuvem", "musica", "porta", "folhas", "calor", "oculos", "ouro", "arvore", "oceano", "bicicleta", "vermelho", "azul", "praia", "arara", "machucado", "lapis", "celular", "professora", "carrinho", "papai", "neve", "rio","jaqueta", "lobo", "comida", "tartaruga", "casa", "mamae", "princesa", "mochila", "escola", "estrela", "festa"]
        
        balloonsAnimation()
        
    }
    
    
    var state : Int = 1
    
    @IBAction func playStopButton(_ sender: Any) {
        if (state == 1) {
            littleBird.stopAnimating()
            
            bird.animationDuration = 1
            bird.animationImages = birds
            bird.startAnimating()
            
            adjustBalloons()
            
            state = 2
            
        }
            
            
        else {
            bird.stopAnimating()
            
            littleBird.animationDuration = 1
            littleBird.animationImages = littleBirds
            littleBird.startAnimating()
            
            adjustBalloons()
            
            state = 1
            
        }
        
    }
    
    
    func cloudAnimation(cloud : UIImageView, time : TimeInterval, limit : CGFloat) {
        UIImageView.animate(withDuration: TimeInterval(time), delay: 0, options: [.repeat, .autoreverse,.curveLinear], animations: {cloud.center.x = self.view.frame.width * limit}, completion:{_ in})
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.cloud1.frame.size.width = self.view.frame.width * 0.2
        self.cloud1.frame.size.height = self.view.frame.height * 0.2
        self.cloud1.center.y = self.view.frame.height * 0.14
        self.cloud1.center.x = self.view.frame.width * 0.85
        
        
        self.cloud2.frame.size.width = self.view.frame.width * 0.2
        self.cloud2.frame.size.height = self.view.frame.height * 0.2
        self.cloud2.center.y = self.view.frame.height * 0.25
        self.cloud2.center.x = self.view.frame.width * 0.87
        
        
        self.cloud3.frame.size.width = self.view.frame.width * 0.2
        self.cloud3.frame.size.height = self.view.frame.height * 0.2
        self.cloud3.center.y = self.view.frame.height * 0.3
        self.cloud3.center.x = self.view.frame.width * 0.45
        
        
        self.cloud4.frame.size.width = self.view.frame.width * 0.22
        self.cloud4.frame.size.height = self.view.frame.height * 0.2
        self.cloud4.center.y = self.view.frame.height * 0.25
        self.cloud4.center.x = self.view.frame.width * 0.20
        
        
        self.cloud5.frame.size.width = self.view.frame.width * 0.25
        self.cloud5.frame.size.height = self.view.frame.height * 0.32
        self.cloud5.center.y = self.view.frame.height * 0.13
        self.cloud5.center.x = self.view.frame.width * 0.3
        
        
        self.cloud6.frame.size.width = self.view.frame.width * 0.2
        self.cloud6.frame.size.height = self.view.frame.height * 0.2
        self.cloud6.center.y = self.view.frame.height * 0.3
        self.cloud6.center.x = self.view.frame.width * 0.7
        
        
        self.buttao.frame.size.width = self.view.frame.width * 0.45
        self.buttao.frame.size.height = self.view.frame.height * 0.35
        self.buttao.center.y = self.view.frame.height * 0.6
        self.buttao.center.x = self.view.frame.width * 0.65

    }
    
    
    var cont : Int = 0
    
    func adjustBalloons () {
        
        if cont < 48 {
            cont = cont + 1
            let randomNum : Int = Int(arc4random_uniform(UInt32(Int(balloons.count))))
            buttao.setImage(UIImage(named: balloons[randomNum]), for: .normal)
            balloons.remove(at: randomNum)
            
        }
            
        else if  (cont == 49) {
            buttao.setImage(UIImage(named: balloons[0]), for: .normal)
            
        }
            
        else {
            cont = 0
            balloons = [ "sun", "tesoura", "brinquedo", "historia", "computador", "castelo", "tres", "sereia", "morango", "flor", "monstro", "frio", "aviao", "moedas", "floresta", "nuvem", "musica", "porta", "folhas", "calor", "oculos", "ouro", "arvore", "oceano", "bicicleta", "vermelho", "azul", "praia", "arara", "machucado", "lapis", "celular", "professora", "carrinho", "papai", "neve", "rio","jaqueta", "lobo", "comida", "tartaruga", "casa", "mamae", "princesa", "mochila", "escola", "estrela", "festa"]
            
            buttao.setImage(UIImage(named:"ballon"),for: .normal)
            
            bird.stopAnimating()
            
            littleBird.stopAnimating()
            
        }
        
    }
    
    
    func balloonsAnimation () {
        UIButton.animate(withDuration: TimeInterval(20), delay: 0, options: [.repeat, .autoreverse,.curveLinear, .allowUserInteraction], animations: {self.buttao.center.y = self.view.frame.height * 0.48}, completion:{_ in})
        
    }
    
}
