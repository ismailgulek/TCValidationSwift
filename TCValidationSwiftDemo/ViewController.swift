//
//  ViewController.swift
//  TCValidationSwiftDemo
//
//  Created by Ismail GULEK on 06/01/2017.
//  Copyright © 2017 Ismail Gulek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak private var tcTextField: UITextField!
	@IBOutlet weak private var resultLabel: UILabel!
	
	//	MARK: - View Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.decideTCValidationResult()
		
		NotificationCenter.default.addObserver(self, selector: #selector(ViewController.textFieldTextDidChange), name: Notification.Name.UITextFieldTextDidChange, object: nil)
	}
	
	//	MARK: - Methods
	
	func textFieldTextDidChange() {
		self.decideTCValidationResult()
	}
	
	private func decideTCValidationResult() {
		let text = self.tcTextField.text
		
		if text != nil && text!.isValidTCNumber() {
			self.resultLabel.textColor = UIColor(red: 86/255.0, green: 147/255.0, blue: 78/255.0, alpha: 1.0)
			self.resultLabel.text = "Valid"
		} else {
			self.resultLabel.textColor = UIColor.red
			self.resultLabel.text = "Not Valid!"
		}
	}
	
	//	MARK: - UITextFieldDelegate
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		return false
	}
	
	//	MARK: - Memory Management
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}

}

