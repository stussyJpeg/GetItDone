//
//  GDButton.swift
//  GetItDone
//
//  Created by Станислав on 26.10.2020.
//

import Foundation
import UIKit

class GDButton : UIButton {
    
    var title: String?
    var type: ButtonOptions!
    var radius: CGFloat!
    
    init(title: String = "default text", frame: CGRect = .zero, type: ButtonOptions = .roundedText, radius: CGFloat = 20) {
        super.init(frame: frame)
        if frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        self.title = title
        self.type = type
        self.radius = radius
        self.backgroundColor = .white

        //phase two
        if let titleLabel = self.titleLabel {
                    titleLabel.font = UIFont(name: "Grandstander-Regular", size: 16)
                }
        
        switch self.type {
        case ButtonOptions.roundedText:
                self.roundedText()
            case ButtonOptions.squareIcon:
                self.squareIcon()
            default:
                break;
        }
    }
    
    func squareIcon() {
        self.setImage(UIImage(named: "add-icon"), for: .normal)
    }
    
    func roundedText() {
        self.setTitle(self.title, for: .normal)
        self.setTitleColor(.systemPurple, for: .normal)
        self.layer.cornerRadius = self.radius
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
