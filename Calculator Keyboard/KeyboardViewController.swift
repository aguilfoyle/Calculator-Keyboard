//
//  KeyboardViewController.swift
//  Calculator Keyboard
//
//  Created by Alan Guilfoyle on 7/27/15.
//  Copyright (c) 2015 Think Thrice Tech. All rights reserved.
//

import Darwin
import UIKit
import Swift


class Label: UILabel 
{
	override func drawTextInRect(rect: CGRect) 
	{
		super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)))
	}
}


/**************************************************************
* Addition
**************************************************************/
func addition( a: Double, b: Double ) -> Double 
{
	var result = a + b
	
	return result
}

/**************************************************************
* Addition
**************************************************************/
func subtract(a: Double, b: Double) -> Double 
{
	var result = a - b
	
	return result
}

/**************************************************************
* Addition
**************************************************************/
func multiply(a: Double, b: Double) -> Double 
{
	var result = a * b
	
	return result
}

/**************************************************************
* Addition
**************************************************************/
func divide( a: Double, b: Double ) -> Double 
{	
	if b == 0 || b == 0.0
	{
		var result = 0.123332101
		
		return result
	}
	else
	{
		var result = a / b
		
		return result
	}
}

/**************************************************************
* Addition
**************************************************************/
func reciprocal( a: Double, b: Double ) -> Double
{
	if a == 0 || a == 0.0
	{
		var result = 0.123332101
		
		return result
	}
	else
	{
		var result = 1 / a
		
		return result
	}
}

/**************************************************************
* Percentage
**************************************************************/
func percentage( a: Double, b: Double ) -> Double
{
	var result = a / 100 
	
	return result
}

typealias holdsValues = ( Double, Double ) -> Double
let theOperators: [String: holdsValues] = [ "+" : addition, "-" : subtract, "*" : multiply, "/" : divide, "/?" : reciprocal, "%" : percentage ]



/***********************************************************************
* CLASS: KeyboardViewController | CALLS: UIInputViewController
* PURPOSE: 
***********************************************************************/
class KeyboardViewController: UIInputViewController
{
	// *** VARIABLE(S) ***
	//Boolean(s)
	var textInput = true
	var oneOverXPressed = false
	var operatorsClicked = true
	//Integer(s)
	var counter = 0
	//Double(s)
	var pi: Double = 3.14159265358979
	var accumulator: Double = 0.0
	//Array(s) / Stack(s)
	var numberStack: [Double] = []
	var operatorStack: [String] = []
	var thePrintedEquation: [String] = []
	//String(s)
	var userInput = ""
	var printToScreen = ""
	//UIButton(s)
	@IBOutlet var insertButton: UIButton!
	@IBOutlet var textInputButton: UIButton!
	//UIImageView
	@IBOutlet var nextKeyboardImageView: UIImageView!
	//UILabel(s)
	@IBOutlet var resultsLabel: Label!
	//UIScrollView(s)
	@IBOutlet var mainScrollView: UIScrollView!
	//UISwipeGestureRecongizer(s)
	var leftSwipe = UISwipeGestureRecognizer()
	var rightSwipe = UISwipeGestureRecognizer()
	//UIView(s)
	@IBOutlet var inputTextOnView: UIView!
	@IBOutlet var inputTextOffView: UIView!
	@IBOutlet var inputTextView: UIView!
	@IBOutlet var mainView: UIView!
	
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	override func updateViewConstraints() 
	{
		super.updateViewConstraints()
		

		
	}
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		let nib		= UINib( nibName: "KeyboardView", bundle: nil )
		let objects = nib.instantiateWithOwner( self, options: nil )
		
		view = objects[0] as! UIView;
		
		//Add image to keyboard
		self.nextKeyboardImageView.image	   = UIImage(named: "global.png" )
		self.nextKeyboardImageView.contentMode = UIViewContentMode.ScaleAspectFit
		self.view.addSubview( self.nextKeyboardImageView )
		
//		//Adds the target to the UISwipeGesture
//		self.rightSwipe.addTarget( self, action: Selector("handleSwipe:"))
//		self.leftSwipe.addTarget( self, action: Selector("handleSwipe:"))
//		self.rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
//		self.leftSwipe.direction  = UISwipeGestureRecognizerDirection.Left
//		
//		//Adding gestureRecognizer to mainView
//		self.mainView.addGestureRecognizer( self.rightSwipe )
//		self.mainView.addGestureRecognizer( self.leftSwipe )
		
