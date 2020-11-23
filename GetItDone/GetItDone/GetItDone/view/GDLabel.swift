//
//  GDTitle.swift
//  GetItDone
//
//  Created by Станислав on 24.10.2020.
//

import Foundation
import UIKit

class GDLabel : UILabel {
    
    init(title: String = "default", color: UIColor = .white, size: CGFloat = 16.0,  frame: CGRect = .zero, textAlign: NSTextAlignment = .left) {
        
        super.init(frame: frame)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
            self.text = title
            self.textColor = color
            self.font = UIFont.init(name: "Grandstander-Regular", size: size)
            self.textAlignment = textAlign
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
