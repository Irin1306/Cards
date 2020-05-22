//
//  CoreDataCard+CoreDataProperties.swift
//  Cards
//
//  Created by irina on 21.05.2020.
//  Copyright © 2020 irina. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreDataCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataCard> {
        return NSFetchRequest<CoreDataCard>(entityName: "CoreDataCard")
    }

    @NSManaged public var type: String
    @NSManaged public var cardNumber: String
    @NSManaged public var created: Double

}
