//
//  RankViewController.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/12.
//

import UIKit
import simd

class RankViewController: UIViewController {
//class RankViewController: BaseViewController {

	@IBOutlet weak var label1: UILabel!
	@IBOutlet weak var label2: UILabel!
	@IBOutlet weak var label3: UILabel!
	@IBOutlet weak var label4: UILabel!
	@IBOutlet weak var label5: UILabel!
	
	let ranking = Rank()
	lazy var rank = ranking.rank
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		setLabels(label: label1, seconds: 5, prefix: "1st", index: 4)
		setLabels(label: label2, seconds: 4, prefix: "2nd", index: 3)
		setLabels(label: label3, seconds: 3, prefix: "3rd", index: 2)
		setLabels(label: label4, seconds: 2, prefix: "4th", index: 1)
		setLabels(label: label5, seconds: 1, prefix: "5th", index: 0)
	}

	func setLabels(label:UILabel, seconds:TimeInterval, prefix:String, index:Int) {
		DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
			UIView.transition(with: label, duration: 1, options: .transitionFlipFromRight, animations: {
				label.text = "\(prefix) : \(String(self.rank[index]))"
			}, completion: nil)
		}
	}
}
