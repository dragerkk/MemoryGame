//
//  SoundManage.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/09.
//

import Foundation
import AVFoundation

class SoundManager {
	
	enum SoundEffect {
		case bgm
		case flip
		case wrong
		case correct
	}
	
	var players = [URL:AVAudioPlayer]()
	var duplicatePlayers = [AVAudioPlayer]()
	
	func playSound(soundName: SoundEffect) {
		var soundFileName = ""
		
		switch soundName {
		case .bgm:
			soundFileName = "bgm"
		case .flip:
			soundFileName = "flip"
		case .wrong:
			soundFileName = "wrong"
		case .correct:
			soundFileName = "correct"
		}
		
		let soundFileNameURL = URL(fileURLWithPath: Bundle.main.path(forResource: soundFileName, ofType: ".wav")!)
		
		if let player = players[soundFileNameURL] { // player has been found
			if player.isPlaying == false { // player is not in use
				player.play()
			} else { // player is using, create a duplicate player and use it.
				let duplicatePlayer = try! AVAudioPlayer(contentsOf: soundFileNameURL)
				duplicatePlayers.append(duplicatePlayer)
				duplicatePlayer.play()
			}
		} else { // player do not exist, create a new player if possible
			do {
				let player = try AVAudioPlayer(contentsOf: soundFileNameURL)
				players[soundFileNameURL] = player
				
				if soundFileName == "bgm" {
					player.numberOfLoops = -1 // for infinite times.
					player.play()
				} else {
					player.play()
				}
			} catch {
				print("Could not play sound file")
			}
		}
	}

	func stopBGM() {
		players.removeAll()
	}
	
}
