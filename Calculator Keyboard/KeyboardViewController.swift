/***************************************************************
 *  PROJECT: Calc Keyboard
 *	CLASS: KeyboardViewController.swift
 *
 *  Created by Alan Guilfoyle on 7/27/15.
 *  Copyright (c) 2015 Think Thrice Tech. All rights reserved.
 ***************************************************************/

// *** IMPORT(S) *** 
import Darwin
import UIKit
import Swift



//Typealias
typealias holdsValues = ( Double, Double ) -> Double
//Array
let theOperators: [String: holdsValues] = [ "+" : addition, "-" : subtract, "*" : multiply, 
	"/" : divide, "/?" : reciprocal, "%" : percentage ]



/***********************************************************************
 * Addition: Allows for addition of two double numbers
 ***********************************************************************/
func addition( a: Double, b: Double ) -> Double 
{
	var result = a + b
	
	return result
}



/***********************************************************************
 * Subtract: 
 ***********************************************************************/
func subtract(a: Double, b: Double) -> Double 
{
	var result = a - b
	
	return result
}



/***********************************************************************
 * Multiply: 
 ***********************************************************************/
func multiply(a: Double, b: Double) -> Double 
{
	var result = a * b

	return result
}



/***********************************************************************
 * Divide:
 ***********************************************************************/
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



/***********************************************************************
 * Reciprocal:
 ***********************************************************************/
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



/***********************************************************************
 * Percentage
 ***********************************************************************/
func percentage( a: Double, b: Double ) -> Double
{
	var result = a / 100 
	
	return result
}



/***********************************************************************
 * CLASS: KeyboardViewController | CALLS: UILabel
 * PURPOSE: 
 ***********************************************************************/
class Label: UILabel 
{
	override func drawTextInRect(rect: CGRect) 
	{
		super.drawTextInRect(UIEdgeInsetsInsetRect(rect, UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)))
	}
}



/***********************************************************************
* CLASS: KeyboardViewController | CALLS: UIInputViewController
* PURPOSE: 
***********************************************************************/
class KeyboardViewController: UIInputViewController
{
	// *** VARIABLE(S) ***
	//Boolean(s)
	var textInput = true
	//Integer(s)
	var counter = 0
	//Double(s)
	var pi		    : Double = 3.14159265358979
	var accumulator : Double = 0.0
	//Array(s) / Stack(s)
	var numberStack		   : [Double] = []
	var operatorStack	   : [String] = []
	var thePrintedEquation : [String] = []
	//String(s)
	var userInput	  = ""
	var printToScreen = ""
	//UIButton(s)
	@IBOutlet var deleteButton	  : UIButton!
	@IBOutlet var insertButton	  : UIButton!
	@IBOutlet var textInputButton : UIButton!
	//UIImageView
	@IBOutlet var nextKeyboardImageView: UIImageView!
	//UILabel(s)
	@IBOutlet var resultsLabel: Label!
	//UIScrollView(s)
	@IBOutlet var mainScrollView: UIScrollView!
	//UIView(s)
	@IBOutlet var mainView		   : UIView!
	@IBOutlet var inputTextView	   : UIView!
	@IBOutlet var inputTextOnView  : UIView!
	@IBOutlet var inputTextOffView : UIView!
	
	
	

	
	/********************************************************************
	 * METHOD: viewDidLoad | PARAMETERS: none | RETURN: void 
	 * PURPOSE: Called after the controller's view is loaded into memory.
	 ********************************************************************/
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
		
		//Rounding the input text buttons
		self.inputTextView.layer.borderColor		= UIColor.blackColor().CGColor
		self.inputTextView.layer.borderWidth		= 1
		self.inputTextView.layer.cornerRadius		= 3
		self.inputTextView.layer.masksToBounds		= true
		self.textInputButton.layer.masksToBounds	= true
		self.inputTextOnView.layer.masksToBounds	= true
		self.inputTextOffView.layer.masksToBounds	= true
	}
	
	
	
	/********************************************************************
	 * METHOD: updateViewConstraints | PARAMETERS: none | RETURN: void 
	 * PURPOSE: Called when the view controller's view needs to update 
	 *	  its constraints.
	 ********************************************************************/
	override func updateViewConstraints() 
	{
		super.updateViewConstraints()
		
	}
	
	
	
	/*******************************************************************
	 * METHOD: textWillChange | PARAMETERS: UITextInput | RETURN: void 
	 * PURPOSE: Tells the input delegate when text is about to change 
	 *	  in the document. 
	 *******************************************************************/
	override func textWillChange( textInput: UITextInput ) 
	{
		// The app is about to change the document's contents. Perform any preparation here.
	}
	
	
	
	/****************************************************************
	 * METHOD: doMath | PARAMETERS: String | RETURN: void 
	 * PURPOSE: 
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
	
	
	
	/****************************************************************
	* METHOD: backSpacePressed | PARAMETERS: UIButton | RETURN: void 
	**************************************************************/
	func doEquals()
	{
		self.counter = 0
		
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
	
	
	
	/****************************************************************
	* METHOD: backSpacePressed | PARAMETERS: UIButton | RETURN: void 
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
	
	
	
	/****************************************************************
	* METHOD: backSpacePressed | PARAMETERS: UIButton | RETURN: void 
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
	
	
	
	/****************************************************************
	* METHOD: backSpacePressed | PARAMETERS: UIButton | RETURN: void 
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

	

	/****************************************************************
	 * METHOD: backSpacePressed | PARAMETERS: UIButton | RETURN: void 
	 * PURPOSE: 
	 ****************************************************************/
	@IBAction func backSpacePressed( button: UIButton ) 
	{
		( textDocumentProxy as! UIKeyInput ).deleteBackward()
	}
	
	
	
	/****************************************************************
	 * METHOD: decimalPressed | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: 
	 ****************************************************************/
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
	@IBAction func nextKeyboard( sender: AnyObject ) 
	{
		advanceToNextInputMode()
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
	
	
	
	/**************************************************************
	 * Addition
	 **************************************************************/
	@IBAction func otherOperatorsPressed( sender: AnyObject )
	{
		switch sender.tag
		{
		case 0: //X!
			self.printTextToScreen( "²" )
			self.doMath( "*" )
			self.handleInput( "\(self.accumulator)" )
			self.doEquals()
			self.printTextToScreen( "=\(self.resultsLabel.text!)" )
			
		case 1: //1/x
			for( var i = 0; i < self.counter; i++ )
			{
				( textDocumentProxy as! UIKeyInput ).deleteBackward()
			}
			self.printTextToScreen( "1/\(self.userInput)" )
			self.doMath( "/?" )
			self.handleInput("2")
			self.doEquals()
			self.printTextToScreen( "=\(self.resultsLabel.text!)" )
			
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
			self.printTextToScreen( "%100" )
			self.doMath( "%" )
			self.handleInput("100")
			self.doEquals()
			self.printTextToScreen( "=\(self.resultsLabel.text!)" )
			
		default:
			return
		}
	}
	
	
	
	/**************************************************************
	 * Addition
	 **************************************************************/
	func printErrorOut()
	{
		self.resultsLabel.text = "error"
	}
	
	
	
	/**************************************************************
	 * Addition
	 **************************************************************/
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
	@IBAction func returnPressed(button: UIButton) 
	{
		( textDocumentProxy as! UIKeyInput ).insertText( "\n" )
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
}