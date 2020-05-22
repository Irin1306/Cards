//
//  CardListViewController.swift
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

protocol CardListDisplayLogic: class
{
  func displayFetchedCards(viewModel: CardList.FetchCards.ViewModel)
  func displayAfterCreateCard(viewModel: CardList.CreateCard.ViewModel)
}

class CardListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CardListDisplayLogic
{
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: CardListBusinessLogic?
    var router: (NSObjectProtocol & CardListRoutingLogic & CardListDataPassing)?
    var displayedCards: [CardList.DisplayedCard] = []

  // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = CardListInteractor()
        let presenter = CardListPresenter()
        let router = CardListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
     }
    
    private func registerTableViewCells() {
        let itemCellNib = UINib(nibName: "CardListCellTableViewCell", bundle: nil)
        tableView.register(itemCellNib, forCellReuseIdentifier: "CardListCellTableViewCell")
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
          let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
          if let router = router, router.responds(to: selector) {
            router.perform(selector, with: segue)
          }
        }
     }
  
     // MARK: View lifecycle
  
     override func viewDidLoad() {
         super.viewDidLoad()
         registerTableViewCells()
         fetchCards()
     
     }
    
     override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          if let selectionIndexPath = self.tableView.indexPathForSelectedRow {
              self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
      }
   }
   
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCards.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardListCellTableViewCell", for: indexPath as IndexPath) as! CardListCellTableViewCell
          cell.item = displayedCards[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         router?.routeToCardDetails(segue: nil)
    }
    
    // MARK: Fetch cards
  
    func fetchCards() {
        let request = CardList.FetchCards.Request()
        interactor?.fetchCards(request: request)
    }
  
    func displayFetchedCards(viewModel: CardList.FetchCards.ViewModel) {
        displayedCards = viewModel.displayedCards
        tableView.reloadData()
    }
  
    //@IBOutlet weak var nameTextField: UITextField!
    @IBAction func onAddAction(_ sender: Any) {
         let timeStamp = Date().timeIntervalSinceReferenceDate
         let randomCard = CreditCardType.allCases.randomElement()!
         var cardType = ""
         var cardNumber = ""
          
         switch randomCard {
         case .MasterCard:
            cardType = "MasterCard"
            cardNumber = RandomData.generateCreditCardNumber(for: .MasterCard)
          case _ :
            cardType = "Visa"
            cardNumber = RandomData.generateCreditCardNumber(for: .Visa)
         }
        
         let request = CardList.CreateCard.Request(created: timeStamp, type: cardType, cardNumber: cardNumber)
         interactor?.createCard(request: request)
      }
    
      func displayAfterCreateCard(viewModel: CardList.CreateCard.ViewModel) {
          displayedCards = viewModel.displayedCards
          tableView.reloadData()
      }
 
}
 
enum CreditCardType: CaseIterable {
    case Visa
    case MasterCard
}
 



 