		//Rounding the input text buttons
		self.inputTextView.layer.borderColor		= UIColor.blackColor().CGColor
		self.inputTextView.layer.borderWidth		= 1
		self.inputTextView.layer.cornerRadius		= 3
		self.inputTextView.layer.masksToBounds		= true
		self.textInputButton.layer.masksToBounds	= true
		self.inputTextOnView.layer.masksToBounds	= true
		self.inputTextOffView.layer.masksToBounds	= true
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	override func textWillChange( textInput: UITextInput ) 
	{
		// The app is about to change the document's contents. Perform any preparation here.
	}
	
	
	
	func printErrorOut()
	{
		self.resultsLabel.text = "error"
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	func handleSwipe( gesture: UISwipeGestureRecognizer )
	{
		if gesture.direction == UISwipeGestureRecognizerDirection.Left
		{
			self.mainScrollView.setContentOffset( CGPointMake( self.mainScrollView.bounds.width, 0 ), animated: true )
		}
		else if gesture.direction == UISwipeGestureRecognizerDirection.Right
		{
			self.mainScrollView.setContentOffset( CGPointMake( 0, 0 ), animated: true )
			
		}
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	func doMath( newOperator: String )  
	{
		if self.userInput != "" && !self.numberStack.isEmpty 
		{
			var operatorsInStack = self.operatorStack.last
			
			if !((operatorsInStack == "+" || operatorsInStack == "-") && (newOperator == "*" || newOperator == "/" || newOperator == "/?" || newOperator == "%")) 
			{
				var holdingValues = theOperators[operatorStack.removeLast()]
				self.accumulator = holdingValues!(numberStack.removeLast(), accumulator)
				
				self.doEquals()
			}
		}
		
		self.operatorStack.append( newOperator )
		self.numberStack.append( accumulator )
		self.userInput = ""
		self.updateDisplay()
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	func doEquals()
	{
		if self.userInput == "" 
		{
			return
		}
		
		if !self.numberStack.isEmpty 
		{
			var holdingValues = theOperators[self.operatorStack.removeLast()]
			
			self.accumulator = holdingValues!( self.numberStack.removeLast(), self.accumulator )			
			
			if !operatorStack.isEmpty 
			{
				self.doEquals()
			}
		}
		
		self.updateDisplay()
		
		self.userInput = ""
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	func updateDisplay() 
	{
		if self.accumulator == 0.123332101
		{
			self.resultsLabel.text = "error"
		}
		else
		{
			// If the value is an integer, don't show a decimal point
			var iAcc = Int(self.accumulator)
			
			if accumulator - Double(iAcc) == 0 
			{
				self.resultsLabel.text = "\(iAcc)"
			} 
			else 
			{
				self.resultsLabel.text = "\(self.accumulator)"
			}
		}
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	func handleInput( input: String ) 
	{
		if input == "-" 
		{
			if self.userInput.hasPrefix( input ) 
			{
				// Strip off the first character (a dash)
				self.userInput = self.userInput.substringFromIndex( self.userInput.startIndex.successor())
			} 
			else 
			{
				self.userInput = input + self.userInput
			}
		} 
		else 
		{
			self.userInput += input
		}
		
		self.accumulator = Double(( self.userInput as NSString ).doubleValue )
		
		self.updateDisplay()
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	// Looks for a single character in a string.
	func hasIndex( stringToSearch text: String, characterToFind char: Character) -> Bool 
	{
		for theChar in text 
		{
			if theChar == char 
			{
				return true
			}
		}
		return false
	}
	
	
	
	func printTextToScreen( newElement: String )
	{
		if self.textInput
		{
			self.thePrintedEquation.append( newElement )
			
			for items in self.thePrintedEquation
			{
				self.printToScreen = items
			}
			
			( textDocumentProxy as! UIKeyInput ).insertText( self.printToScreen )
		}
	}
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func turnOnOffTestInput( sender: AnyObject ) 
	{
		if self.textInput
		{
			self.textInput = false
			self.inputTextOffView.backgroundColor = UIColor.redColor()
			self.inputTextOnView.backgroundColor = UIColor.whiteColor()
		}
		else
		{
			self.textInput = true
			self.inputTextOnView.backgroundColor = UIColor( red: 92/255, green: 221/255, blue: 103/255, alpha: 1.0 )
			self.inputTextOffView.backgroundColor = UIColor.whiteColor()
		}
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func nextKeyboard( sender: AnyObject ) 
	{
		advanceToNextInputMode()
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func backSpacePressed( button: UIButton ) 
	{
		if self.textInput
		{
			( textDocumentProxy as! UIKeyInput ).deleteBackward()
			//ADD RESULTSLABEL 
		}
		else
		{
			//DELETE JUST ResultsLabel
		}
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func decimalPressed( sender: AnyObject ) 
	{
		if self.hasIndex( stringToSearch: self.userInput, characterToFind: "." ) == false
		{
			self.handleInput( "." )
		}
	}
	
	
	@IBAction func clearAll( sender: AnyObject )
	{		
		self.thePrintedEquation.removeAll()
		self.numberStack.removeAll()
		self.operatorStack.removeAll()
		
		self.oneOverXPressed = false
		self.printToScreen = ""
		self.userInput = ""
		self.accumulator = 0
		self.updateDisplay()
		self.counter = 0
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func changeSignPressed( sender: AnyObject ) 
	{
		if self.userInput.isEmpty 
		{
			self.userInput = self.resultsLabel.text!
		}
		
		self.handleInput("-")
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func insertPressed(sender: AnyObject) 
	{
		
		if !self.textInput
		{
			( textDocumentProxy as! UIKeyInput ).insertText( self.resultsLabel.text! )
		}
	}
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func numberPressed( sender: AnyObject ) 
	{
		if self.counter == 11
		{
			
		}
		else
		{
			self.counter++
			self.handleInput("\(sender.tag)")
			
			if self.textInput
			{			
				self.printTextToScreen("\(sender.tag)")
			}
		}
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func operatorPressed( sender: AnyObject ) 
	{
		self.counter = 0
		
		switch sender.tag
		{
		case 0:
			self.printTextToScreen( "+" )
			self.doMath( "+" )
			
		case 1:
			self.printTextToScreen( "-" )
			self.doMath( "-" )
			
		case 2:
			self.printTextToScreen( "*" )
			self.doMath( "*" )
			
		case 3:
			self.printTextToScreen( "/" )
			self.doMath( "/" )
			
		case 4:
			self.doEquals()
			self.printTextToScreen( "=\(self.resultsLabel.text!)" )
			
		default:
			return
		}
	}
	
	
	@IBAction func otherOperatorsPressed( sender: AnyObject )
	{
		switch sender.tag
		{
		case 0: //X!
			self.doMath( "*" )
			self.handleInput( "\(self.accumulator)" )
			self.doEquals()
			
		case 1: //1/x
			self.doMath( "/?" )
			self.handleInput("2")
			self.doEquals()
			
			
		case 2: //π
			self.printTextToScreen( "\(self.pi)" )
			self.handleInput( "\(self.pi)" )
			
			//		case 3: //10x
			//			self.resultsLabel.text = "sqr(x)"
			//			
			//		case 4: //x^2
			//			self.resultsLabel.text = "x^2"
			//			
			//		case 5: //x^3
			//			self.resultsLabel.text = "x^3"
			
		case 6:
			self.doMath( "%" )
			self.handleInput("100")
			self.doEquals()
			
		default:
			return
		}
	}
	
	
	
	/**************************************************************
	* Addition
	**************************************************************/
	@IBAction func returnPressed(button: UIButton) 
	{
		( textDocumentProxy as! UIKeyInput ).insertText( "\n" )
	}
}