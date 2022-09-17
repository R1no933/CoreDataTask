//
//  DetailView.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 13.09.2022.
//

import UIKit

class DetailView: UIView {
    
    //MARK: - Properties
    lazy var avatarButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "avatar-image"), for: .normal)
        button.imageView?.layer.cornerRadius = CGFloat(Metrics.avatarSize / 2)
        button.imageView?.clipsToBounds = true
        button.imageView?.layer.masksToBounds = true
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Enter your name"
        textField.textAlignment = .left
        textField.clearButtonMode = .whileEditing
        textField.setIcon("person")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var birthTextField: UITextField = {
        let textField = UITextField()
        
        textField.textAlignment = .left
        textField.placeholder = "Enter your birth date"
        textField.setIcon("calendar")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var genderTextField: UITextField = {
        let textField = UITextField()
        
        textField.placeholder = "Choose your gender"
        textField.textAlignment = .left
        textField.setIcon("person.2.circle")
        textField.borderStyle = .roundedRect
        textField.isEnabled = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    lazy var genderPicker: UIPickerView = {
        UIPickerView()
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
        let views = [avatarButton, userNameTextField, birthTextField, genderTextField]
        views.forEach { addSubview($0) }
        
        let fieldViews = [userNameTextField, birthTextField, genderTextField]
        for view in fieldViews {
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Metrics.fieldsPadding),
                view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Metrics.fieldsPadding),
                view.heightAnchor.constraint(equalToConstant: Metrics.fieldsHeight),
            ])
        }
        
        NSLayoutConstraint.activate([
            avatarButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Metrics.avatarTop),
            avatarButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            avatarButton.heightAnchor.constraint(equalToConstant: Metrics.avatarSize),
            avatarButton.widthAnchor.constraint(equalToConstant: Metrics.avatarSize),
            
            userNameTextField.topAnchor.constraint(equalTo: avatarButton.bottomAnchor, constant: Metrics.fieldsTop),
            
            birthTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: Metrics.fieldsTop),
            
            genderTextField.topAnchor.constraint(equalTo: birthTextField.bottomAnchor, constant: Metrics.fieldsTop)
        ])
        
        backgroundColor = .systemBackground
    }
    
    //Set avatar
    func setAvatar(avatar: Data) {
        avatarButton.setImage(UIImage(data: avatar), for: .normal)
        avatarButton.setImage(UIImage(data: avatar), for: .disabled)
    }
}

extension DetailView {
    enum Metrics {
        static let avatarTop: CGFloat = 20
        static let avatarSize: CGFloat = 200
        
        static let fieldsTop: CGFloat = 5
        static let fieldsPadding: CGFloat = 30
        static let fieldsHeight: CGFloat = 60
    }
}
