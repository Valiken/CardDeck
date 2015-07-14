//
//  Card.swift
//  deckOfCards
//
//  Created by Brian Berg on 3/23/15.
//  Copyright (c) 2015 berg. All rights reserved.
//

class Card {
  private var suit: String
  private var rank: Int
  
  var pSuit: String {get {return self.suit}}
  var pRank: Int {get {return self.rank}}
  
  init(suit: String, rank: Int) {
    self.suit = suit
    self.rank = rank
  }
}
