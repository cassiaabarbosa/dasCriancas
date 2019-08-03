//
//  relaxScreen.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 27/06/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit

class relaxScreen: UIViewController {
    
    
    var timeImages : [UIImage] = [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!, UIImage(named: "4")!, UIImage(named: "5")!,UIImage(named: "6")!]
    
    
    var commandImages : [UIImage] = [UIImage(named: "INSPIRE")!, UIImage(named: "EXPIRE")!]
    
    
    var drawImages : [UIImage] = [UIImage(named: "relax1")!, UIImage(named: "relax2")!]
    
    
    @IBOutlet var buttao: UIButton!
    
    
    @IBOutlet weak var comand: UIImageView!
    
    
    @IBOutlet weak var draw: UIImageView!
    
    
    @IBOutlet weak var time: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        draw.image = UIImage(named: "relax1")!
        

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        pause()
        buttao.setImage(UIImage(named: "play"), for: .normal)
        state = 1
        
    }
    
    
    var state : Int = 1
    
    
    @IBAction func playButton(_ sender: Any) {
        let playBtn = sender as! UIButton
        
        if (state == 1) {
            play()
            state = 2
            playBtn.setImage(UIImage(named: "stop"), for: .normal)
        }
            
        else {
            pause()
            state = 1
            playBtn.setImage(UIImage(named:"play"),for: .normal)
        }
        
    }
    
    
    func play() {
        comand.animationImages = commandImages
        comand.animationDuration = 12
        comand.startAnimating()
        
        draw.animationImages = drawImages
        draw.animationDuration = 12
        draw.startAnimating()
        
        time.animationImages = timeImages
        time.animationDuration = 6
        time.startAnimating()
        
    }
    
    
    func pause() {
        draw.image = UIImage(named: "relax1")
        
        time.stopAnimating()
        
        comand.stopAnimating()
        
        draw.stopAnimating()

    }
        
}
    
