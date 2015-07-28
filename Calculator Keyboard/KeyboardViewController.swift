//
//  KeyboardViewController.swift
//  Calculator Keyboard
//
//  Created by Alan Guilfoyle on 7/27/15.
//  Copyright (c) 2015 Think Thrice Tech. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController 
{

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() 
	{
        super.updateViewConstraints()
    
        // Add custom view sizing constraints here
    }

	override func viewDidLoad()
	{
		super.viewDidLoad()

		let nib = UINib(nibName: "KeyboardView", bundle: nil)
		let objects = nib.instantiateWithOwner(self, options: nil)
		
		view = objects[0] as! UIView;
		
	}

    override func textWillChange(textInput: UITextInput) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
}
