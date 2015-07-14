//
//  PlayerController.swift
//  CardDeck
//
//  Created by Brian Berg on 4/13/15.
//  Copyright (c) 2015 bnberg. All rights reserved.
//

import UIKit

class PlayerController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	let d = Deck()
	var deck = Deck().pDeck
	
	let p = Player()
	var hand = Player().pHand
	
	var navBar: UINavigationBar = UINavigationBar()
	var navItem: UINavigationItem = UINavigationItem()
	var leftButton: UIBarButtonItem = UIBarButtonItem()
	var rightButton: UIBarButtonItem = UIBarButtonItem()
	
	var tableView: UITableView = UITableView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		tableView.frame = CGRectMake(0, 65, self.view.frame.size.width, 553);
		tableView.delegate = self
		tableView.dataSource = self
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "HandCell")
		
		self.view.addSubview(tableView)
		
		displayHand()
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
		
		displayHand()
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
		
		displayHand()
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.hand.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("HandCell", forIndexPath: indexPath) as! UITableViewCell
		
		var imageName = UIImage(named: self.hand[indexPath.row].pSuit)
		cell.imageView?.image = imageName
		
		var cardFace = ""
		if self.hand[indexPath.row].pRank <= 10
		{
			cardFace = String(self.hand[indexPath.row].pRank)
		}
		else
		{
			switch self.hand[indexPath.row].pRank
			{
			case 11: cardFace = "J"
			case 12: cardFace = "Q"
			case 13: cardFace = "K"
			case 14: cardFace = "A"
			default: println("Something has gone wrong"); cardFace = String(self.hand[indexPath.row].pRank)
			}
		}
		cell.textLabel?.text = cardFace
		
		return cell
	}
	
	func displayHand() {
		self.tableView.reloadData()
	}
	
	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
		println("You selected the \(self.hand[indexPath.row].pRank) of \(self.hand[indexPath.row].pSuit)!")
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
