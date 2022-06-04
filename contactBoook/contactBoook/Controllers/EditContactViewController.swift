//
//  EditContactViewController.swift
//  contactBoook
//
//  Created by Айгерим Абдурахманова on 04.06.2022.
//

import UIKit

protocol EditContactDetails: AnyObject {
    func editedContact(row: Int, contact: Contact)
}

class EditContactViewController: UIViewController {
    
    weak var delegate: EditContactDetails?
    var index: Int?
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nameTextField)
        view.addSubview(phoneNumberTextField)
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        selectedGender = genders[0]
        setUpConstraints()
        setUpNaviagtion()
    }
    
    private func setUpConstraints() {
        nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10).isActive = true
        
        phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor).isActive = true
        
        genderPicker.translatesAutoresizingMaskIntoConstraints = false
        genderPicker.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 100).isActive = true
        genderPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        genderPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        genderPicker.heightAnchor.constraint(equalToConstant: view.frame.height * 0.3).isActive = true
        
    }
    
    private func setUpNaviagtion() {
        navigationItem.title = "Edit Contact"
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
    }
    
    @objc private func doneTapped() {
        let vc = ViewController()
        
        guard let name = nameTextField.text, nameTextField.hasText else {
            return
        }
        
        guard let phoneNumber = phoneNumberTextField.text, phoneNumberTextField.hasText else {
            return
        }
        
        let contact = Contact(name: name, phoneNUmber: phoneNumber, image: "\(selectedGender).png", gender: selectedGender ?? "")
        delegate?.editedContact(row: index ?? 0, contact: contact)
        self.navigationController?.pushViewController(vc, animated: true)
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

