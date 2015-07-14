//
//  Player.swift
//  deckOfCards
//
//  Created by Brian Berg on 4/3/15.
//  Copyright (c) 2015 berg. All rights reserved.
//

import Foundation

class Player {
  private var hand = [Card]()
	
  var pHand: [Card] {get {return self.hand} set(newValue) {self.hand = newValue}}
	
	init() {
		self.hand = []
	}
	
	func discardCard(indx: Int) {
		self.hand.removeAtIndex(indx)
	}
}