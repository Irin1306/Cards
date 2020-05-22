//
//  CardDetailsPresenter.swift
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

protocol CardDetailsPresentationLogic
{
  func presentCard(response: CardDetails.SelectedCard.Response)
}

class CardDetailsPresenter: CardDetailsPresentationLogic
{
  weak var viewController: CardDetailsDisplayLogic?
  
  // MARK: Do something
  
    func presentCard(response: CardDetails.SelectedCard.Response)
  {
    let displayedCard = formatCard(card: response.card)
    let viewModel = CardDetails.SelectedCard.ViewModel(card: displayedCard)
    viewController?.displayCard(viewModel: viewModel)
  }
    
    // MARK: Format card
    
    private func formatCard(card: Card) -> CardDetails.DisplayedCard
    {
       let start = card.cardNumber.index(card.cardNumber.endIndex, offsetBy: -4)
        let result = card.cardNumber[start..<card.cardNumber.endIndex]
        let number = String(result)
       return CardDetails.DisplayedCard(type: card.type, cardNumber: number)
    }
}