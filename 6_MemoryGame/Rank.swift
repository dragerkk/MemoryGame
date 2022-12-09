//
//  Rank.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/11.
//

import Foundation

class Rank {

	//singleton
//	static let shared = Rank()
	
	var rank = UserDefaults.standard.array(forKey: "rankArray") as? [Int] ?? [0,0,0,0,0]
	
	func checkRank(score:Int) {
		
		rank.sort()

		if rank[0] < score {
			rank.removeFirst()
			rank.append(score)
		}

		rank.sort()

		updateRank()
	}
	
	func updateRank() {

		UserDefaults.standard.set(rank, forKey: "rankArray")
//		print("updateRank-- \(UserDefaults.standard.array(forKey: "rankArray") ?? ["err"])")
	}
}
