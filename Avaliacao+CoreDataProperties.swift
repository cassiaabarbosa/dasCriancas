//
//  Avaliacao+CoreDataProperties.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 02/08/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//
//

import Foundation
import CoreData


extension Avaliacao {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Avaliacao> {
        return NSFetchRequest<Avaliacao>(entityName: "Avaliacao")
    }

    @NSManaged public var amoroso: Float
    @NSManaged public var dataDoDia: NSDate?
    @NSManaged public var feliz: Float
    @NSManaged public var foto: String?
    @NSManaged public var id: UUID?
    @NSManaged public var irritado: Float
    @NSManaged public var nome: String?
    @NSManaged public var triste: Float
    @NSManaged public var relationshipAvaliacaoCrianca: Crianca?

}
