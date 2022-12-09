//
//  GameCollectionViewLayout.swift
//  6_MemoryGame
//
//  Created by 강주원 on 2022/07/08.
//

import UIKit

class GameCollectionViewLayout: UICollectionViewFlowLayout {

	var level: Int? {
		didSet {
			prepare()
		}
	}
	
	override func prepare() {
		super.prepare()
		
		guard let selectedLevel = level else { return }
		guard let frame = collectionView?.frame else { return }
		guard frame != .zero else { return }
		
		var isColumnDivide: Bool
		var insetHorizontal: CGFloat = 0
		var insetVertical: CGFloat = 0
		let width: CGFloat
		let height: CGFloat
		
		let row = Card.numberOfRows(level: selectedLevel)
		let column = Card.numberOfColumns(level: selectedLevel)
		
		isColumnDivide = (frame.size.width / CGFloat(column)) < (frame.size.height / CGFloat(row))
		
		if isColumnDivide {
			width = frame.size.width / CGFloat(column)
			height = frame.size.width / CGFloat(column)
			insetVertical = frame.size.height - (height * CGFloat(row))
		} else {
			width = frame.size.height / CGFloat(row)
			height = frame.size.height / CGFloat(row)
			insetHorizontal = frame.size.width - (width * CGFloat(column))
		}
		
		itemSize = CGSize(width: width, height: height)
		minimumInteritemSpacing = 0
		minimumLineSpacing = 0
		
		sectionInset = UIEdgeInsets(top: insetVertical * 0.5, left: insetHorizontal * 0.5, bottom: insetVertical * 0.5, right: insetHorizontal * 0.5)
	}
	
}
