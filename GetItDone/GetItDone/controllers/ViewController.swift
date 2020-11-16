//
//  ViewController.swift
//  GetItDone
//
//  Created by Станислав on 24.10.2020.
//

import UIKit

class ViewController: UIViewController {

    let bg : UIView = {
        var view = GDGradient()
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    //Labels
    
    let titleLabel: UILabel = GDLabel(title: "GET IT DONE", size: 25.0, textAlign: .center)
    let welcomeLabel: UILabel = GDLabel(title: "WELCOME TO THE GET IT DONE APP. \n GET IT DONE IS A TODOLIST. ENJOY IT!", size: 14.0, textAlign: .center)
    let copyrightLabel: UILabel = GDLabel(title: "© 2020 | stussy.jpeg", color: .systemGray, size: 14.0, textAlign: .center)
    
    
    // Buttons
    
    let nextButton: UIButton = GDButton(title: "START WINNING", type: .roundedText)
    
    @objc func animation() {
            
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn) {
                self.nextButton.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
                
            } completion: { (_) in
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                    self.nextButton.transform = CGAffineTransform(scaleX: 1, y: 1)}) {
                        (_) in
                        self.present(ListController(), animated: true, completion: nil)
                    }
            }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        nextButton.addTarget(self, action: #selector(self.animation), for: [.touchUpInside, .touchUpOutside])
        
        // add background subview
        view.addSubview(bg)
        bg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        bg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        bg.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        bg.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        // add title subview
        bg.addSubview(titleLabel)
        titleLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: bg.topAnchor, constant: 60).isActive = true
        
        // add welcome subview
        bg.addSubview(welcomeLabel)
        welcomeLabel.numberOfLines = 2
        welcomeLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        welcomeLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        welcomeLabel.centerYAnchor.constraint(equalTo: bg.centerYAnchor).isActive = true
        
        // add welcome button subview
        bg.addSubview(nextButton)
        nextButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.centerXAnchor.constraint(equalTo: bg.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -60).isActive = true
        
        // add copyright subview
        view.addSubview(copyrightLabel)
        copyrightLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        copyrightLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        copyrightLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }


}

