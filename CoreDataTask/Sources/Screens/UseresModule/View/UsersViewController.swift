//
//  UsersViewController.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 13.09.2022.
//

import UIKit

//MARK: - Protocols
protocol UsersViewType: AnyObject {
    func updateTableView()
    func addUserButtonTap()
}

//MARK: - Class
class UsersViewController: UIViewController {
    
    //Properties
    var presenter: UsersPresenterType?
    
    private var usersView: UsersView? {
        guard isViewLoaded else { return nil }
        return view as? UsersView
    }
    
    //Lifecycle
    override func loadView() {
        view = UsersView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter?.getAllUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTableView()
    }
    
    //Methods
    private func configureView() {
        title = "Users"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        usersView?.userTableView.delegate = self
        usersView?.userTableView.dataSource = self
        usersView?.userTableView.keyboardDismissMode = .onDrag
        
        usersView?.addUserTextField.delegate = self
        
        usersView?.addUserButton.addTarget(self, action: #selector(addUserButtonTap), for: .touchUpInside)
    }
}

//MARK: - Extensions
//Botton action and upadte table
extension UsersViewController: UsersViewType {
    func updateTableView() {
        DispatchQueue.main.async { self.usersView?.userTableView.reloadData() }
    }
    
    @objc func addUserButtonTap() {
        guard let userName = usersView?.addUserTextField.text,
              !userName.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(title: "Error", message: "Enter the name!")
            return
        }
        presenter?.saveUser(userName)
        usersView?.addUserTextField.text = ""
        usersView?.addUserTextField.resignFirstResponder()
    }
}

//Table view delegate & data source
extension UsersViewController: UITableViewDelegate, UITableViewDataSource {
    //Data sources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = presenter?.users?[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = presenter?.users?[indexPath.row]
        presenter?.userSelected(user: user)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _,_,_ in
            guard let user = self?.presenter?.users?[indexPath.row] else { return }
            self?.presenter?.deleteUser(user)
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}

//Text Field delegate
extension UsersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addUserButtonTap()
        textField.resignFirstResponder()
        return true
    }
}
