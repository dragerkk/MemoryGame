//
//  CardCell.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/08.
//

import UIKit

class CardCell: UICollectionViewCell {
    
	@IBOutlet weak var frontImageView: UIImageView!
	@IBOutlet weak var backImageView: UIImageView!
	
	var card: Card?
	
	// 카드 setup 수정후
	func setupCell(card: Card) {
		self.card = card
		frontImageView.image = UIImage(named: card.imageName)
		
		frontImageView.isHidden = false
		backImageView.isHidden = true

		// 카드 3초동안 보여준 후 뒤집기
		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
			self.flipToBack()
		}
	}
	
	// 카드 setup 원래버전
//	func setupCell(card: Card) {
//		self.card = card
//
//		frontImageView.image = UIImage(named: card.imageName)
//
//		//reset cell's state
//		if card.isMatched == true {
//			backImageView.isHidden = true
//			frontImageView.isHidden = true
//			return
//		} else {
//			backImageView.isHidden = false
//			frontImageView.isHidden = false
//		}
//
//		if card.isFlipped == true {
//			flipToFront()
//		} else {
//			flipToBack()
//		}
//
//	}
	
	func flipToFront(speed: TimeInterval = 0.3) {
		UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
		
		card?.isFlipped = true
	}
	
	func flipToBack(speed: TimeInterval = 0.3, delay: TimeInterval = 0.5) {
		//시간차 두기
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
			UIView.transition(from: self.frontImageView, to: self.backImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
		}
		
		card?.isFlipped = false
	}
	
	func removeCard() {
		backImageView.isHidden = true
		
		UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
			self.frontImageView.isHidden = true
		}, completion: nil)
	}
	
}
