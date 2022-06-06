//
//  ContactDetailsViewController.swift
//  contactBoook
//
//  Created by Aigerim Abdurakhmanova on 03.06.2022.
//

import UIKit

protocol SendEdittedContact: AnyObject {
    func sendEdittedContact(row: Int, contact: Contact)
    func deleteContact(index: Int)
}

class ContactDetailsViewController: UIViewController, EditContactDetailsDelegate {

    var contact: Contact? {
        didSet{
            guard let contactItem = contact else {return}
            if var name = contactItem.name {
                nameLabel.text = name
                phoneNumberLabel.text = contactItem.phoneNumber
                profileImageView.image = UIImage(named: "\(contactItem.gender!).png")
            }
        }
    }
    
    var index: Int?
    
    weak var editDelegate: SendEdittedContact?
    weak var deleteDelegate: SendEdittedContact?
    
    private let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let containerView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()
    
    private let callButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitle("Call", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemRed
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        view.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneNumberLabel)
        view.addSubview(containerView)
        view.addSubview(callButton)
        view.addSubview(deleteButton)
        setUpConstraints()
    }
    
    @objc private func deleteTapped(){
        deleteDelegate?.deleteContact(index: index!)
        navigationController?.popViewController(animated: true)
    }
    
    private func setUpConstraints() {
        
        profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        containerView.topAnchor.constraint(equalTo: profileImageView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        phoneNumberLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        phoneNumberLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        callButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 450).isActive = true
        callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        callButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: callButton.bottomAnchor, constant: 20).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func setUpNavigation() {
        navigationItem.title = "Contact Details"
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }

    @objc private func editTapped() {
        let vc  = EditContactViewController()
        vc.delegate = self
        vc.contact = contact
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func editedContact(newContact: Contact) {
        contact = newContact
        editDelegate?.sendEdittedContact(row: index!, contact: newContact)
    }
    
}

