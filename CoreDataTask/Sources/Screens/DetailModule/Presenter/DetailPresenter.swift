//
//  DetailPresenter.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 13.09.2022.
//

import Foundation

//MARK: - Protocols
protocol DetailPresenterType: AnyObject {
    var user: User? { get set }
    
    init(view: DetailViewType, storage: StorageType, router: UsersRouter, user: User?)
    func getUser()
    func updateUser(user: User, name: String?, birth: String?, gender: String?, avatar: Data?)
    func tapBack()
}

//MARK: - Class
class DetailPresenter: DetailPresenterType {
    //Properties
    weak var view: DetailViewType?
    private let storage: StorageType
    private let router: UsersRouter?
    var user: User?
    
    //Init
    required init(view: DetailViewType, storage: StorageType, router: UsersRouter, user: User?) {
        self.view = view
        self.storage = storage
        self.router = router
        self.user = user
    }
    
    //Methods
    func getUser() {
        view?.setUserInfo()
    }
    
    func updateUser(user: User, name: String?, birth: String?, gender: String?, avatar: Data?) {
        storage.updateUser(user, name: name, birth: birth, gender: gender, avatar: avatar)
    }
    
    func tapBack() {
        router?.popToRoot()
    }
    
    
}
