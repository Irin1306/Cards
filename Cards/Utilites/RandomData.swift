//
//  RandomData.swift
//  Cards
//
//  Created by irina on 22.05.2020.
//  Copyright © 2020 irina. All rights reserved.
//

import Foundation

final class RandomData {
    static func generateCreditCardNumber(for type: CreditCardType) -> String{
        /* Obtain proper card length */
        let cardLength = 16
        
        var cardNumber = [Int](repeating: 0, count: cardLength)
        var startingIndex = 0
        
        /* Conform to rules for beginning card numbers */
        if type == .Visa {
            cardNumber[0] = 4
            startingIndex = 1
        }
        else if type == .MasterCard {
            cardNumber[0] = 5
            cardNumber[1] = Int(arc4random_uniform(5) + 1)
            startingIndex = 2
        }
         /* Fill array with random numbers 0-9 */
        for i in startingIndex..<cardNumber.count{
            cardNumber[i] = Int(arc4random_uniform(10))
        }
        /* Calculate the final digit using a custom variation of Luhn's formula
           This way we dont have to spend time reversing the array
         */
        let offset = (cardNumber.count+1)%2
        var sum = 0
        for i in 0..<cardNumber.count-1 {
            if ((i+offset) % 2) == 1 {
                var temp = cardNumber[i] * 2
                if temp > 9{
                    temp -= 9
                }
                sum += temp
            }
            else{
                sum += cardNumber[i]
            }
        }
        let finalDigit = (10 - (sum % 10)) % 10
        cardNumber[cardNumber.count-1] = finalDigit
        //Convert cardnumber array to string
        return cardNumber.map({ String($0) }).joined(separator: "")
    }
}
