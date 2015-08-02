/***************************************************************
* PROJECT:	Calc Keyboard
* CLASS:	NewsUpdatesViewController.swift
*
* Created by Alan Guilfoyle on 7/27/15.
* Copyright (c) 2015 Think Thrice Tech. All rights reserved.
***************************************************************/

import UIKit

class NewsUpdatesViewController: UIViewController 
{
	@IBOutlet var holdingNewsScrollView: UIScrollView!
	@IBOutlet var imageSize: UIImageView!
	@IBOutlet var textViewSize: UITextView!
	@IBOutlet var pageController: UIPageControl!

	var swipeLeft = UISwipeGestureRecognizer()
	var swipeRight = UISwipeGestureRecognizer()
	
	var tapped = UITapGestureRecognizer()
	
	var pageNumber = 0
	var scrollSize: CGFloat = 0
	
    override func viewDidLoad() 
	{
        super.viewDidLoad()
		
		self.swipeRight.addTarget( self, action: Selector("swiped:"))
		self.swipeLeft.addTarget( self, action: Selector("swiped:"))
		self.tapped.addTarget( self, action: Selector("tappedView"))
		
		self.swipeRight.direction = UISwipeGestureRecognizerDirection.Right
		self.swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
		self.tapped.numberOfTapsRequired = 1
		
		self.holdingNewsScrollView.addGestureRecognizer( self.swipeRight )
		self.holdingNewsScrollView.addGestureRecognizer( self.swipeLeft )
		self.holdingNewsScrollView.addGestureRecognizer( self.tapped )
	}

    override func didReceiveMemoryWarning() 
	{
        super.didReceiveMemoryWarning()

	}
	
	
	func swiped( gesture: UISwipeGestureRecognizer )
	{
		if gesture.direction == UISwipeGestureRecognizerDirection.Left
		{
			if pageNumber != 3
			{
				self.pageNumber++
				self.pageController.currentPage = pageNumber
				self.scrollSize = self.textViewSize.layer.bounds.width + self.scrollSize
				
				self.holdingNewsScrollView.setContentOffset( CGPoint(x: self.scrollSize, y: 0 ), animated: true )
			}
		}
		else
		{
			if pageNumber != 0
			{
				pageNumber--
				self.pageController.currentPage = pageNumber
				self.scrollSize = self.scrollSize - self.textViewSize.layer.bounds.width
				if self.scrollSize <= 0
				{
					self.scrollSize = self.scrollSize * -1
				}
				self.holdingNewsScrollView.setContentOffset( CGPoint(x: self.scrollSize, y: 0 ), animated: true )
			}
			else if pageNumber == 0
			{				
				self.scrollSize = self.textViewSize.layer.bounds.width - self.scrollSize
				
				self.holdingNewsScrollView.setContentOffset( CGPoint(x: 0, y: 0 ), animated: true )
			}
		}
		
	}
}