//
//  NSString+TCValidation.swift
//  TCValidationSwiftDemo
//
//  Created by Ismail GULEK on 06/01/2017.
//  Copyright © 2017 Ismail Gulek. All rights reserved.
//

import Foundation

extension String
{
	public func isValidForRegexPattern(pattern: String) -> Bool {
		let expression: NSRegularExpression?
		do {
			expression = try NSRegularExpression.init(pattern: pattern)
			
		} catch {
			return false
		}
		
		let completeRange = NSMakeRange(0, self.lengthOfBytes(using: String.Encoding.utf8))
		let rangeOfFirstMatch = expression!.rangeOfFirstMatch(in: self, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: completeRange)
		
		//	returns true if complete string matches the pattern
		return NSEqualRanges(completeRange, rangeOfFirstMatch)
	}
	
	public func isValidTCNumber() -> Bool {
		
		/*
		 Rules:
		 1. 11 hanelidir.
		 2. Her hanesi rakamsal değer içerir.
		 3. İlk hane 0 olamaz.
		 4. 1. 3. 5. 7. ve 9. hanelerin toplamının 7 katından, 2. 4. 6. ve 8. hanelerin toplamı çıkartıldığında, elde edilen sonucun 10’a bölümünden kalan, yani Mod 10’u bize 10. haneyi verir.
		 5. 1. 2. 3. 4. 5. 6. 7. 8. 9. ve 10. hanelerin toplamından elde edilen sonucun 10’a bölümünden kalan, yani Mod10’u bize 11. haneyi verir.
		*/
		
		//	Rule 1 & 2 & 3
		let pattern = "[1-9][0-9]{10}"
		if !self.isValidForRegexPattern(pattern: pattern) {
			return false
		}
		
		//	preparations
		var digits: [Int] = []
		for i in 0...10 {
			let character = String(self[self.index(self.startIndex, offsetBy: i)])
			digits.append(Int(character)!)
		}
		
		//	Rule 4
		let sumOdd = digits[0] + digits[2] + digits[4] + digits[6] + digits[8]
		let sumEven = digits[1] + digits[3] + digits[5] + digits[7]
		
		let modValue = (sumOdd * 7 - sumEven) % 10
		
		if modValue != digits[9] {
			return false
		}
		
		//	Rule 5
		let sumFirstTen = sumOdd + sumEven + digits[9]
		let modValue2 = sumFirstTen % 10
		if(modValue2 != digits[10])
		{
			return false;
		}
		
		//	all rules applied, receiver is a valid TC number
		return true;
	}
}
