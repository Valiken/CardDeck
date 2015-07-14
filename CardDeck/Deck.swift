//
//  Deck.swift
//  deckOfCards
//
//  Created by Brian Berg on 3/23/15.
//  Copyright (c) 2015 berg. All rights reserved.
//
import Foundation

class Deck {
	
	//let sharedInstance = Deck()
	
	private var deck = [Card]()
  private var suits = ["spades", "hearts", "clubs", "diamonds"]
  private var ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
	private var discards = [Card]()
	
	var pDeck: [Card] {get {return self.deck}}
	var pDiscards: [Card] {get {return self.discards}}
	
  init() {
    for suit in suits {
      for rank in ranks {
				deck.append(Card(suit: suit, rank: rank))
      }
    }
  }
	
	func shuffleDeck() {
		self.deck = sorted(self.deck) {_, _ in arc4random_uniform(UInt32(self.deck.count-1)) % 2 == 0} //_ is in place of a variable name
	}
  
  func cutDeck() {
    var cutDeck = self.deck
		
    var count = self.deck.count - 1
    let cardCut = Int(arc4random_uniform(UInt32(count)))
    var cutCards: Array<Card> = Array(cutDeck[cardCut...count])
    
    let range = Range(start: cardCut, end: self.deck.count)
    cutDeck.removeRange(range)
    
    cutDeck.splice(cutCards, atIndex: 0)
    
    self.deck = cutDeck
	}
	
	func dealCard() {
		self.deck.removeAtIndex(0)
	}
	
	func cardDiscarded(card: Card) {
		self.discards.append(card)
	}
}
