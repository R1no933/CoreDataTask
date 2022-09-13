//
//  ViewController.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 09.09.2022.
//

import UIKit

class UsersView: UIView {
    
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
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 10
        
        return tableView
    }()
    
    //MARK: - Inits
    init() {
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    private func configureView() {
        let views = [addUserTextField, addUserButton, containerView]
        views.forEach { addSubview($0) }
        
        containerView.addSubview(userTableView)
        
        NSLayoutConstraint.activate([
            addUserTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.padding),
            addUserTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.padding),
            addUserTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.padding),
            addUserTextField.heightAnchor.constraint(equalToConstant: Metrics.height),
            
            addUserButton.topAnchor.constraint(equalTo: addUserTextField.bottomAnchor, constant: Metrics.padding),
            addUserButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.padding),
            addUserButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.padding),
            addUserButton.heightAnchor.constraint(equalToConstant: Metrics.height),
            
            containerView.topAnchor.constraint(equalTo: addUserButton.bottomAnchor, constant: Metrics.padding),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            userTableView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Metrics.padding),
            userTableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Metrics.padding),
            userTableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Metrics.padding),
            userTableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Metrics.tableViewBottom)
        ])
        
        backgroundColor = .systemBackground
    }
}

//MARK: - Metrics
extension UsersView {
    enum Metrics {
        static let padding: CGFloat = 20
        static let height: CGFloat = 60
        static let tableViewBottom: CGFloat = 200
    }
}
