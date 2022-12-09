//
//  GameViewController+CollectionView.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/16.
//

import UIKit



// MARK: - collectionView Delegate

extension GameViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		if timeLimit <= 0 {
			return
		}
		
		guard let cell = collectionView.cellForItem(at: indexPath) as? CardCell else {
			return
		}
		
		// card flip
		if cell.card?.isFlipped == false && cell.card?.isMatched == false {
			cell.flipToFront()
			
			soundPlayer.playSound(soundName: .flip)
			
			if firstCardIndex == nil {
				firstCardIndex = indexPath
			} else {
				checkForMatch(secondCardIndex: indexPath)
			}
		}
		
	}
	
	
}


// MARK: - collectionView Datasource
extension GameViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return cards.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as? CardCell else {
			return UICollectionViewCell()
		}
		
		let card = cards[indexPath.row]
		cell.setupCell(card: card)
		
		return cell
	}
	
}


