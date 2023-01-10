//
//  ViewController.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/05.
//

import UIKit

class GameViewController: UIViewController {
	
	@IBOutlet weak var collectionView: UICollectionView!
	@IBOutlet weak var timerLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var bgmButton: UIButton!
	
	let cardModel = CardModel()
	var cards: [Card] = []
	
	var timer: Timer?
	var timeLimit: Int = 30

	var firstCardIndex: IndexPath?
	
	var soundPlayer = SoundManager()
	
	var score: Int = 0
	var rank = Rank()
	
	var bgmOn: Bool = true
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("viewDidLoad")
		
		cards = cardModel.getCards()
		bgmButton.setImage(UIImage(systemName: "speaker.fill"), for: .normal)
		
		collectionView.delegate = self
		collectionView.dataSource = self
		
		//Timer 관련
		
		//수정 전
//		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
//		RunLoop.main.add(timer!, forMode: .common)
		// 수정 후
//		timerLabel.text = "Remember!"
//		DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//			self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerStart), userInfo: nil, repeats: true)
//			RunLoop.main.add(self.timer!, forMode: .common)
//		}
		setupTimer()
		
		//score
		getScore(score)
		getRank()
		
		cellLayout()
	}
	
	// MARK: - Setup Timer
	func setupTimer() {
		timerLabel.text = "Remember!"
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerStart), userInfo: nil, repeats: true)
			RunLoop.main.add(self.timer!, forMode: .common)
		}
	}
	
	@IBAction func bgmButtonAction(_ sender: Any) {
		
		if bgmOn {
		soundPlayer.stopBGM()
		bgmButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
			bgmOn = false
		} else {
			soundPlayer.playSound(soundName: .bgm)
			bgmButton.setImage(UIImage(systemName: "speaker.fill"), for: .normal)
			bgmOn = true
		}
	}
	
	
	// MARK: - play BGM
	override func viewDidAppear(_ animated: Bool) {
		soundPlayer.playSound(soundName: .bgm)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		soundPlayer.stopBGM()
	}
	
	// MARK: - Restart Game
	@IBAction func restartButtonTapped(_ sender: UIButton) {
		
		timer?.invalidate()
	
		setupTimer()
		
		//수정전
//		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
//		RunLoop.main.add(timer!, forMode: .common)
		soundPlayer.stopBGM()
		soundPlayer.playSound(soundName: .bgm)
		
		timeLimit = 30
		score = 0
		cards = cardModel.getCards()
		cellLayout()
		getScore(score)
		
		collectionView.reloadData()
	}
}
