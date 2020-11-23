//
//  coreDataManager.swift
//  GetItDone
//
//  Created by Станислав on 21.11.2020.
//

import CoreData


struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer : NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GetItDone")
        container.loadPersistentStores { (storeDescrition, err) in
            if let err = err {
                fatalError("Failed: \(err)")
            }
        }
        return container
    }()
    
    func createToDo(id: Double, title: String, done: Bool) {
        let context = persistentContainer.viewContext
        let toDo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
                
        toDo.setValue(id, forKey: "id")
        toDo.setValue(title, forKey: "title")
        toDo.setValue(done, forKey: "done")
        
        do {
            try context.save()
        } catch let err {
            print("Failed! Error: \(err)")
        }
    }
    
    func fetchToDo(title: String) -> ToDo? {
        
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        var toDo: ToDo!
        do {
            let ToDos = try context.fetch(fetchRequest)
            ToDos.forEach { (fetchedToDo) in
                if fetchedToDo.title == title {
                    toDo = fetchedToDo
                }
            }
        } catch let err {
            print("Failed! Error: \(err)")
        }
        return toDo
    }
    
    func deleteToDo(id: Double) {
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        
        do {
            let ToDos = try context.fetch(fetchRequest)
            ToDos.forEach { (toDo) in
                if toDo.id == id {
                    context.delete(toDo)
                }
            }
        } catch let err {
            print("Failed! Error: \(err)")
        }
    }
    
    func fetchToDos() -> [ToDo] {
            let context = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
            
            do {
                let ToDos = try context.fetch(fetchRequest)
                return ToDos
            } catch let err {
                print("Failed! Error: \(err)")
                return []
            }
        }

}
