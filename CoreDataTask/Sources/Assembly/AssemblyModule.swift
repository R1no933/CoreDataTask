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
}
