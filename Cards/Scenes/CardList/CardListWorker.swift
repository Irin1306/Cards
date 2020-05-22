//
//  CardListWorker.swift
//  Cards
//
//  Created by irina on 21.05.2020.
//  Copyright (c) 2020 irina. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class CardListWorker
{
 
  func fetchCards(completionHandler: @escaping (() throws -> [Card]) -> Void) {
    
    CoreDataStore.fetchList(CoreDataCard.self, completionHandler: { (coreDataCards: () throws -> [CoreDataCard]) in
      do {
        let coreDataCards = try coreDataCards()
        let cards = coreDataCards.map { $0.toCard() }
        completionHandler { return cards}
      } catch {}
    })
  }
  
//  func fetchCustomer(id: String, completionHandler: @escaping (() throws -> Customer?) -> Void)
//  {
//    customerDataStore.fetchCustomer(id: id) { (managedCustomer: () throws -> ManagedCustomer?) in
//      do {
//        let managedCustomer = try managedCustomer()
//        if let customer = managedCustomer?.toCustomer() {
//          completionHandler { return customer }
//        } else {
//          throw CoreDataStoreError.CannotFetch("Cannot fetch customer with id \(id)")
//        }
//      } catch {}
//    }
//  }
  
    func createCard(cardToCreate: Card, completionHandler: @escaping (Card?) -> Void) {
        
        let newCard = CoreDataCard(context: CoreDataStore.context)
        newCard.type = cardToCreate.type
        newCard.created = cardToCreate.created
        newCard.cardNumber = cardToCreate.cardNumber
        
        CoreDataStore.saveContext { (succes: Bool) in
            if succes {
               completionHandler (cardToCreate)
            }
        }
    }
   
}


 
