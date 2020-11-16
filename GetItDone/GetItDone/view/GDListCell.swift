import UIKit

class GDListCell : UITableViewCell {
    
    let textField = GDTextField(placeholder: "Todo", inset: 6)
    let view : UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        return view
    }()
    
    var toDo: ToDo? {
        didSet {
            if let toDo = toDo {
                self.textField.text = toDo.title
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(view)
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
