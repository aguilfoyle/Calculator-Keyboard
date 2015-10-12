/***************************************************************
 *  PROJECT: Calc Keyboard
 *	CLASS: ViewController.swift
 *
 *  Created by Alan Guilfoyle on 7/27/15.
 *  Copyright (c) 2015 Think Thrice Tech. All rights reserved.
 ***************************************************************/

// *** IMPORT(S) ***
import UIKit
//import iAd



/*****************************************************************************
 * CLASS: ViewController | ADDITIONAL: UIViewController, ADBannerViewDelegate
 * PURPOSE: 
 *****************************************************************************/
class ViewController: UIViewController
{
	// *** VARIABLE(S) ***
	//ADBannerView(s)
	//@IBOutlet var adversistment : ADBannerView!
	//UIButton(s)
	@IBOutlet var aboutUsButton		 : UIButton!
	@IBOutlet var newsUpdatesButton	 : UIButton!
	@IBOutlet var instructionsButton : UIButton!
	
	
	
	/********************************************************************
	 * FUNC: viewDidLoad | PARAMETERS: none | RETURN: void
	 * PURPOSE: Called after the controller's view is loaded into memory.
	 ********************************************************************/
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
//		self.canDisplayBannerAds		= true
//		self.adversistment?.delegate	= self
//		self.adversistment?.hidden		= true
		
		self.instructionsButton.layer.borderWidth	= 1
		self.instructionsButton.layer.borderColor	= UIColor.whiteColor().CGColor
		self.instructionsButton.layer.masksToBounds = true

		self.newsUpdatesButton.layer.borderWidth	= 1
		self.newsUpdatesButton.layer.borderColor	= UIColor.whiteColor().CGColor
		self.newsUpdatesButton.layer.masksToBounds	= true

		self.aboutUsButton.layer.borderWidth	= 1
		self.aboutUsButton.layer.borderColor	= UIColor.whiteColor().CGColor
		self.aboutUsButton.layer.masksToBounds	= true
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
}