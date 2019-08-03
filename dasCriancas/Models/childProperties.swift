//
//  childProperties.swift
//  dasCriancas
//
//  Created by Cassia Aparecida Barbosa on 22/07/19.
//  Copyright © 2019 Cassia Aparecida Barbosa. All rights reserved.
//

import Foundation
import CoreData

extension Child {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Child> {
        return NSFetchRequest<Child>(entityName: "Child")
    
    }
    
}
