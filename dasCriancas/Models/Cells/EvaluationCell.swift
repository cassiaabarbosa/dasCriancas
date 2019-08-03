//
//  EvaluationCell.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 01/08/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import UIKit
import CoreData

class EvaluationCell: UICollectionViewCell {
    
    var avaliacao: Avaliacao?
    var avaliacaoIndex:Int?
    var parentVC:evaluationScreen?
    var collectionView: UICollectionView?
    var avaliacaoId: UUID?
    
    @IBOutlet var todayChildPhoto: UIImageView!
    
    @IBOutlet var dataEvaluation: UILabel!
    public var getDataEvaluation:Date!
    
    @IBOutlet var deleteChildButton: exButton!
    
    
    @IBOutlet var childName: UILabel!
    
    
    @IBOutlet var feliz: UIImageView!
    @IBOutlet var felizNumber: UILabel!
    
    
    @IBOutlet var amoroso: UIImageView!
    @IBOutlet var amorosoNumber: UILabel!
    
    
    @IBOutlet var irritado: UIImageView!
    @IBOutlet var irritadoNumber: UILabel!
    
    
    @IBOutlet var triste: UIImageView!
    @IBOutlet var tristeNumber: UILabel!
    
    @IBOutlet var base: UIImageView!
    
}
