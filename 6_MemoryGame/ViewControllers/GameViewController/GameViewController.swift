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
	
	let model = CardModel()
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
		
		cards = model.getCards()
		bgmButton.setImage(UIImage(systemName: "speaker.fill"), for: .normal)
		
		collectionView.delegate = self
		collectionView.dataSource = self
		
		//timer
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
		RunLoop.main.add(timer!, forMode: .common)
		
		//score
		getScore(score)
		getRank()
		
		cellLayout()
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
		timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerStart), userInfo: nil, repeats: true)
		RunLoop.main.add(timer!, forMode: .common)
		soundPlayer.stopBGM()
		soundPlayer.playSound(soundName: .bgm)
		
		timeLimit = 30
		score = 0
		cards = model.getCards()
		cellLayout()
		getScore(score)
//		print("restart")
		
		collectionView.reloadData()
		
	}
}
