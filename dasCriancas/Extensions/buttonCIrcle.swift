//
//  buttonCIrcle.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 21/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit

extension UIImage {
    var circle: UIImage {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let button = UIButton(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        button.contentMode = UIView.ContentMode.scaleAspectFill
        button.layer.cornerRadius = square.width/2
        button.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        button.layer.borderWidth = 5
        button.layer.masksToBounds = true
        UIGraphicsBeginImageContext(button.bounds.size)
        button.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return result
    }
}
