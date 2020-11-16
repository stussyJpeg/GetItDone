//
//  GDGradient.swift
//  GetItDone
//
//  Created by Станислав on 24.10.2020.
//

import Foundation
import UIKit

class GDGradient: UIView {
    
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        
        guard let layer = self.layer as? CAGradientLayer else {return}
        layer.colors = [UIColor.GDPurple.cgColor, UIColor.GDGrey.cgColor]
        layer.locations = [0.0, 1.2]
        
    }
    
    override class var layerClass : AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

