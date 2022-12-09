//
//  GameViweModel.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/18.
//

import UIKit

extension GameViewController {
	
	// MARK: - Timer
	@objc func timerStart() {
		timeLimit -= 1
		
		timerLabel.text = "Time limit: \(timeLimit)"
		if timeLimit == 0 {
			timerLabel.text = "Time up."
			timer?.invalidate()
			
			//check if user win the game. -- collectionview delegate
			checkForGameEnd()
		}
	}

	// MARK: - Cell Layout
	func cellLayout() {
		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
		flowLayout.itemSize = CGSize(width: 70, height: 70)
		flowLayout.scrollDirection = .vertical
		collectionView.collectionViewLayout = flowLayout
		collectionView.backgroundColor = view.backgroundColor
	}
	
	// MARK: - rank
	func getRank() {
		rank.updateRank()
//		print("rank:\(rank)")
		print(cards)
	}
	
	// MARK: - Score

	func getScore(_ score:Int) {
		scoreLabel.text = String(score)
	}
	
	// MARK: - check match / game end
	func checkForMatch(secondCardIndex: IndexPath) {
		
		let firstCard = cards[firstCardIndex!.row]
		let secondCard = cards[secondCardIndex.row]
		
		let firstCardCell = collectionView.cellForItem(at: firstCardIndex!) as? CardCell
		let secondCardCell = collectionView.cellForItem(at: secondCardIndex) as? CardCell
		
		//compare cards
		if firstCard.imageName == secondCard.imageName {
			
			soundPlayer.playSound(soundName: .correct)
			
			firstCard.isMatched = true
			secondCard.isMatched = true
			
			firstCardCell?.removeCard()
			secondCardCell?.removeCard()
			//
			score += 10
			getScore(score)
			
			checkForGameEnd()
		} else {
			
			soundPlayer.playSound(soundName: .wrong)
			
			firstCard.isFlipped = false
			secondCard.isFlipped = false
			
			firstCardCell?.flipToBack()
			secondCardCell?.flipToBack()
			
			score -= 2
			getScore(score)
		}
		
		// reset firstCardIndex to nil for next match
		self.firstCardIndex = nil
	}
	
	func checkForGameEnd() {
		
		var userWon: Bool = true
		
		for card in cards {
			if !card.isMatched {
				userWon = false
				break
			}
		}
		
		if userWon {
			timerLabel.text = "Congratulations!"
			showAlert(title: "Wow", message: "You Win")
			soundPlayer.stopBGM()
			
			timer?.invalidate()
			score += timeLimit * 5
			getScore(score)
			
			rank.checkRank(score: score)
		} else {
			if timeLimit <= 0 {
				showAlert(title: "Game Over", message: "You can do better")
				soundPlayer.stopBGM()
			}
		}
	}
	
	func showAlert(title: String, message: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let okAction = UIAlertAction(title: "OK", style: .default)
		alert.addAction(okAction)
		present(alert, animated: true, completion: nil)
	}
	
}



