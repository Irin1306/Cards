//
//  CardListCellTableViewCell.swift
//  Cards
//
//  Created by irina on 21.05.2020.
//  Copyright © 2020 irina. All rights reserved.
//

import UIKit

class CardListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNumber: UILabel!
    
    var item: CardList.DisplayedCard!
    {
        didSet
      {
        cardNumber.text = "\(item.cardNumber)"
        cardImageView.image = item.type == "Visa" ? UIImage(named: "visa") : UIImage(named: "masterCard")
        
      }
    }
    
}
