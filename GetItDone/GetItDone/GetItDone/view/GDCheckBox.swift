//
//  GDCheckBox.swift
//  GetItDone
//
//  Created by Станислав on 17.11.2020.
//

import UIKit

class GDCheckBox : UIButton {
    
    var toggled: Bool? {
        didSet {
            if let toggled = toggled {
                    if toggled {
                        self.backgroundColor = .green
                        self.setBackgroundImage(UIImage(named: "done-icon"), for: .normal)
                    } else {
                        self.backgroundColor = .clear
                        self.setBackgroundImage(UIImage(), for: .normal)
                    }
            }
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.GDPurple.cgColor
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
