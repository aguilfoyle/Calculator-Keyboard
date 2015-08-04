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
 * Subtract: Allows for subtraction of two double numbers
 ***********************************************************************/
func subtract(a: Double, b: Double) -> Double 
{
	var result = a - b
	
	return result
}



/***********************************************************************
 * Multiply: Allows for multiplication of two double numbers
 ***********************************************************************/
func multiply(a: Double, b: Double) -> Double 
{
	var result = a * b

	return result
}



/***********************************************************************
 * Divide: Allows for division of two double numbers
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
 * Reciprocal: Takes the reciprocal of given number
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
 * Percentage: Gets the percentage of a number 
 ***********************************************************************/
func percentage( a: Double, b: Double ) -> Double
{
	var result = a / 100 
	
	return result
}



/***********************************************************************
 * CLASS: KeyboardViewController | CALLS: UILabel
 * PURPOSE: Allows the resultsLabel to have an indention of 3 points; 
 *	  It looks cleaner to me. 
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
 * PURPOSE: This class handles the majority of logic for the keyboard
 *	  extension to work properly. 
 ***********************************************************************/
class KeyboardViewController: UIInputViewController
{
	// *** VARIABLE(S) ***
	//Boolean(s)
	var showOnce  = true
	var textInput = true
	var reciprocalHit = false
	//Integer(s)
	var counter		 = 0
	var timerCounter = 0
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
	var previousInput = ""
	//NSTimer
	var showNewButtonOption: NSTimer!
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
	 *		in the document. 
	 *******************************************************************/
	override func textWillChange( textInput: UITextInput ) 
	{
		// The app is about to change the document's contents. Perform any preparation here.
	}
	
	
	
	/***********************************************************************
	 * METHOD: doMath | PARAMETERS: String | RETURN: void 
	 * PURPOSE: This method when called will check if an operation has already
     *		been pressed: If so, it will pass the value before the operation 
	 *		pressed and the values after it was pressed and pass those into
	 *		the correct function. Else, it will just store the values before
	 *		the operation was clicked and the operation that was clicked
	 ***********************************************************************/
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
		
