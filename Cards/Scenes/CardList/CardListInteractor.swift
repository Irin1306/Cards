//
//  CardListInteractor.swift
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

protocol CardListBusinessLogic
{
    var cards: [Card] { get set }
    func fetchCards(request: CardList.FetchCards.Request)
    func createCard(request: CardList.CreateCard.Request)
}

protocol CardListDataStore {
  var cards: [Card] { get }
    
}

class CardListInteractor: CardListBusinessLogic, CardListDataStore {
   
  var presenter: CardListPresentationLogic?
  var worker = CardListWorker()
  var cards: [Card] = []
   
   // MARK: Fetch cards
   
   func fetchCards(request: CardList.FetchCards.Request)
   {
     worker.fetchCards { (cards: () throws -> [Card]) in
       do {
          
         let fetchedCards = try cards()
         self.cards = fetchedCards.sorted(by: {$0.created > $1.created})
         let response = CardList.FetchCards.Response(cards: self.cards)
         self.presenter?.presentFetchedCards(response: response)
       } catch {}
     }
   }
   
   // MARK: Create card
   
   func createCard(request: CardList.CreateCard.Request)
   {
    let card = Card(created: request.created, type: request.type, cardNumber: request.cardNumber)
    worker.createCard(cardToCreate: card, completionHandler: { (card: Card?) in
        guard let card = card else { return }
        self.cards.append(card)
        let fetchedCards:[Card] = self.cards
        self.cards = fetchedCards.sorted(by: {$0.created > $1.created})
        
        let response = CardList.CreateCard.Response(cards: self.cards)
        self.presenter?.presentAfterCreatCard(response: response)
     })
    }
    
}
