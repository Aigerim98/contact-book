//
//  ContactDetailsViewController.swift
//  contactBoook
//
//  Created by Aigerim Abdurakhmanova on 03.06.2022.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    var contact: Contact? {
        didSet{
            guard let contactItem = contact else {return}
            if let name = contactItem.name {
                nameLabel.text = name
                phoneNumberLabel.text = contactItem.phoneNUmber
                profileImageView.image = UIImage(named: "\(contactItem.gender).png" ?? "")
            }
        }
    }
    
    var index: Int?
    
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
    
    private let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviagtion()
        view.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(phoneNumberLabel)
        view.addSubview(containerView)
        setUpConstraints()
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
    }
    
    private func setUpNaviagtion() {
        navigationItem.title = "Contact Details"
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }

    @objc private func editTapped() {
        let vc  = EditContactViewController()
        vc.index = index
        navigationController?.pushViewController(vc, animated: true)
    }

}