		//Append number and operation to stacks
		self.operatorStack.append( newOperator )
		self.numberStack.append( accumulator )
		//Update everything and delete userInput string
		self.userInput = ""
		self.updateDisplay()
	}
	
	
	
	/***********************************************************************
	 * METHOD: doEquals | PARAMETERS: none | RETURN: void 
	 * PURPOSE: This method when called will perform the equals operation, 
	 *		but there are a number of checks to make sure that the input is 
	 *		validate first. 
	 ***********************************************************************/
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
		
		//Update everything and delete userInput string
		self.updateDisplay()
		self.userInput = ""
	}
	
	
	
	/***********************************************************************
	 * METHOD: handleInput | PARAMETERS: String | RETURN: void 
	 * PURPOSE: This method when called will take the input (if there is input)
	 *		from the previous input key stroke and merge them together into
	 *		a single string to present it to the user so it looks like a 
	 *		continious string of numbers. 
	 ***********************************************************************/
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
	
	
	
	/***********************************************************************
	 * METHOD: hasIndex | PARAMETERS: String & Character | RETURN: Bool 
	 * PURPOSE: This method when called will look for a single character in
	 *		the potentially long string of numbers. If char found then it 
	 *		returns true, else false
	 ***********************************************************************/
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
	
	
	
	/*************************************************************************
	 * METHOD: handleTimer | PARAMETERS: none | RETURN: void 
	 * PURPOSE: This method is called whenever the timer is called; It will 
	 *		call this method every 0.5 seconds. It'll be a total of 1.5 seconds
	 *		before the timer becames invalidated;
	 *************************************************************************/
	func handleTimer()
	{
		if self.timerCounter == 2
		{
			self.updateDisplay()
			self.showNewButtonOption.invalidate()
		}
		else
		{
			self.timerCounter++
		}
	}
	
	
	
	/***************************************************************************
	 * METHOD: printTextToScreen | PARAMETERS: String | RETURN: void 
	 * PURPOSE: This method will be called when a number is pressed or something
	 *		like an operator is pressed and needs to be printed to the screen
	 ***************************************************************************/
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
	
	
	
	/*************************************************************************
	 * METHOD: updateDisplay | PARAMETERS: none | RETURN: void 
	 * PURPOSE: When called this method will first check to make sure that the
	 *		accumulator variable doesn't equal 0.123332101 be/c that means a
	 *		division by zero was tried; Else, it will print to the resultsLabel
	 *		the updated userInput or total from operation;
	 *************************************************************************/
	func updateDisplay()
	{
		if self.accumulator == 0.123332101
		{
			if self.reciprocalHit
			{
				self.resultsLabel.text = "error"
			}
			else
			{
				self.resultsLabel.text = "error"
			}
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

	

	/*************************************************************************
	 * METHOD: backSpacePressed | PARAMETERS: UIButton | RETURN: void 
	 * PURPOSE: This method will be called when the back space button is 
	 *		pressed on keyboard. It will delete a single character from where
	 *		the text was being inputed; 
	 *************************************************************************/
	@IBAction func backSpacePressed( button: UIButton )
	{
		( textDocumentProxy as! UIKeyInput ).deleteBackward()
	}
	
	
	
	/*************************************************************************
	 * METHOD: decimalPressed | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when the decimal button is pressed 
	 *		on keyboard. It will call hasIndex to search for the '.' char and 
	 *		determine to remove or keep it;
	 *************************************************************************/
	@IBAction func decimalPressed( sender: AnyObject ) 
	{
		if self.hasIndex( stringToSearch: self.userInput, characterToFind: "." ) == false
		{
			self.handleInput( "." )
		}
	}
	
	
	
	/*************************************************************************
	 * METHOD: clearAll | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when the "AC" button is pressed on
	 *		the keyboard; This will clear all important variables inorder to
	 *		reset for next calculation;
     *************************************************************************/
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
		self.reciprocalHit = false
	}
	
	
	
	/*************************************************************************
	 * METHOD: changeSignPressed | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when the "+/-" button is pressed on
	 *		the keyboard; This will call 'hasIndex' method and search for the
	 *		'-' char inorder to remove or insert it in the string;
	 *************************************************************************/
	@IBAction func changeSignPressed( sender: AnyObject ) 
	{
		if self.userInput.isEmpty 
		{
			self.userInput = self.resultsLabel.text!
		}
		
		self.handleInput("-")
	}
	
	
	
	/*************************************************************************
	 * METHOD: insertPressed | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when the button above the results
	 *		label is pressed; This will insert the text that is currently on 
	 *		the resultsLabel to the screen;
	 *************************************************************************/
	@IBAction func insertPressed( sender: AnyObject ) 
	{
		if !self.textInput
		{
			( textDocumentProxy as! UIKeyInput ).insertText( self.resultsLabel.text! )
		}
	}
	
	
	
	/***************************************************************************
	 * METHOD: nextKeyboard | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when the '🌐' button is pressed; 
	 *		It will change keyboards from the calculator app to other keyboards;
	 ***************************************************************************/
	@IBAction func nextKeyboard( sender: AnyObject ) 
	{
		advanceToNextInputMode()
	}
	
	
	
	/***************************************************************************
	 * METHOD: numberPressed | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when a number is pressed; It takes the
	 *		tag assigned to each number button which corresponds to the actual 
	 *		number on the button; Limits the user to 12 digits [000,000,000,000]
	 ***************************************************************************/
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
	
	
	
	/***************************************************************************
	 * METHOD: operatorPressed | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when a operation is pressed; It takes
	 *		the tag number assigned to each operation to determine which operation
	 *		was pressed; 
	 ***************************************************************************/
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
	
	
	
	/***************************************************************************
	 * METHOD: otherOperatorsPressed | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when a other (newer) operations are
	 *		pressed; It takes the tag number assigned to each operation to 
	 *		determine which operation was pressed; 
	 ***************************************************************************/
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
			//If: user taps nothing thus it's 1/0 which is an error
			if self.userInput == ""
			{
				//If insertText option is on then insert the operation and result
				if self.textInput
				{
					( textDocumentProxy as! UIKeyInput ).insertText( "1/0=error" )
				}
				
				self.resultsLabel.text = "error"
			}
			else //Else: User taps 1/? with an actual number
			{
				for( var i = 0; i < self.counter; i++ )
				{
					( textDocumentProxy as! UIKeyInput ).deleteBackward()
				}
				self.printTextToScreen( "1/\(self.userInput)" )
				self.doMath( "/?" )
				self.handleInput("2")
				self.doEquals()
				self.printTextToScreen( "=\(self.resultsLabel.text!)" )
			}
			
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
			
		case 6: //%
			self.printTextToScreen( "%100" )
			self.doMath( "%" )
			self.handleInput("100")
			self.doEquals()
			self.printTextToScreen( "=\(self.resultsLabel.text!)" )
			
		default:
			return
		}
	}
	
	
	
	/***************************************************************************
	 * METHOD: returnPressed | PARAMETERS: UIButton | RETURN: void 
	 * PURPOSE: This method will be called when a other (newer) operations are
	 *		pressed; It takes the tag number assigned to each operation to 
	 *		determine which operation was pressed; 
	 ***************************************************************************/
	@IBAction func returnPressed( button: UIButton ) 
	{
		( textDocumentProxy as! UIKeyInput ).insertText( "\n" )
	}	
	
	
	
	/***************************************************************************
	 * METHOD: turnOnOffTestInput | PARAMETERS: AnyObject | RETURN: void 
	 * PURPOSE: This method will be called when the turn On/Off button in the
	 *		top - left of the keyboard is pressed; This controls whether text is
	 *		inserted to the screen at the same time it's inserted onto the 
     *		resultsLabel within the keyboard;
	 ***************************************************************************/
	@IBAction func turnOnOffTestInput( sender: AnyObject ) 
	{
		//If: The textInput is true then that means it can be turned off
		if self.textInput
		{
			self.textInput = false
			self.inputTextOffView.backgroundColor = UIColor.redColor()
			self.inputTextOnView.backgroundColor = UIColor.whiteColor()
			
			if self.showOnce
			{
				self.showNewButtonOption = NSTimer.scheduledTimerWithTimeInterval( 0.6, target: self, selector: Selector("handleTimer"), userInfo: nil, repeats: true )
				self.resultsLabel.text = "Tap To Insert"
			}
			self.showOnce = false
		}
		else //Else: The textInput is off and can be turned on
		{
			self.textInput = true
			self.inputTextOnView.backgroundColor = UIColor( red: 92/255, green: 221/255, blue: 103/255, alpha: 1.0 )
			self.inputTextOffView.backgroundColor = UIColor.whiteColor()
		}
	}
}