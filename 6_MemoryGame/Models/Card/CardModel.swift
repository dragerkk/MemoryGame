//
//  CardModel.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/08.
//

import Foundation

class CardModel {
	
	func getCards() -> [Card] {
		
		var generatedCards: [Card] = []
		var selectedCards: [Int] = []
		
		// generate random cards
		while selectedCards.count < 8 {
			
			let randomNumber = Int.random(in: 1...8)
			
			if selectedCards.contains(randomNumber) {
				continue
			} else {
				selectedCards += [randomNumber]
			}
			
			let firstCard = Card()
			let secondCard = Card()
			
			firstCard.imageName = "\(randomNumber)"
			secondCard.imageName = "\(randomNumber)"
			
			generatedCards += [firstCard, secondCard]
			
		}
//		print(selectedCards)
//		for i in generatedCards {
//			print(i.imageName)
//		}
		return generatedCards.shuffled()
	}
}
