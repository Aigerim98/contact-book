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
    
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Phone Number"
        textField.textAlignment = .left
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Save", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fullNameTextField)
        view.addSubview(phoneNumberTextField)
        view.addSubview(saveButton)
        view.backgroundColor = .white
        setUpConstraints()
    }
    
    @objc private func saveTapped() {
        guard let fullname = fullNameTextField.text, fullNameTextField.hasText else {
            return
        }
        guard let phoneNumber = phoneNumberTextField.text, phoneNumberTextField.hasText else {
            return
        }
        
        let contact = Contact(name: fullname, phoneNUmber: phoneNumber)
        delegate?.addContact(contact: contact)
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpConstraints() {
        fullNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        fullNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        fullNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        fullNameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        //fullNameTextField.becomeFirstResponder()
        
        phoneNumberTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 5).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: fullNameTextField.leadingAnchor).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: fullNameTextField.trailingAnchor).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 100).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: fullNameTextField.leadingAnchor).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: fullNameTextField.trailingAnchor).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
    }
    

}
