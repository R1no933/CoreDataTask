//
//  AssemblyModule.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 12.09.2022.
//

import UIKit

//MARK: - Protocol's
protocol AssemblyModuleType {
    var storage: StorageType { get }
    
    func createUsersModule(router: UsersRouter) -> UIViewController
    func createDeatilModule(router: UsersRouter, user: User?) -> UIViewController
}

//MARK: - Class
class AssemblyModule: AssemblyModuleType {
    
    //Properrties
    var storage: StorageType = Storage()
    
    //Methods
    func createUsersModule(router: UsersRouter) -> UIViewController {
        let view = UsersViewController()
        let presenter = UserPresenter(view: view, storage: storage, router: router)
        
        view.presenter = presenter
        
        return view
    }
    
    func createDeatilModule(router: UsersRouter, user: User?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailPresenter(view: view, storage: storage, router: router, user: user)
        
        view.presenter = presenter
        
        return view
    }
   
}
