//
//  DetailViewController.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 13.09.2022.
//

import UIKit

//MARK: - Protocols
protocol DetailViewType: AnyObject {
    func setUserInfo()
}

//MARK: - Class
class DetailViewController: UIViewController, UINavigationControllerDelegate {
    
    //Properties
    var presenter: DetailPresenterType?
    private var selectedAvatar: Data? = nil
    private let genders = ["Your gender", "Male", "Female"]
    private var isEditingMode = false
    private var backButton = UIBarButtonItem()
    private var editButton = UIBarButtonItem()
    private let datePicker = UIDatePicker()
    private let imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        
        picker.sourceType = .savedPhotosAlbum
        picker.allowsEditing = false
        
        return picker
    }()
    
    private var detailView: DetailView? {
        guard isViewLoaded else { return nil }
        return view as? DetailView
    }
    
    //Lifecycle
    override func loadView() {
        view = DetailView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        presenter?.getUser()
    }
    
    //Methods
    //Configure view
    private func configureView() {
        detailView?.userNameTextField.delegate = self
        detailView?.genderTextField.delegate = self
        detailView?.genderPicker.delegate = self
        detailView?.genderPicker.dataSource = self
        detailView?.avatarButton.addTarget(self, action: #selector(avatarButtonTap), for: .touchUpInside)
        imagePicker.delegate = self
        
        configureNavigationBar()
        configureDatePicker()
        configureGenderPicker()
    }
    
    //Configure navigation bar
    private func configureNavigationBar() {
        backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonTap))
        backButton.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal, barMetrics: .default)
        backButton.tintColor = .label
        
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonTap))
        editButton.tintColor = .label
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.rightBarButtonItem = editButton
    }
    
    //Configure date picker
    private func configureDatePicker() {
        let tool = UIToolbar()
        tool.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
        tool.setItems([doneButton], animated: true)
        detailView?.birthTextField.inputAccessoryView = tool
        detailView?.birthTextField.inputView = datePicker
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(choseBirth(datePicker:)), for: UIControl.Event.valueChanged)
    }
    
    //Configure gender picker
    private func configureGenderPicker() {
        let tool = UIToolbar()
        tool.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
        tool.setItems([doneButton], animated: true)
        detailView?.genderTextField.inputAccessoryView = tool
        detailView?.genderTextField.inputView = detailView?.genderPicker
    }
    
    //Objc methods
    //Chose avatar
    @objc private func avatarButtonTap() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Done button
    @objc private func doneButtonTap() {
        self.view.endEditing(true)
    }
    
    //Chose birth
    @objc private func choseBirth(datePicker: UIDatePicker) {
        detailView?.birthTextField.text = datePicker.date.convertToString()
    }
    
    //Back button action
    @objc private func backButtonTap() {
        presenter?.tapBack()
    }
    
    //Edit button action
    @objc private func editButtonTap() {
        let userNameTextField = detailView?.userNameTextField
        let birthTextField = detailView?.birthTextField
        let genderTextField = detailView?.genderTextField
        let avatar = detailView?.avatarButton
        
        func switchMode() {
            isEditingMode.toggle()
            editButton.title = isEditingMode ? "Save" : "Edit"
            backButton.isEnabled.toggle()
            detailView?.backgroundColor = isEditingMode ? .systemGray5 : .systemBackground
            userNameTextField?.isEnabled.toggle()
            birthTextField?.isEnabled.toggle()
            genderTextField?.isEnabled.toggle()
            avatar?.isEnabled.toggle()
        }
        
        switchMode()
        
        if !isEditingMode {
            guard let userName = userNameTextField?.text,
                  !userName.trimmingCharacters(in: .whitespaces).isEmpty else {
                showAlert(title: "Error", message: "Enter the name!")
                switchMode()
                return
            }
            
            presenter?.updateUser(user: presenter?.user! ?? User(), name: userNameTextField?.text, birth: birthTextField?.text, gender: genderTextField?.text, avatar: selectedAvatar)
        }
    }
}

//MARK: - Extensions
extension DetailViewController: DetailViewType {
    func setUserInfo() {
        detailView?.userNameTextField.text = presenter?.user?.name
        detailView?.birthTextField.text = presenter?.user?.birthDay?.convertToString()
        detailView?.genderTextField.text = presenter?.user?.gender
        
        DispatchQueue.main.async {
            if let avatar = self.presenter?.user?.avatar {
                self.detailView?.setAvatar(avatar: avatar)
            }
        }
    }
}

//Text Field delegate
extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//Text field picker delegate & data source
extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    //Data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    //Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard row != 0 else { return }
        detailView?.genderTextField.text = genders[row]
   }
}

//Image Picker delegate
extension DetailViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            showAlert(title: "Error", message: "\(info)")
            return
        }
        
        DispatchQueue.main.async {
            let selectedImage = image.scaleImageSize(imageSize: CGSize(width: 200, height: 200))
            self.selectedAvatar = selectedImage.pngData()
            
            if let avatar = self.selectedAvatar {
                self.detailView?.setAvatar(avatar: avatar)
            }
        }
    }
}
