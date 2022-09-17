//
//  ViewController.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 09.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties
    lazy var addUserTextField: UITextField = {
        let textField = UITextField()
        
        textField.textAlignment = .center
        textField.placeholder = "Enter name"
        textField.layer.cornerRadius = 10
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var addUserButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.setTitle("Add in list", for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var userTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10
        
        return tableView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        
        configureView()
    }
    
    //MARK: - Lifecycle
    private func configureView() {
        view.addSubview(addUserTextField)
        view.addSubview(addUserButton)
        view.addSubview(containerView)
        containerView.addSubview(userTableView)
        
        NSLayoutConstraint.activate([
            addUserTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            addUserTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addUserTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addUserTextField.heightAnchor.constraint(equalToConstant: 60),
            
            addUserButton.topAnchor.constraint(equalTo: addUserTextField.bottomAnchor, constant: 20),
            addUserButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addUserButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addUserButton.heightAnchor.constraint(equalToConstant: 60),
            
            containerView.topAnchor.constraint(equalTo: addUserButton.bottomAnchor, constant: 30),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            userTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            userTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            userTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -40),
            userTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -200)
        ])
    }
}
