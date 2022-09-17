//
//  Storage.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 12.09.2022.
//

import CoreData

//MARK: - Protocols
protocol StorageType: AnyObject {
    var allUsers: [User]? { get }
    
    func saveUser(_ name: String)
    func getAllUser() -> [User]?
    func deleteUser(_ user: User)
    func updateUser(_ user: User, name: String?, birth: String?, gender: String?, avatar: Data?)
}

//MARK: - Class
class Storage: StorageType {
    
    //Propertie's
    var allUsers: [User]? {
        getAllUser()
    }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataTask")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(error)")
            }
        }
        return container
    }()
    
    private lazy var context = persistentContainer.viewContext
    
    //Method's
    func saveUser(_ name: String) {
        let newUser = User(context: context)
        newUser.name = name
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func getAllUser() -> [User]? {
        do {
            let request = User.fetchRequest() as NSFetchRequest<User>
            let sort = NSSortDescriptor(key: "name", ascending: true)
            request.sortDescriptors = [sort]
            let users = try context.fetch(request)
            return users
        } catch {
            print(error)
            return nil
        }
    }
    
    func deleteUser(_ user: User) {
        context.delete(user)
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func updateUser(_ user: User, name: String?, birth: String?, gender: String?, avatar: Data?) {
        if let name = name {
            user.name = name
        }
        
        if let birth = birth {
            user.birthDay = birth.convertToDate()
        }
        
        if let gender = gender {
            user.gender = gender
        }
        
        if let avatar = avatar {
            user.avatar = avatar
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}
