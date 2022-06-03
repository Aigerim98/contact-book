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
                profileImageView.image = UIImage(named: contactItem.image ?? "")
            }
        }
    }
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      view.clipsToBounds = true
      return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNaviagtion()
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(profileImageView)
    }
    
    func setUpConstraints() {
        profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
    }
    
    func setUpNaviagtion() {
        navigationItem.title = "Contact Details"
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTapped))
    }

    @objc func editTapped() {
        
    }

}
