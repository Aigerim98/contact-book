//
//  EditContactViewController.swift
//  contactBoook
//
//  Created by Айгерим Абдурахманова on 04.06.2022.
//

import UIKit

protocol EditContactDetailsDelegate: AnyObject {
    func editedContact(newContact: Contact)
}

class EditContactViewController: UIViewController {
    
    weak var delegate: EditContactDetailsDelegate?
    var contact: Contact? {
        didSet{
            guard let contactItem = contact else {return}
            if var name = contactItem.name {
                nameTextField.text = name
                phoneNumberTextField.text = contactItem.phoneNumber
                selectedGender = contactItem.gender
            }
        }
    }
    
    let genders: [String] = ["male", "female"]
    var selectedGender: String?
    
    let genderPicker = UIPickerView()
    
    private let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        //textField.placeholder = "Full Name"
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        //textField.placeholder = "Phone Number"
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(genderPicker)
        
        genderPicker.delegate = self
        genderPicker.dataSource = self
        phoneNumberTextField.delegate = self
        
        setUpConstraints()
        setUpNavigation()
    }
    
    private func setUpConstraints() {
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        
        phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        genderPicker.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 100).isActive = true
        genderPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        genderPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        genderPicker.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3).isActive = true
        
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Edit Contact"
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
    }
    
    @objc private func doneTapped() {
        
        guard let name = nameTextField.text, nameTextField.hasText else {
            return
        }
        
        guard let phoneNumber = phoneNumberTextField.text, phoneNumberTextField.hasText else {
            return
        }
        
        let contact = Contact(name: name, phoneNumber: phoneNumber, image: "\(selectedGender).png", gender: selectedGender)

        delegate?.editedContact(newContact: contact)
        navigationController?.popViewController(animated: true)
    }

    @objc private func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension EditContactViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = genders[row]
        return row
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = genders[row]
    }
}

extension EditContactViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phoneNumberTextField {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

