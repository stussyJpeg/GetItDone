
import Foundation
import UIKit

class GDNewItemPopup : GDGradient {
    
    let addButton = GDButton(title: "add", type: .roundedText, radius: 8)
    let cancelButton = GDButton(title: "cancel", type: .roundedText, radius: 8)
    let textField = GDTextField(placeholder: "add some todo...", inset: 4)
    var delegate: GDNewItemDelegate?
    
    @objc func handleAdd() {
        
        if let delegate = self.delegate {
            if let text = textField.text {
                if !text.checkForSpaceOnly() {
                    delegate.addItemToList(text: text)
                }
            }
        }
    }
    
    @objc func handleCancel() {
        textField.resignFirstResponder()
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.setupLayout()
        
        addButton.addTarget(self, action: #selector(self.handleAdd), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(self.handleCancel), for: .touchUpInside)
    }
    
    func setupLayout() {
        
        //cancel button constraints
        self.addSubview(cancelButton)
        cancelButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        cancelButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        //add button constraints
        self.addSubview(addButton)
        addButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        addButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        addButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        
        //textfield
        self.addSubview(textField)
        textField.leftAnchor.constraint(equalTo: self.cancelButton.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: self.addButton.rightAnchor).isActive = true
        textField.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 10).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
