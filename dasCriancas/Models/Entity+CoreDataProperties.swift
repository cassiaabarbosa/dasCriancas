//
//  Entity+CoreDataProperties.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 22/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Responsavel")
    }

    @NSManaged public var id: String?
    @NSManaged public var nome: String?
    @NSManaged public var foto: String?
    @NSManaged public var relationshipResponsavelCrianca: NSSet?

}

// MARK: Generated accessors for relationshipResponsavelCrianca
extension Entity {

    @objc(addRelationshipResponsavelCriancaObject:)
    @NSManaged public func addToRelationshipResponsavelCrianca(_ value: Crianca)

    @objc(removeRelationshipResponsavelCriancaObject:)
    @NSManaged public func removeFromRelationshipResponsavelCrianca(_ value: Crianca)

    @objc(addRelationshipResponsavelCrianca:)
    @NSManaged public func addToRelationshipResponsavelCrianca(_ values: NSSet)

    @objc(removeRelationshipResponsavelCrianca:)
    @NSManaged public func removeFromRelationshipResponsavelCrianca(_ values: NSSet)

}
