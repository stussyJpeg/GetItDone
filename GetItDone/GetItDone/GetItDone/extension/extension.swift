//
//  extension.swift
//  GetItDone
//
//  Created by Станислав on 24.10.2020.
//

import Foundation
import UIKit

extension UIColor {
    
    static let GDBlue = UIColor.systemBlue
    static let GDGrey = UIColor.systemGray
    static let GDPurple = UIColor.systemPurple
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}

extension String {
    func checkForSpaceOnly() -> Bool {
            let text = self
            var counter = 0
            for sub in text {
                if sub == " " {
                    counter += 1
                }
            }
            return text.count == counter
        
    }
}
