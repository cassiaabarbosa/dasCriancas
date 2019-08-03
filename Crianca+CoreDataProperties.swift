//
//  Crianca+CoreDataProperties.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 02/08/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//
//

import Foundation
import CoreData


extension Crianca {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Crianca> {
        return NSFetchRequest<Crianca>(entityName: "Crianca")
    }

    @NSManaged public var aniversario: NSDate?
    @NSManaged public var foto: String?
    @NSManaged public var id: UUID?
    @NSManaged public var nome: String?
    @NSManaged public var relationshipCriancaAvaliacao: NSSet?

}

// MARK: Generated accessors for relationshipCriancaAvaliacao
extension Crianca {

    @objc(addRelationshipCriancaAvaliacaoObject:)
    @NSManaged public func addToRelationshipCriancaAvaliacao(_ value: Avaliacao)

    @objc(removeRelationshipCriancaAvaliacaoObject:)
    @NSManaged public func removeFromRelationshipCriancaAvaliacao(_ value: Avaliacao)

    @objc(addRelationshipCriancaAvaliacao:)
    @NSManaged public func addToRelationshipCriancaAvaliacao(_ values: NSSet)

    @objc(removeRelationshipCriancaAvaliacao:)
    @NSManaged public func removeFromRelationshipCriancaAvaliacao(_ values: NSSet)

}
