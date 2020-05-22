//
//  Card.swift
//  Cards
//
//  Created by irina on 21.05.2020.
//  Copyright © 2020 irina. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Entity model

class Card: NSObject
{
  // MARK: Attributes
  
  var created: Double
  var type: String
  var cardNumber: String
  
  
  // MARK: Object lifecycle
  
  init(created: Double, type: String, cardNumber: String)
  {
    self.created = created
    self.type = type
    self.cardNumber = cardNumber
  }
  
}

// MARK: - Core Data model

extension CoreDataCard
{
  func toCard() -> Card
  {
    let card = Card(created: created, type: type, cardNumber: cardNumber)
    return card
  }
}
