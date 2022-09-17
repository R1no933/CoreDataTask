//
//  Router.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 12.09.2022.
//

import UIKit

//MARK: Protocols
protocol TemplateRouter {
    var navigationController: UINavigationController? { get set }
    var assemblyModule: AssemblyModuleType? { get set}
}

protocol UsersRouter: TemplateRouter {
    func initViewController()
    func showDetailViewController(user: User?)
    func popToRoot()
}

//MARK: - Class
class Router: UsersRouter {
    
    //Properties
    var navigationController: UINavigationController?
    var assemblyModule: AssemblyModuleType?
    
    //Inits
    init(navigationController: UINavigationController, assemblyModule: AssemblyModuleType) {
        self.navigationController = navigationController
        self.assemblyModule = assemblyModule
    }
    
    //Methods
    func initViewController() {
        guard let navigationController = navigationController,
              let userViewController = assemblyModule?.createUsersModule(router: self)
        else { return }
        
        navigationController.viewControllers = [userViewController]

    }
    
    func showDetailViewController(user: User?) {
        guard let navigationController = navigationController,
              let detailViewController = assemblyModule?.createDeatilModule(router: self, user: user)
        else { return }
        
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func popToRoot() {
        guard let navigationController = navigationController else { return }
        navigationController.popToRootViewController(animated: true)
    }
}
