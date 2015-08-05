/***************************************************************
* PROJECT:	Calc Keyboard
* CLASS:	NewsUpdatesViewController.swift
*
* Created by Alan Guilfoyle on 7/27/15.
* Copyright (c) 2015 Think Thrice Tech. All rights reserved.
***************************************************************/

// *** IMPORT(S) ***
import UIKit



/*****************************************************************************
 * CLASS: NewsUpdatesViewController | ADDITIONAL: UIViewController
 * PURPOSE: This class handles the news & update section of the app; It includes
 *	  a Scroll View which detects swipe gestures
 *****************************************************************************/
class NewsUpdatesViewController: UIViewController 
{
	// *** VARIABLE(S) ***
	//Integer(s)
	var pageNumber = 0
	//CGFloat(s)
	var scrollSize: CGFloat = 0
	//UIImageView(s)
	@IBOutlet var imageSize: UIImageView!
	//UIPageControl(s)
	@IBOutlet var pageController: UIPageControl!
	//UIScrollView(s)
	@IBOutlet var holdingNewsScrollView: UIScrollView!
	//UISwipeGestureRecognizer(s)
	var swipeLeft = UISwipeGestureRecognizer()
	var swipeRight = UISwipeGestureRecognizer()
	//UITapGestureRecognizer(s)
	var tapped = UITapGestureRecognizer()
	//UITextView(s)
	@IBOutlet var textViewSize: UITextView!
	
		
	
	/********************************************************************
	 * FUNC: viewDidLoad | PARAMETERS: none | RETURN: void
	 * PURPOSE: Called after the controller's view is loaded into memory.
	 ********************************************************************/
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

	
	
	/********************************************************************
	 * FUNC: didReceiveMemoryWarning | PARAMETERS: none | RETURN: void
	 * PURPOSE: Sent to the view controller when the app receives a memory 
	 *	warning.
	 ********************************************************************/
    override func didReceiveMemoryWarning() 
	{
        super.didReceiveMemoryWarning()

	}
	
	
	
	/********************************************************************
	 * FUNC: swiped | PARAMETERS: UISwipeGestureRecognizer | RETURN: void
	 * PURPOSE: This function is called when a SwipeGesture that is either
	 *	  a left or right swipe; There are only 4 pages to swipe through;
	 ********************************************************************/
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