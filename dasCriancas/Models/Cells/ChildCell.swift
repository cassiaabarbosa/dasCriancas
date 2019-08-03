
//
//  ChildCell.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 23/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit
import CoreData

class ChildCell: UICollectionViewCell {
    
    var crianca: Crianca?
    var criancaIndex:Int?
    var parentVC:paisScreen?
    var collectionView: UICollectionView?
    var criancaId: UUID?

    
    @IBOutlet var deleteChildButton: exButton!
    
    
    @IBOutlet var childPhoto: UIImageView!
    var context : NSManagedObjectContext?
    
    
    @IBOutlet var base: UIImageView!
    
    @IBOutlet var childName: UILabel!
    
    @IBOutlet var childBirthday: UILabel!
    public var getDataBirthday: Date!
    
    }
