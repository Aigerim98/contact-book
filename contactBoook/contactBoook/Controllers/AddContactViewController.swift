//
//  AddContactViewController.swift
//  contactBoook
//
//  Created by Aigerim Abdurakhmanova on 02.06.2022.
//

import UIKit

protocol AddContactDelegate: AnyObject {
    func addContact(contact: Contact)
}

class AddContactViewController: UIViewController {

    weak var delegate: AddContactDelegate?
    private let genders: [String] = ["male", "female"]
    private var selectedGender: String?
    
    private let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    private let genderPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fullNameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(saveButton)
        view.addSubview(genderPicker)
        view.backgroundColor = .white
        genderPicker.delegate = self
        genderPicker.dataSource = self
        setUpConstraints()
        selectedGender = genders[0]
    }
    
    @objc private func saveTapped() {
        guard let fullname = fullNameTextField.text, fullNameTextField.hasText else {
            return
        }
        
        guard let phoneNumber = phoneNumberTextField.text, phoneNumberTextField.hasText else {
            return
        }
        
        let contact = Contact(name: fullname, phoneNUmber: phoneNumber,image: "\(selectedGender).png", gender: selectedGender ?? "")
        delegate?.addContact(contact: contact)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpConstraints() {
        fullNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        fullNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        fullNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        fullNameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        phoneNumberTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 5).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: fullNameTextField.leadingAnchor).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: fullNameTextField.trailingAnchor).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        genderPicker.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 50).isActive = true
        genderPicker.leadingAnchor.constraint(equalTo: fullNameTextField.leadingAnchor).isActive = true
        genderPicker.trailingAnchor.constraint(equalTo: fullNameTextField.trailingAnchor).isActive = true
        genderPicker.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        saveButton.topAnchor.constraint(equalTo: genderPicker.bottomAnchor, constant: 100).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: fullNameTextField.leadingAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: fullNameTextField.trailingAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
    }
    
}

extension AddContactViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
