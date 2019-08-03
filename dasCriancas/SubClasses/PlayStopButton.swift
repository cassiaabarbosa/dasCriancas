//
//  PlayStopButton.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 09/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit

class PlayStopButton: UIButton {
    var isOn = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        playButton()

    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
        playButton()
    }
    
    func playButton () {
        setImage(UIImage(named: "play"), for: .normal)
        addTarget(self, action: #selector(PlayStopButton.buttonPressed), for: .touchUpInside)
        
    }

    @objc func buttonPressed () {
        isOn = true
        setImage(UIImage(named: "stop"), for: .normal)

        
    }
    
}
