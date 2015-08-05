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
	 * FUNC: viewDidLoad | PARAMETERS: none | RETURN: void
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
	 * FUNC: didReceiveMemoryWarning | PARAMETERS: none | RETURN: void
	 * PURPOSE: Sent to the view controller when the app receives a memory 
	 *	warning.
	 ********************************************************************/
	override func didReceiveMemoryWarning() 
	{
		super.didReceiveMemoryWarning()

	}
	
	
	
	/*********************************************************************************
	* FUNC: prepareForSegue | PARAMETERS: UIStoryboardSegue, AnyObject | RETURN: void
	* PURPOSE: Notifies the view controller that a segue is about to be performed.
	**********************************************************************************/
	override func prepareForSegue( segue: UIStoryboardSegue, sender: AnyObject? ) 
	{
		let destination = segue.destinationViewController as! UIViewController
		
		destination.interstitialPresentationPolicy = ADInterstitialPresentationPolicy.Automatic
	}
	
	
	
	/**********************************************************************
	 * FUNC: bannerViewDidLoadAd | PARAMETERS: ADBannerView | RETURN: void
	 * PURPOSE: Called when a new banner advertisement is loaded.
	 ***********************************************************************/
	func bannerViewDidLoadAd( banner: ADBannerView! ) 
	{
		self.adversistment?.hidden = false
	}
	
	
	
	/****************************************************************************
	 * FUNC: bannerViewActionDidFinish | PARAMETERS: ADBannerView | RETURN: void
	 * PURPOSE: Called after a banner view finishes executing an action that covered 
	 *	  your application’s user interface.
	 *****************************************************************************/
	func bannerViewActionDidFinish( banner: ADBannerView! ) 
	{		
		//optional resume paused game code
		
	}
	
	
	
	/***********************************************************************
	 * FUNC: bannerView | PARAMETERS: ADBannerView, NSError | RETURN: void
	 * PURPOSE: Called when a banner view fails to load a new advertisement.
	 ***********************************************************************/
	func bannerView( banner: ADBannerView!, didFailToReceiveAdWithError error: NSError! ) 
	{
		self.adversistment?.hidden = true
	}
	
	
	
	/***********************************************************************************
	 * FUNC: bannerViewActionShouldBegin | PARAMETERS: ADBannerView, Bool | RETURN: Bool
	 * PURPOSE: Called before a banner view executes an action.
	 ************************************************************************************/
	func bannerViewActionShouldBegin( banner: ADBannerView!, willLeaveApplication willLeave: Bool ) -> Bool 
	{		
		//optional pause game code
		
		return willLeave
	}
}