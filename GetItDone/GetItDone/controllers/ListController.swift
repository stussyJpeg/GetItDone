import Foundation
import UIKit

class ListController : UIViewController, GDHeaderDelegate, GDNewItemDelegate {
    
    let header = GDHeaderView(title: "Stuff to get done.", subtitle: "left.")
    let popup = GDNewItemPopup()
    let gradient : UIView = {
        var view = GDGradient()
        view.layer.cornerRadius = 20
        return view
    }()
    let listTableView = GDTableView()
    var keyboardHeight: CGFloat = 333
    
    var listData = [
                ToDo(id: 1, title: "first", done: true),
                ToDo(id: 2, title: "second", done: false),
                ToDo(id: 3, title: "third", done: false)
            ]

    let CELL_ID = "cell_id"
    
    // GDNewItemDelegate functions
    func addItemToList(text: String) {
            print("text in textField: \(text)")
        }
    
    // GDHeaderDelegate functions
    func openAddItemPopup() {
        print("trying to popup")
    }
    
    // Keyboard manipulations
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        self.keyboardHeight = keyboardSize.height
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        
        view.addSubview(header)
        header.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        header.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        header.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        header.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
                
        view.addSubview(gradient)
        gradient.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        gradient.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        gradient.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
        gradient.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        gradient.addSubview(listTableView)
        listTableView.leftAnchor.constraint(equalTo: gradient.leftAnchor, constant: 15).isActive = true
        listTableView.rightAnchor.constraint(equalTo: gradient.rightAnchor, constant: -15).isActive = true
        listTableView.topAnchor.constraint(equalTo: gradient.topAnchor, constant: 15).isActive = true
        listTableView.bottomAnchor.constraint(equalTo: gradient.bottomAnchor, constant: -15).isActive = true
        
        
        view.addSubview(popup)
        popup.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        popup.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        popup.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        popup.heightAnchor.constraint(equalToConstant: 85).isActive = true

        // Delegates
        popup.textField.delegate = self
        popup.delegate = self
        header.delegate = self
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(GDListCell.self, forCellReuseIdentifier: CELL_ID)
        
    }    
}


extension ListController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 2, options: .curveEaseIn) {
            self.popup.transform = CGAffineTransform(translationX: 0, y: -self.keyboardHeight)
        } completion: { (_) in }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 2, options: .curveEaseIn) {
            self.popup.transform = CGAffineTransform(translationX: 0, y: 0)
        } completion: { (_) in }
    }
}

extension ListController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! GDListCell
//        cell.textLabel?.text = self.listData[indexPath.row].title
        cell.toDo = self.listData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
