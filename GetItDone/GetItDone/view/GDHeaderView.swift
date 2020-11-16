//
//  GDHeader.swift
//  GetItDone
//
//  Created by Станислав on 27.10.2020.
//

import Foundation
import UIKit

class GDHeaderView : UIView {
    
    let bg = GDGradient()
    let title = GDLabel(size: 14.0, textAlign: .left)
    let subtitle = GDLabel(size: 24.0, textAlign: .left)
    let addButton = GDButton(type: .squareIcon)
    var delegate: GDHeaderDelegate?
    
    
    @objc func animation() {
            
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn) {
                self.addButton.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
                
            } completion: { (_) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.addButton.transform = CGAffineTransform(scaleX: 1, y: 1)}) {
                        (_) in

                    }
            }
        }
    
    init(frame: CGRect = .zero, title: String = "title", subtitle: String = "subtitle") {
        super.init(frame: frame)
        self.title.text = title
        self.subtitle.text = subtitle
        if self.frame == .zero {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        self.setupLayout()
        addButton.addTarget(self, action: #selector(self.animation), for: .touchUpInside)
    }
    
    func setupLayout() {
        self.addSubview(bg)
        bg.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        bg.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.bg.addSubview(title)
        title.widthAnchor.constraint(equalToConstant: 150).isActive = true
        title.heightAnchor.constraint(equalToConstant: 30).isActive = true
        title.topAnchor.constraint(equalTo: self.bg.topAnchor, constant: 30).isActive = true
        title.centerYAnchor.constraint(equalTo: self.bg.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: self.bg.leftAnchor, constant: 20+8).isActive = true
        title.rightAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        
        self.bg.addSubview(subtitle)
        subtitle.widthAnchor.constraint(equalToConstant: 150).isActive = true
        subtitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        subtitle.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: -20).isActive = true
        subtitle.leftAnchor.constraint(equalTo: self.bg.leftAnchor, constant: 20+8).isActive = true
        subtitle.rightAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        
        self.bg.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: subtitle.bottomAnchor).isActive = true
        addButton.rightAnchor.constraint(equalTo: self.bg.rightAnchor, constant: -20-8).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor, multiplier: 1).isActive = true
        
        addButton.addTarget(self, action: #selector(self.handleAddButton), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc func handleAddButton() {
        if let delegate = self.delegate {
            delegate.openAddItemPopup()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
