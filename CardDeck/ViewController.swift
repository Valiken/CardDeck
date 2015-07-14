//
//  ViewController.swift
//  deckOfCards
//
//  Created by Brian Berg on 3/16/15.
//  Copyright (c) 2015 berg. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	let d = Deck()
	var deck = Deck().pDeck
	
	let p = Player()

	var navBar: UINavigationBar = UINavigationBar()
	var navItem: UINavigationItem = UINavigationItem()
	var leftButton: UIBarButtonItem = UIBarButtonItem()
	var rightButton: UIBarButtonItem = UIBarButtonItem()

	var tableView: UITableView = UITableView()
	
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
		
		navBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 65)
		
		navItem.title = "Card Deck"
		
		leftButton.title = "Shuffle"
		leftButton.style = UIBarButtonItemStyle.Plain
		leftButton.target = self
		leftButton.action = Selector("shuffleButtonPressed")
		navItem.setLeftBarButtonItem(leftButton, animated: false)
		
		rightButton.title = "Cut"
		rightButton.style = UIBarButtonItemStyle.Plain
		rightButton.target = self
		rightButton.action = Selector("cutButtonPressed")
		navItem.setRightBarButtonItem(rightButton, animated: false)
		
		navBar.items = [navItem]

		self.view.addSubview(navBar)
		
		tableView.frame = CGRectMake(0, 65, self.view.frame.size.width, 560);
    tableView.delegate = self
    tableView.dataSource = self
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CardCell")
		
    self.view.addSubview(tableView)
		
		var toolBarItems = NSMutableArray()
		
		var drawButton = UIBarButtonItem(title: "Draw", style: UIBarButtonItemStyle.Plain, target: self, action: "drawCardButtonPressed")
		toolBarItems.addObject(drawButton)
		
		//var discardButton = UIBarButtonItem(title: "Discard", style: UIBarButtonItemStyle.Plain, target: self, action: "discardCardButtonPressed")
		//toolBarItems.addObject(discardButton)
		
		self.navigationController?.toolbarHidden = false
		self.setToolbarItems(toolBarItems, animated: false)
		
		displayCards()
  }

	func shuffleButtonPressed() {
		d.shuffleDeck()
		deck = d.pDeck
		displayCards()
	}
	
	func cutButtonPressed() {
	  d.cutDeck()
		deck = d.pDeck
		displayCards()
	}
	
	func drawCardButtonPressed() {
		let alert = UIAlertView()
		alert.title = "Sorry"
		alert.message = "Your hand is already full!"
		alert.addButtonWithTitle("Close")
		
		var cardDealt = deck[0]
		
		if p.pHand.count < 5 {
			p.pHand.append(cardDealt)
			d.dealCard()
			deck = d.pDeck
		}
		else
		{
			alert.show()
		}
		
		displayCards()
	}
	
	func discardCardButtonPressed() {
		let alert = UIAlertView()
		alert.title = "Sorry"
		alert.message = "Your hand is empty!"
		alert.addButtonWithTitle("Close")
		
		if p.pHand.count != 0 {
			d.cardDiscarded(p.pHand[0])
		}
		else
		{
			alert.show()
		}
		
		displayCards()
	}
	
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.deck.count
  }
	
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("CardCell", forIndexPath: indexPath) as UITableViewCell
    
    var imageName = UIImage(named: self.deck[indexPath.row].pSuit)
    cell.imageView?.image = imageName
    
    var cardFace = ""
    if self.deck[indexPath.row].pRank <= 10
    {
      cardFace = String(self.deck[indexPath.row].pRank)
    }
    else
    {
      switch self.deck[indexPath.row].pRank
      {
      case 11: cardFace = "J"
      case 12: cardFace = "Q"
      case 13: cardFace = "K"
      case 14: cardFace = "A"
			default: println("Something has gone wrong"); cardFace = String(self.deck[indexPath.row].pRank)
      }
    }
    cell.textLabel?.text = cardFace
		
		return cell
  }
	
	func displayCards() {
		self.tableView.reloadData()
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    println("You selected the \(self.deck[indexPath.row].pRank) of \(self.deck[indexPath.row].pSuit)!")
  }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

