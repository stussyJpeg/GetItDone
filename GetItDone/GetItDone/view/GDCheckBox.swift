//
//  GDCheckBox.swift
//  GetItDone
//
//  Created by Станислав on 14.11.2020.
//

import UIKit

class GDCheckBox : UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        layer.borderColor = UIColor.GDPurple.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
