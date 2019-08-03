//
//  AddCildCellCollectionViewCell.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 25/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit
import CoreData

class AddChildCell: UICollectionViewCell {
    
    
    @IBOutlet var addChildPhoto: UIImageView!
    

    
    @IBOutlet var addChildName: UITextField!
    
    override func awakeFromNib() {
    //        deleteChild.imageView?.image = deleteChild.imageView?.image?.circleMask
        
        addChildPhoto.layer.cornerRadius = 50
        addChildPhoto.clipsToBounds = true
        
//        base.layer.cornerRadius = 50
//        base.clipsToBounds = true
        
//        base.
    }
    
}
