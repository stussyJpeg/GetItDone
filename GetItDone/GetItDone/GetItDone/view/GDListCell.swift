import UIKit

class GDListCell : UITableViewCell {
    
    var delegate: GDListCellDelegate?
    let textField = GDTextField(placeholder: "Todo", inset: 6)
    var content : String {
        var text = ""
        text = textField.text!
        return text
    }
    let box = GDCheckBox()
    let view : UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    var toDo: ToDo? {
        didSet {
            if let toDo = toDo {
                box.toggled = toDo.done
                self.textField.text = toDo.title
            }
        }
    }
    
    @objc func toggleDone() {
           
        if let delegate = self.delegate, let toDo = self.toDo {
            CoreDataManager.shared.deleteToDo(id: toDo.id)
            CoreDataManager.shared.createToDo(id: toDo.id, title: textField.text!, done: !toDo.done)
            delegate.toggleToDo()
        }
    }
       

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        textField.delegate = self
        
        
        selectionStyle = .none
        backgroundColor = .clear
        
        box.addTarget(self, action: #selector(toggleDone), for: .touchUpInside)
        contentView.addSubview(view)
        view.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
        view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        view.backgroundColor = .white
                
        view.addSubview(textField)
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 6).isActive = true
        textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -6).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        textField.backgroundColor = .white
        
        view.addSubview(box)
        box.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        box.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -14).isActive = true
        box.heightAnchor.constraint(equalToConstant: 25).isActive = true
        box.widthAnchor.constraint(equalTo: box.heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    extension GDListCell : UITextFieldDelegate {
        
        var prevText: String {
            get {
                return textField.text!
            }
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            let text = toDo?.title
            if textField.text == "" {
                textField.text = text
                textField.resignFirstResponder()
            }
            textField.resignFirstResponder()
            return true
        }
    }

    
