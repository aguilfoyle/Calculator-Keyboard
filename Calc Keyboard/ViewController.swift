/***************************************************************
 *  PROJECT: Calc Keyboard
 *	CLASS: ViewController.swift
 *
 *  Created by Alan Guilfoyle on 7/27/15.
 *  Copyright (c) 2015 Think Thrice Tech. All rights reserved.
 ***************************************************************/

// *** IMPORT(S) ***
import UIKit
import iAd



/*****************************************************************************
 * CLASS: ViewController | ADDITIONAL: UIViewController, ADBannerViewDelegate
 * PURPOSE: 
 *****************************************************************************/
class ViewController: UIViewController, ADBannerViewDelegate
{
	// *** VARIABLE(S) ***
	//ADBannerView(s)
	@IBOutlet var adversistment : ADBannerView!
	//UIButton(s)
	@IBOutlet var aboutUsButton		 : UIButton!
	@IBOutlet var newsUpdatesButton	 : UIButton!
	@IBOutlet var instructionsButton : UIButton!
	
	
	
	/********************************************************************
	 * METHOD: viewDidLoad | PARAMETERS: none | RETURN: void
	 * PURPOSE: Called after the controller's view is loaded into memory.
	 ********************************************************************/
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.canDisplayBannerAds		= true
		self.adversistment?.delegate	= self
		self.adversistment?.hidden		= true
		
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
	 * METHOD: didReceiveMemoryWarning | PARAMETERS: none | RETURN: void
	 * PURPOSE: Sent to the view controller when the app receives a memory 
	 *	warning.
	 ********************************************************************/
	override func didReceiveMemoryWarning() 
	{
		super.didReceiveMemoryWarning()

	}

	
	
	/********************************************************************
	 * METHOD: viewDidAppear | PARAMETERS: Bool | RETURN: void
	 * PURPOSE: Notifies the view controller that its view was added to a 
	 *	view hierarchy. If True, the view was added to the window using an 
	 *	animation.
	 ********************************************************************/
	override func viewDidAppear( animated: Bool ) 
	{
		
	}
	
	override func prepareForSegue( segue: UIStoryboardSegue, sender: AnyObject? ) 
	{
		let destination = segue.destinationViewController as! UIViewController
		
		destination.interstitialPresentationPolicy = 
			ADInterstitialPresentationPolicy.Automatic
	}
	
	func bannerViewWillLoadAd( banner: ADBannerView! ) 
	{

	}
	
	func bannerViewDidLoadAd( banner: ADBannerView! ) 
	{
		self.adversistment?.hidden = false
	}
	
	func bannerViewActionDidFinish( banner: ADBannerView! ) 
	{		
		//optional resume paused game code
		
	}
	
	func bannerView( banner: ADBannerView!, didFailToReceiveAdWithError error: NSError! ) 
	{
		self.adversistment?.hidden = true
		
	}
	
	func bannerViewActionShouldBegin( banner: ADBannerView!, willLeaveApplication willLeave: Bool ) -> Bool 
	{		
		//optional pause game code
		
		return willLeave
	}

}

