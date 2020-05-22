//
//  CardListRouter.swift
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

@objc protocol CardListRoutingLogic
{
  func routeToCardDetails(segue: UIStoryboardSegue?)
}

protocol CardListDataPassing
{
  var dataStore: CardListDataStore? { get }
}

class CardListRouter: NSObject, CardListRoutingLogic, CardListDataPassing
{
  weak var viewController: CardListViewController?
  var dataStore: CardListDataStore?
  
  // MARK: Routing
  
  func routeToCardDetails(segue: UIStoryboardSegue?) {
    if let segue = segue {
      let destinationVC = segue.destination as! CardDetailsViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToCardDetails(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "CardDetailsViewController") as! CardDetailsViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToCardDetails(source: dataStore!, destination: &destinationDS)
      navigateToCardDetails(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToCardDetails(source: CardListViewController, destination: CardDetailsViewController) {
    source.show(destination, sender: nil)
 
  }
  
  // MARK: Passing data
  
  func passDataToCardDetails(source: CardListDataStore, destination: inout CardDetailsDataStore) {
    let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
     let selectedCard = source.cards[selectedRow!]
     destination.card = selectedCard
     
  }
    
}
