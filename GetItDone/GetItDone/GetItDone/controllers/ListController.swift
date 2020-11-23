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
    
    var listData = [ToDo]()

    let CELL_ID = "cell_id"
    
    // GDNewItemDelegate functions
    func addItemToList(text: String) {
        listTableView.reloadData()
        popup.textField.text = ""
    }
    
    var popupLocation : CGFloat = 0
    
    func openAddItemPopup() {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.header.addButton.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
                
            } completion: { (_) in
                UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                                self.header.addButton.transform = CGAffineTransform(scaleX: 1, y: 1)}) {
                        (_) in
                    UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
                        if self.popupLocation == 0 {
                            self.popupLocation -= 80
                            self.popup.transform = CGAffineTransform(translationX: 0, y: self.popupLocation)
                        } else {
                            self.popupLocation += 80
                            self.popup.transform = CGAffineTransform(translationX: 0, y: self.popupLocation)
                        }
                           }, completion: nil)
                }}
    }
    
    // Keyboard manipulations
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: Notification) {
        
        let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.size
        self.keyboardHeight = keyboardSize.height
    }
    
    func updateHeaderItemsLeft() {
        header.itemsLeft = 0
        self.listData.forEach { (toDo) in
            if !toDo.done {
                header.itemsLeft += 1
            }
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 2, options: .curveEaseIn, animations: {
            if self.popupLocation == 0 {
                self.popupLocation -= 80
                self.popup.transform = CGAffineTransform(translationX: 0, y: self.popupLocation)
            } else {
                self.popupLocation += 80
                self.popup.transform = CGAffineTransform(translationX: 0, y: self.popupLocation)
            }
               }, completion: nil)
    }
    
    override func viewDidLoad() {
        
        listData = CoreDataManager.shared.fetchToDos()

        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        popup.addGestureRecognizer(tap)

        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.updateHeaderItemsLeft()
    
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
        popup.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 70).isActive = true
        popup.heightAnchor.constraint(equalToConstant: 85).isActive = true

        
        // Delegates
        popup.textField.delegate = self
        popup.delegate = self
        header.delegate = self
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.register(GDListCell.self, forCellReuseIdentifier: CELL_ID)
        
        
    }    
    var toDoToUpdate: ToDo?
}

extension ListController : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == popup.textField {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 2, options: .curveEaseIn) {
                self.popup.transform = CGAffineTransform(translationX: 0, y: -self.keyboardHeight-80)
            } completion: { (_) in }
        } else {
            self.toDoToUpdate = CoreDataManager.shared.fetchToDo(title: textField.text!)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if popup.textField == textField {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 2, options: .curveEaseIn) {
                self.popup.transform = CGAffineTransform(translationX: 0, y: -80)
            } completion: { (_) in }
        } else {
            if let toDoToUpdate = self.toDoToUpdate {
                CoreDataManager.shared.deleteToDo(id: toDoToUpdate.id)
                CoreDataManager.shared.createToDo(id: toDoToUpdate.id, title: textField.text!, done: toDoToUpdate.done)
            }
        }
    }
}


extension ListController : UITableViewDelegate, UITableViewDataSource, GDListCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        }
        return "Done"
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleForHeader = GDLabel(color: .white, size: 24, frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        if section == 0 {
            titleForHeader.text = "To Do"
        } else {
            titleForHeader.text = "Done"
        }
        return titleForHeader
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        self.listData.forEach { (toDo) in
            if section == 0 && !toDo.done {
                count += 1
            } else if section == 1 && toDo.done {
                count += 1
            }
        }
        return count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath) as! GDListCell
        cell.delegate = self
        var itemsForSection = [ToDo]()
        self.listData.forEach { (toDo) in
            if indexPath.section == 0 && !toDo.done {
                itemsForSection.append(toDo)
            } else if indexPath.section == 1 && toDo.done {
                itemsForSection.append(toDo)
            }
        }
        cell.toDo = itemsForSection[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    //GDListCellDelegate methods
    func toggleToDo() {
//        let newListData = self.listData.map { (toDo) -> ToDo in
//            if toDo.id == updatedToDo.id {
////                let newToDo = ToDo(id: updatedToDo.id, title: updatedToDo.title, done: updatedToDo.done)
////                return newToDo
//            }
//            return toDo
//        }
        self.listData = CoreDataManager.shared.fetchToDos()
        listTableView.reloadData()
        self.updateHeaderItemsLeft()
    }
}
