//
//  UsersModulePresenter.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 12.09.2022.
//

import Foundation

//MARK: = Protocols
protocol UsersPresenterType: AnyObject {
    var users: [User]? { get }
    
    init(view: UsersViewType, storage: StorageType, router: UsersRouter)
    
    func saveUser(_ name: String)
    func getAllUser()
    func deleteUser(_ user: User)
    func userSelected(user: User?)
}

//MARK: - Class
class UserPresenter: UsersPresenterType {
    
    //Properties
    weak var view: UsersViewType?
    private let storage: StorageType
    private let router: UsersRouter
    var users: [User]?
    
    //Inits
    required init(view: UsersViewType, storage: StorageType, router: UsersRouter) {
        self.view = view
        self.storage = storage
        self.router = router
    }
    
    //Methods
    func saveUser(_ name: String) {
        storage.saveUser(name)
        getAllUser()
    }
    
    func getAllUser() {
        users = storage.getAllUser()
        view?.updateTableView()
    }
    
    func deleteUser(_ user: User) {
        storage.deleteUser(user)
        getAllUser()
    }
    
    func userSelected(user: User?) {
        router.showDetailViewController(user: user)
    }
}
